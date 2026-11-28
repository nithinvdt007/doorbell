#!/usr/bin/env bash
# Simulation runner for the clean 3 mm build. Run from the project root.
#   bash sim/run_sims.sh rtl     -> RTL testbenches
#   bash sim/run_sims.sh gate    -> routed gate-level netlist equivalence TB
set -u
MODE=${1:-rtl}
ROOT=$(pwd)
PDK_ROOT=${PDK_ROOT:-"$HOME/PDKs"}
PDK=${PDK:-scl_cp8d}
VERILATOR=${VERILATOR:-verilator}
CELLS=${CELLS:-"$PDK_ROOT/$PDK/libs.ref/digital_cp8d/verilog/cp8d.v"}
mkdir -p sim/logs
WORK=$(mktemp -d "${TMPDIR:-/tmp}/doorbell_clean_sim_${MODE}.XXXXXX")
trap 'rm -rf "$WORK"' EXIT
mkdir -p "$WORK/obj_dir"
cp sim/tb_all.v sim/tb_chip.v sim/power_pad_models.v "$WORK/"

build_run() {
  t=$1; shift
  (cd "$WORK" && "$VERILATOR" --binary --timing --trace --top-module "$t" -Wno-fatal -Wno-WIDTH \
     --timescale 1ns/1ps "$@" tb_all.v tb_chip.v \
     --Mdir "obj_dir_$t" -o "${t}_sim" > "build_$t.log" 2>&1)
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "$t BUILD FAILED"; tail -15 "$WORK/build_$t.log" | tee "sim/logs/${MODE}_${t}_build.log"; return 1
  fi
  (cd "$WORK" && "./obj_dir_$t/${t}_sim" > "run_$t.log" 2>&1) || true
  grep -E 'PASS|FAIL|T=|ALL' "$WORK/run_$t.log" > "sim/logs/${MODE}_${t}.log"
  echo "=== $MODE $t ==="
  cat "sim/logs/${MODE}_${t}.log"
}

if [ "$MODE" = rtl ]; then
  cp rtl/doorbell.v rtl/doorbell_chip.v "$WORK/"
  for t in tb_debouncer tb_edge_detector tb_bcd_counter tb_seg7_decoder tb_sleep_fsm tb_doorbell_top tb_chip; do
    build_run "$t" doorbell.v doorbell_chip.v "$CELLS" power_pad_models.v
  done
elif [ "$MODE" = gate ]; then
  cp results/route_output.v "$WORK/"
  # Simulation-only clock-to-Q delay. SCL's Verilog cell models have zero
  # delay, so in Verilator the edge detector samples the new btn_out in the
  # same timestep and misses the rising edge. Real flops have C->Q delay;
  # adding 1 ns to the simulation cell model reproduces that behaviour.
  sed 's/buf (Q, Q_buf);/buf #1 (Q, Q_buf);/g' "$CELLS" > "$WORK/cp8d.v"
  build_run tb_chip route_output.v cp8d.v power_pad_models.v
else
  echo "usage: $0 rtl|gate"; exit 1
fi
echo "SIM_DONE_$MODE"
