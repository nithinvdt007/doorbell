#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
: "${PDK_ROOT:?PDK_ROOT is not set (run through ./run.sh lvs-preroute)}"
OR="${OR:-$HOME/Crucible/tools/openroad/26Q3-771-g7cfb2105c9/tool_bin/openroad}"
KLAYOUT="${KLAYOUT:-klayout}"
REF="${REF:-$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u}"
FRAME_GDS="${FRAME_GDS:-$PWD/../frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds}"
source config_ref/scl_cp8d.sh
top=doorbell_chip
out=verify/preroute
refdir="$PDK_ROOT/${PDK:-scl_cp8d}/libs.ref/digital_cp8d"
tech="$PDK_ROOT/${PDK:-scl_cp8d}/libs.tech"

for f in results/cts.odb results/cts.def libs/pads_cp8d_snapped.lef "$FRAME_GDS"; do
    [ -s "$f" ] || { echo "MISSING: $f"; exit 1; }
done
scl_require "$scl_lvs_deck" "$scl_cell_cdl" "$scl_verilog2spice"
mkdir -p "$out" gds

"$OR" -no_splash -exit scripts/cts_netlist.tcl > "$out/openroad_netlist.log" 2>&1 || {
    echo "FAILED: pre-route netlist generation (see $out/openroad_netlist.log)"
    tail -20 "$out/openroad_netlist.log"
    exit 1
}
[ -s "$out/cts_output_pwr.v" ] || { echo "FAILED: pre-route power netlist was not generated"; exit 1; }

python3 scripts/patch_streamout.py "$REF/10_gds/streamout.py" gds/streamout.py
cp "$tech/klayout/tech/scl_cp8d.map" gds/layer.map
awk '$1=="NAME"{split($2,r,"/"); print "NAME " r[1] "/PIN " $3 " " $4}' \
    "$tech/klayout/tech/scl_cp8d.map" >> gds/layer.map
"$KLAYOUT" -b -r gds/streamout.py \
    -rd input_def="$PWD/results/cts.def" -rd output_gds="$PWD/$out/doorbell_chip_unframed.gds" \
    -rd tech_lef="$tech/openlane/digital_cp8d/lef/tech_cp8d.lef" -rd cell_lef="$refdir/lef/core_cp8d.lef" \
    -rd cell_gds="$refdir/gds/std_cells_cp8d.gds" -rd layer_map="$PWD/gds/layer.map" \
    -rd work_dir="$PWD/$out/gds_work" -rd top_cell="$top" > "$out/streamout.log" 2>&1 || {
        echo "FAILED: pre-route GDS streamout (see $out/streamout.log)"
        tail -20 "$out/streamout.log"
        exit 1
    }
[ -s "$out/doorbell_chip_unframed.gds" ] || { echo "FAILED: pre-route streamout GDS missing"; exit 1; }
FRAME="$FRAME_GDS" CHIP="$PWD/$out/doorbell_chip_unframed.gds" OUT="$PWD/$out/doorbell_chip.gds" \
    "$KLAYOUT" -b -r scripts/merge_frame.py > "$out/frame_merge.log" 2>&1 || {
        echo "FAILED: pre-route frame merge (see $out/frame_merge.log)"
        tail -20 "$out/frame_merge.log"
        exit 1
    }
[ -s "$out/doorbell_chip.gds" ] || { echo "FAILED: framed pre-route GDS missing"; exit 1; }

cp "$scl_cell_cdl" "$out/"
python3 "$scl_verilog2spice" -spice "$out/$(basename "$scl_cell_cdl")" \
    -verilog "$out/cts_output_pwr.v" -output "$out/$top.cdl" \
    -pos_pwr "$scl_power_net" -neg_pwr "$scl_ground_net" -delimiter \
    > "$out/verilog2spice.log" 2>&1 || {
        echo "FAILED: pre-route Verilog-to-SPICE conversion (see $out/verilog2spice.log)"
        tail -20 "$out/verilog2spice.log"
        exit 1
    }
rm -f "$out/$top.lvsdb" "$out/${top}_extracted.cir"
"$KLAYOUT" -b -r "$scl_lvs_deck" -rd input="$PWD/$out/doorbell_chip.gds" -rd top_cell="$top" \
    -rd schematic1="$PWD/$out/$top.cdl" -rd target_netlist1="$PWD/$out/${top}_extracted.cir" \
    -rd report="$PWD/$out/$top.lvsdb" > "$out/klayout_lvs.log" 2>&1 || {
        echo "LVS engine returned an error; see $out/klayout_lvs.log"
    }
if grep -q "Congratulations! Netlists match." "$out/klayout_lvs.log"; then
    status="PASS (pre-route netlists match)"
elif grep -q "Netlists don't match" "$out/klayout_lvs.log"; then
    status="FAIL (pre-route netlists do not match)"
else
    status="UNKNOWN (read $out/klayout_lvs.log)"
fi
printf '%s\n' "$status" | tee "$out/status.txt"
echo "Pre-route LVS is diagnostic only: CTS DEF has no detailed signal routing."
case "$status" in *FAIL*|*UNKNOWN*) exit 1;; esac
