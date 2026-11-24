#!/usr/bin/env bash
# Rebuild the framed GDS from the unframed streamout.
set -euo pipefail
cd "$(dirname "$0")/.."
FRAME_GDS="${FRAME_GDS:-$PWD/../frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds}"
KLAYOUT="${KLAYOUT:-klayout}"
[ -s "$FRAME_GDS" ] || { echo "SCL frame GDS not found: $FRAME_GDS (set FRAME_GDS to the supplied frame file)"; exit 1; }
[ -s results/doorbell_chip_unframed.gds ] || { echo "MISSING results/doorbell_chip_unframed.gds (run ./run.sh gds first)"; exit 1; }
FRAME="$FRAME_GDS" CHIP="$PWD/results/doorbell_chip_unframed.gds" OUT="$PWD/results/doorbell_chip.gds" \
  "$KLAYOUT" -b -r scripts/merge_frame.py > logs/frame_merge.log 2>&1 \
  || { echo "FAILED: frame merge (see logs/frame_merge.log)"; tail -12 logs/frame_merge.log; exit 1; }
echo "framed GDS written to results/doorbell_chip.gds"
