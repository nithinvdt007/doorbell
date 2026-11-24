# Signoff fix applied 2026-11-24

## Root cause (VDD / LVS)

`check_power_grid -dont_require_terminals` listed exactly four unconnected
VDD followpins: y = 1090.05, 1140.75, 1799.85, 1850.55 um. Their DEF spans
were `x = 596.8 .. 2402.3 um`, so they reached neither the left core-ring
strap (`x = 590.6 um`) nor the right one (`x = 2408.5 um`). `pdngen` therefore
placed **no via** for these four rails, leaving 54 standard cells on four
isolated VDD islands. KLayout LVS reported them as four unnamed nets with
19/15/11/9 subcircuit pins, plus VDD with 393 pins instead of 447.

Fix applied in `results/route.def`: extend those four followpins to
`x = 585.600 .. 2413.500 um`, matching every other VDD rail.

## Root cause (4 x 10.2.1 Metal2 width markers)

At x ~= 1480.05 and 1339.65 um, an `rst_n_c` metal2 wire ended only 1.3 um
inside the adjacent DFCL11 pin metal2, forming a narrow neck.

Fix applied in `results/route.def`: shift those two wire centerlines +0.700 um
(`1480050 -> 1480750`, `1339650 -> 1340350` DEF units).

## Validation

After re-streaming the patched DEF, merging the frame and running the standard
`./run.sh verify`:

- `verify/drc_summary.txt`: **0 rule violations**, 0 guidelines.
- `verify/klayout_lvs.log`: **"Congratulations! Netlists match."**
- `verify/status.txt`: DRC PASS, LVS PASS.

## Files

- Original outputs preserved as `results/*.pre_signoff_fix`.
- `results/route.odb` has been **regenerated from the patched DEF** using
  `read_def` into a fresh chip (no `link_design` afterwards — that would drop
  the DEF's pad/filler instances, special nets and routing). It has the same
  522 nets / 1284 instances as the original and exports a text-identical
  `route_output_pwr.v`. Original ODB kept as `route.odb.pre_signoff_fix`.
- After the ODB promotion, `scripts/finish.tcl` and `./run.sh verify` were
  re-run: `verify/status.txt` is still DRC PASS / LVS PASS, and the four core
  VDD rails no longer appear in `reports/power_grid_VDD.rpt` (only the four
  frame-corner rectangles remain).
- `scripts/finish.tcl` now runs `check_power_grid -dont_require_terminals`
  before `analyze_power_grid`, so `reports/power_grid_VDD.rpt` and
  `reports/power_grid_GROUND.rpt` are always written.

