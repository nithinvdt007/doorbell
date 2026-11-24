#!/usr/bin/env bash
# LVS of every SCL pad cell on its own (SCL's deck, pads GDS, I/O CDL). Read-only.
set -uo pipefail
cd "$(dirname "$0")/.."
: "${PDK_ROOT:?PDK_ROOT is not set}"
KLAYOUT="${KLAYOUT:-klayout}"
source config_ref/scl_cp8d.sh
R="$PDK_ROOT/${PDK:-scl_cp8d}/libs.ref/digital_cp8d"
mkdir -p verify/pads; : > verify/pads/summary.txt
for c in BPT101 BPT102 BPT103 BPT201 BPT202 BPT301 BPT302 IPAD00 IPPD00 IPPU00 IPSH00 OTPD01 OTPD02 OTPD03 OTPD04 OTTR01 OTTR02 OTTR03 PVDD01 PVSS01 SPAD00 ASPAD00; do
    "$KLAYOUT" -b -r "$scl_lvs_deck" -rd input="$R/gds/pads_cp8d.gds" -rd top_cell=$c \
        -rd schematic1="$scl_cell_cdl" -rd target_netlist1="$PWD/verify/pads/$c.cir" \
        -rd report="$PWD/verify/pads/$c.lvsdb" > verify/pads/$c.log 2>&1
    if grep -q "Netlists match" verify/pads/$c.log; then r=PASS; else r=FAIL; fi
    printf "%-8s %s\n" "$c" "$r" | tee -a verify/pads/summary.txt
done
