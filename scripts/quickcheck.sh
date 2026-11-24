#!/usr/bin/env bash
# Fast geometry check WITHOUT signal routing: stream a DEF to GDS and run SCL's DRC deck.
# Shows power grid, pad ring, filler and cell-abutment problems in minutes instead of
# after an hour of routing.  Usage: ./run.sh quickcheck [def]   (default results/cts.def)
set -uo pipefail
cd "$(dirname "$0")/.."
: "${PDK_ROOT:?PDK_ROOT is not set (run through ./run.sh quickcheck)}"
KLAYOUT="${KLAYOUT:-klayout}"
REF="${REF:-$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u}"
def="${1:-results/cts.def}"
[ -s "$def" ] || { echo "MISSING: $def (run the stages up to cts first)"; exit 1; }
FRAME_GDS="${FRAME_GDS:-$PWD/../frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds}"
[ -s "$FRAME_GDS" ] || { echo "SCL frame GDS not found: $FRAME_GDS (set FRAME_GDS to the supplied frame file)"; exit 1; }
source config_ref/scl_cp8d.sh
scl_require "$scl_drc_deck"
refdir="$PDK_ROOT/${PDK:-scl_cp8d}/libs.ref/digital_cp8d"; tech="$PDK_ROOT/${PDK:-scl_cp8d}/libs.tech"
mkdir -p gds verify/quick

python3 scripts/patch_streamout.py "$REF/10_gds/streamout.py" gds/streamout.py > /dev/null
cp "$tech/klayout/tech/scl_cp8d.map" gds/layer.map
awk '$1=="NAME"{split($2,r,"/"); print "NAME " r[1] "/PIN " $3 " " $4}' "$tech/klayout/tech/scl_cp8d.map" >> gds/layer.map

echo "== streaming $def to GDS =="
"$KLAYOUT" -b -r gds/streamout.py \
    -rd input_def="$PWD/$def" -rd output_gds="$PWD/results/quick_unframed.gds" \
    -rd tech_lef="$tech/openlane/digital_cp8d/lef/tech_cp8d.lef" -rd cell_lef="$refdir/lef/core_cp8d.lef" \
    -rd cell_gds="$refdir/gds/std_cells_cp8d.gds" -rd layer_map="$PWD/gds/layer.map" \
    -rd work_dir="$PWD/gds" -rd top_cell=doorbell_chip > logs/quick_gds.log 2>&1 \
    || { echo "FAILED: streamout"; grep -v -E "No mapping for|FOREIGN name" logs/quick_gds.log | tail -12; exit 1; }
[ -s results/quick_unframed.gds ] || { echo "FAILED: no unframed GDS written"; exit 1; }

echo "== adding SCL pad-frame power geometry =="
FRAME="$FRAME_GDS" CHIP="$PWD/results/quick_unframed.gds" OUT="$PWD/results/quick.gds" \
    "$KLAYOUT" -b -r scripts/merge_frame.py > logs/quick_frame_merge.log 2>&1 \
    || { echo "FAILED: frame merge"; tail -12 logs/quick_frame_merge.log; exit 1; }
[ -s results/quick.gds ] || { echo "FAILED: no framed GDS written"; exit 1; }

echo "== DRC (SCL deck) =="
rm -f verify/quick/scl_drc.lyrdb
"$KLAYOUT" -b -r "$scl_drc_deck" -rd input="$PWD/results/quick.gds" -rd top_cell=doorbell_chip \
    -rd report1="$PWD/verify/quick/scl_drc.lyrdb" > verify/quick/klayout_drc.log 2>&1 \
    || echo "DRC run returned an error, see verify/quick/klayout_drc.log"
[ -f verify/quick/scl_drc.lyrdb ] || { echo "FAILED: no DRC report"; exit 1; }
python3 "$REF/11_physical_verification/scripts/summarize_klayout_drc.py" verify/quick/scl_drc.lyrdb | tee verify/quick/summary.txt
python3 scripts/drc_bins.py verify/quick/scl_drc.lyrdb
echo
echo "NOTE: signal nets are not routed here, so this checks geometry only. It is NOT signoff."
