#!/usr/bin/env bash
# Doorbell ASIC v2 flow runner.   ./run.sh <stage>
# stages: prep synth floorplan place cts route sta gds verify   (or: all = prep..route)
# extras: quickcheck [def]   spef   padlvs
set -euo pipefail
cd "$(dirname "$0")"

export PDK_ROOT="${PDK_ROOT:-$HOME/PDKs}"
export PDK="${PDK:-scl_cp8d}"
export SCL_PDK_ROOT="$PDK_ROOT"
OR="${OR:-$HOME/Crucible/tools/openroad/26Q3-771-g7cfb2105c9/tool_bin/openroad}"
YOSYS="${YOSYS:-$HOME/Crucible/tools/yosys/0.63.0/tool_bin/yosys}"
KLAYOUT="${KLAYOUT:-klayout}"
export KLAYOUT
export REF="${REF:-$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u}"
export FRAME_GDS="${FRAME_GDS:-$PWD/../frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds}"
mkdir -p logs results reports libs gds verify

need() { local f; for f in "$@"; do [ -s "$f" ] || { echo "MISSING: $f   (run the previous stage first)"; exit 1; }; done; }

# run_or <name> <script> <marker>   returns 0 only if the marker is in the log and no ERROR lines
run_or() {
    local name=$1 script=$2 marker=$3
    "$OR" -no_splash -exit "$script" > "logs/$name.log" 2>&1 || true
    if grep -q "$marker" "logs/$name.log" && ! grep -q -E '^\[ERROR|^Error:' "logs/$name.log"; then
        echo "OK: $name"; return 0
    fi
    echo "FAILED: $name   (full log: logs/$name.log)"
    grep -E '^\[ERROR|^Error:' "logs/$name.log" | head -5 || true
    tail -8 "logs/$name.log"; return 1
}

count() { local f=$1; [ -f "$f" ] || { echo 999999; return; }; grep -c "violation type" "$f" || true; }

stage=${1:-help}
case "$stage" in
prep)
    [ -d "$PDK_ROOT/$PDK" ]  || { echo "PDK not found at $PDK_ROOT/$PDK"; exit 1; }
    [ -d "$REF/config" ]     || { echo "Reference repo not found at $REF (git clone https://github.com/CRUCIBLE-WORKBENCH/apb-rtl-to-gds-scl-cp8d.git ~/apb-rtl-to-gds-scl-cp8d)"; exit 1; }
    mkdir -p config_ref
    cp "$REF/config/scl_cp8d.tcl" "$REF/config/physical_rules.tcl" "$REF/config/scl_cp8d.sh" config_ref/
    python3 scripts/prep_pdk.py
    echo "OK: prep" ;;
synth)
    need libs/cp8d_core_max.clean.lib libs/cp8d_pads_max.clean.lib rtl/doorbell.v rtl/doorbell_chip.v
    "$YOSYS" -q -s scripts/synth.ys > logs/synth.log 2>&1 || { echo "FAILED: synth"; tail -25 logs/synth.log; exit 1; }
    need results/mapped.v
    echo "OK: synth"; grep -E "Chip area|DFCL11" reports/synthesis_stat.txt | head -4 ;;
floorplan)
    need results/mapped.v libs/pads_cp8d_snapped.lef
    [ -s "$FRAME_GDS" ] || { echo "SCL frame GDS not found: $FRAME_GDS (set FRAME_GDS to the supplied frame file)"; exit 1; }
    [ -s "$PDK_ROOT/$PDK/libs.ref/digital_cp8d/lef/corner_cp8d.lef" ] || { echo "Missing SCL corner LEF: $PDK_ROOT/$PDK/libs.ref/digital_cp8d/lef/corner_cp8d.lef"; exit 1; }
    FRAME="$FRAME_GDS" "$KLAYOUT" -b -r scripts/frame_pads.py > logs/frame_extract.log 2>&1 || {
        echo "FAILED: SCL frame extraction (see logs/frame_extract.log)"
        tail -15 logs/frame_extract.log
        exit 1
    }
    run_or floorplan scripts/floorplan.tcl "CP8D FLOORPLAN COMPLETED" || exit 1 ;;
place)
    need results/floorplan.odb
    run_or placement scripts/placement.tcl "CP8D PLACEMENT COMPLETED" || exit 1 ;;
cts)
    need results/placed.odb
    run_or cts scripts/cts.tcl "CP8D CTS COMPLETED" || exit 1 ;;
route)
    need results/cts.odb
    rm -f reports/route_*.rpt results/route_pass1.* results/route_s*.* results/route.odb results/route.def
    run_or route scripts/route.tcl "CP8D ROUTING PASS1 COMPLETED" || exit 1
    best=route_pass1; bestn=$(count reports/route_pass1.rpt)
    echo "pass 1: $bestn violations"
    if [ "$bestn" -gt 0 ]; then
        for seed in 11 23 5 7; do
            export SEED=$seed
            retry_ok=0
            if run_or "route_s$seed" scripts/retry.tcl "CP8D ROUTING SEED $seed COMPLETED"; then
                retry_ok=1
            fi
            if [ -s "reports/route_s$seed.rpt" ] && [ -s "results/route_s$seed.odb" ] && [ -s "results/route_s$seed.def" ]; then
                if [ "$retry_ok" -eq 0 ]; then
                    echo "WARNING: route_s$seed reported an error after saving complete candidate files; evaluating the saved candidate."
                fi
                n=$(count "reports/route_s$seed.rpt"); echo "seed $seed: $n violations"
                if [ "$n" -lt "$bestn" ]; then bestn=$n; best="route_s$seed"; fi
                [ "$bestn" -eq 0 ] && break
            else
                echo "seed $seed skipped: missing report, ODB, or DEF"
            fi
        done
    fi
    cp "results/$best.odb" results/route.odb; cp "results/$best.def" results/route.def
    run_or finish scripts/finish.tcl "CP8D FINISH COMPLETED" || exit 1
    echo "FINAL ROUTE: $best with $bestn detailed-route violations -> results/route.odb"
    [ "$bestn" -eq 0 ] || echo "WARNING: not clean. Do not stream out for fabrication; see README 'If routing is not clean'." ;;
