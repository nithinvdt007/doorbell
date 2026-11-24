# Doorbell CP8D signoff status

Last verified: 2026-11-24 (Asia/Kolkata)

## Physical verification

- SCL DRC: **PASS** — 0 rule violations and 0 guideline findings.
- Full-chip SCL LVS: **PASS** — KLayout reports that the extracted and schematic netlists match.
- Pad locations remain tied to the supplied 3 mm frame; no pad relocation was made.
- The geometry fixes and validation steps are recorded in [verify/SIGNOFF_FIX_NOTES.md](verify/SIGNOFF_FIX_NOTES.md).

The user-provided KLayout view is preserved at [evidence/doorbell_chip_klayout_screenshot.png](evidence/doorbell_chip_klayout_screenshot.png).

## Timing estimate

OpenROAD STA was run on `results/route.odb` at typ, max, and min corners, with the flow's assumed LEF-derived wire RC model. The x2 and x4 rows are sensitivity checks, not foundry RC corners.

| Wire RC scale | Corner | Setup slack (ns) | Hold slack (ns) |
|---|---|---:|---:|
| x1 | typ | 152.51 | 3.57 |
| x1 | max | 140.84 | 6.57 |
| x1 | min | 167.48 | 1.95 |
| x2 | typ | 88.89 | 4.02 |
| x2 | max | 100.02 | 7.41 |
| x2 | min | 92.48 | 2.43 |
| x4 | typ | -224.07 | 4.95 |
| x4 | max | 2.80 | 7.84 |
| x4 | min | -951.11 | 2.80 |

Nominal x1 and x2 estimated setup/hold checks pass. The x4 sensitivity run has setup violations in typ and min. The available RC extraction coefficients do not provide a validated foundry wire-capacitance model, so these results are estimates, not foundry signoff timing.

## Public repository contents

The project `.gitignore` excludes generated physical databases and layouts because they contain PDK cell geometry. This update includes the user-provided screenshot, but leaves the binary GDS and generated full-resolution layout preview local.

