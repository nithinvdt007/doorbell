# Doorbell CP8D 3 mm handoff

## PPA snapshot

Recorded results from the supplied logs. RC sweep is first-order estimate, not calibrated extraction.

| Metric | slow corner | fast corner | Evidence |
|---|---:|---:|---|
| Setup slack, x1 estimated RC | +123.83 ns | +147.07 ns | RESULTS/14_sta.txt |
| Hold slack, x1 estimated RC | +5.68 ns | +1.55 ns | RESULTS/14_sta.txt |
| Setup slack, x1.5 RC estimate | +56.96 ns | +56.96 ns | reports/sta_rc_1.5.log |
| Hold slack, x1.5 RC estimate | +3.05 ns | +3.05 ns | reports/sta_rc_1.5.log |
| Setup slack, x2.0 RC estimate | -47.63 ns (fail) | -47.63 ns (fail) | reports/sta_rc_2.0.log |
| Mapped standard-cell area | — | — | 3,498.76 um^2, RESULTS/01_synth.txt |
| Static power-grid estimate | — | — | 19.3 mW, reports/ir_real_em.log |
| Static grid drop | VDD: 2.64 mV | GROUND: 9.35 mV | reports/ir_real_em.log |

The x1.5 fast/slow results are identical, and the sweep logs contain STA-1555 Liberty-name warnings. Confirm corner loading before relying on this sweep. RC unit interpretation is provisional, not foundry extraction. Static power-grid results are not dynamic or leakage power.

## Recorded checks

- DRC: 0 rule violations in the saved report.
- LVS: netlists match in the saved report.
- Power-grid connectivity: VDD and GROUND reported connected.
- Antenna, density, pad ESD acceptance, extracted RC signoff, and timing-annotated GLS remain open. See OPEN_ITEMS.md.

## Contents

- rtl/: design RTL.
- sim/: testbenches and simulation support.
- scripts/: synthesis, physical design, signoff, RC, STA, SDF, and power scripts.
- reports/ and RESULTS/: textual logs and stage summaries.
- images/: rendered timing and simulation summaries.
- FLOW.md: external prerequisites and reproducible commands.
- LIBRARY_FILE_INVENTORY.md: exact project files and external dependencies.
- SCL_RC_AND_CHECKLIST.md: RC assumptions and signoff status.

The licensed SCL PDK and frame GDS/CDL are external inputs. This repository contains no GDS or raw VCD files; generated GDS, VCD, SDF, ODB, SPEF, and run directories are ignored by Git.
