#!/usr/bin/env bash
# KLayout DRC and LVS with SCL's own decks (same method as the reference flow's
# 11_physical_verification). Needs results/doorbell_chip.gds and results/route_output_pwr.v.
set -uo pipefail
cd "$(dirname "$0")/.."
: "${PDK_ROOT:?PDK_ROOT is not set (run through ./run.sh verify)}"
KLAYOUT="${KLAYOUT:-klayout}"
REF="${REF:-$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u}"
source config_ref/scl_cp8d.sh
top=doorbell_chip
gds="$PWD/results/doorbell_chip.gds"
netlist="$PWD/results/route_output_pwr.v"
mkdir -p verify

scl_require "$scl_drc_deck" "$scl_lvs_deck" "$scl_cell_cdl" "$scl_verilog2spice"
[ -s "$gds" ] || { echo "MISSING: $gds (run ./run.sh gds)"; exit 1; }
[ -s "$netlist" ] || { echo "MISSING: $netlist (run ./run.sh route)"; exit 1; }

echo "== DRC (SCL deck) =="
rm -f verify/scl_drc.lyrdb
"$KLAYOUT" -b -r "$scl_drc_deck" -rd input="$gds" -rd top_cell="$top" \
    -rd report1="$PWD/verify/scl_drc.lyrdb" > verify/klayout_drc.log 2>&1 || echo "DRC run returned an error, see verify/klayout_drc.log"
if [ -f verify/scl_drc.lyrdb ] && python3 "$REF/11_physical_verification/scripts/summarize_klayout_drc.py" verify/scl_drc.lyrdb > verify/drc_summary.txt; then
    DRC="PASS (0 rule violations)"
else
    DRC="FAIL or no report - read verify/drc_summary.txt and verify/klayout_drc.log"
fi
echo "DRC: $DRC"; head -30 verify/drc_summary.txt 2>/dev/null

echo "== LVS (SCL deck) =="
cp "$scl_cell_cdl" verify/
python3 "$scl_verilog2spice" -spice "verify/$(basename "$scl_cell_cdl")" -verilog "$netlist" \
    -output "verify/$top.cdl" -pos_pwr "$scl_power_net" -neg_pwr "$scl_ground_net" -delimiter \
    > verify/verilog2spice.log 2>&1 || echo "verilog2spice returned an error, see verify/verilog2spice.log"
rm -f "verify/$top.lvsdb" "verify/${top}_extracted.cir"
"$KLAYOUT" -b -r "$scl_lvs_deck" -rd input="$gds" -rd top_cell="$top" \
    -rd schematic1="$PWD/verify/$top.cdl" -rd target_netlist1="$PWD/verify/${top}_extracted.cir" \
    -rd report="$PWD/verify/$top.lvsdb" > verify/klayout_lvs.log 2>&1 || true
if grep -q "Congratulations! Netlists match." verify/klayout_lvs.log; then LVS="PASS (netlists match)"
elif grep -q "Netlists don't match" verify/klayout_lvs.log; then LVS="FAIL (netlists do not match)"
else LVS="UNKNOWN - read verify/klayout_lvs.log"; fi
echo "LVS: $LVS"
printf 'DRC: %s\nLVS: %s\n' "$DRC" "$LVS" > verify/status.txt
case "$DRC$LVS" in *FAIL*|*UNKNOWN*) exit 1;; esac