route-extra)
    need results/route_pass1.odb results/route_pass1.def reports/route_pass1.rpt
    best=route_pass1; bestn=$(count reports/route_pass1.rpt)
    for seed in 7 29 37 41; do
        export SEED=$seed DRT_END_ITER=60
        retry_ok=0
        if run_or "route_s$seed" scripts/retry.tcl "CP8D ROUTING SEED $seed COMPLETED"; then
            retry_ok=1
        fi
        if [ -s "reports/route_s$seed.rpt" ] && [ -s "results/route_s$seed.odb" ] && [ -s "results/route_s$seed.def" ]; then
            if [ "$retry_ok" -eq 0 ]; then
                echo "WARNING: route_s$seed reported an error after saving complete candidate files; evaluating the saved candidate."
            fi
            n=$(count "reports/route_s$seed.rpt")
            echo "seed $seed: $n violations (60 detailed-route iterations)"
            if [ "$n" -lt "$bestn" ]; then bestn=$n; best="route_s$seed"; fi
            [ "$bestn" -eq 0 ] && break
        else
            echo "seed $seed skipped: missing report, ODB, or DEF"
        fi
    done
    for candidate in route_s11 route_s23 route_s5 route_s7 route_s29 route_s37 route_s41; do
        [ -s "reports/$candidate.rpt" ] && [ -s "results/$candidate.odb" ] && [ -s "results/$candidate.def" ] || continue
        n=$(count "reports/$candidate.rpt")
        if [ "$n" -lt "$bestn" ]; then bestn=$n; best=$candidate; fi
    done
    cp "results/$best.odb" results/route.odb
    cp "results/$best.def" results/route.def
    run_or finish scripts/finish.tcl "CP8D FINISH COMPLETED" || exit 1
    echo "BEST ROUTE: $best with $bestn detailed-route violations -> results/route.odb"
    [ "$bestn" -eq 0 ] || echo "WARNING: route still has violations; do not treat as signoff-ready." ;;
sta)
    need results/route.odb
    run_or sta scripts/sta.tcl "=== STA DONE" || exit 1
    python3 scripts/sta_summary.py logs/sta.log ;;
gds)
    need results/route.def libs/pads_cp8d_snapped.lef
    refdir="$PDK_ROOT/$PDK/libs.ref/digital_cp8d"; tech="$PDK_ROOT/$PDK/libs.tech"
    [ -s "$FRAME_GDS" ] || { echo "SCL frame GDS not found: $FRAME_GDS (set FRAME_GDS to the supplied frame file)"; exit 1; }
    mkdir -p gds
    python3 scripts/patch_streamout.py "$REF/10_gds/streamout.py" gds/streamout.py
    cp "$tech/klayout/tech/scl_cp8d.map" gds/layer.map
    awk '$1=="NAME"{split($2,r,"/"); print "NAME " r[1] "/PIN " $3 " " $4}' "$tech/klayout/tech/scl_cp8d.map" >> gds/layer.map
    "$KLAYOUT" -b -r gds/streamout.py \
        -rd input_def="$PWD/results/route.def" -rd output_gds="$PWD/results/doorbell_chip_unframed.gds" \
        -rd tech_lef="$tech/openlane/digital_cp8d/lef/tech_cp8d.lef" -rd cell_lef="$refdir/lef/core_cp8d.lef" \
        -rd cell_gds="$refdir/gds/std_cells_cp8d.gds" -rd layer_map="$PWD/gds/layer.map" \
        -rd work_dir="$PWD/gds" -rd top_cell=doorbell_chip > logs/gds.log 2>&1 || { echo "FAILED: gds"; grep -v -E "No mapping for|FOREIGN name" logs/gds.log | tail -12; exit 1; }
    need results/doorbell_chip_unframed.gds
    FRAME="$FRAME_GDS" CHIP="$PWD/results/doorbell_chip_unframed.gds" OUT="$PWD/results/doorbell_chip.gds" \
        "$KLAYOUT" -b -r scripts/merge_frame.py > logs/frame_merge.log 2>&1 \
        || { echo "FAILED: frame merge (see logs/frame_merge.log)"; tail -12 logs/frame_merge.log; exit 1; }
    need results/doorbell_chip.gds
    echo "OK: gds"; ls -l results/doorbell_chip.gds ;;
verify)
    bash scripts/verify.sh ;;
quickcheck)
    bash scripts/quickcheck.sh "${2:-results/cts.def}" ;;
spef)
    need results/route.odb
    run_or spef scripts/spef.tcl "CP8D SPEF COMPLETED" || exit 1
    python3 scripts/spef_stats.py results/route_rcx.spef ;;
padlvs)
    bash scripts/pad_lvs.sh ;;
lvs-preroute)
    bash scripts/lvs_preroute.sh ;;
all)
    for s in prep synth floorplan place cts route; do "$0" "$s"; done ;;
*)
    sed -n '2,3p' "$0" ;;
esac
