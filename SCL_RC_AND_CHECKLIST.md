# RC estimate, timing, IR/EM, and signoff checklist

## Model inputs and limits

CP8D has two routing layers in this flow. The following values are encoded in scripts/scl_rc_flow.tcl and scripts/ir_real_em.tcl. The technology LEF provides one RPERSQ per layer, not a min/typ/max RC corner table.

| Layer/input | Source value | Derived use |
|---|---:|---:|
| metal1 sheet resistance | 0.07 ohm/square | 0.07 / 1.7 / 1000 |
| metal1 area cap field | CPERSQDIST 0.027 | interpreted as fF/um^2; C = (0.027e-3 x 1.7 + 2 x 1e-4) pF/um |
| metal1 edge cap | 1e-4 pF/um per edge | 0.1 fF/um per edge |
| metal2 sheet resistance | 0.04 ohm/square | 0.04 / 2.0 / 1000 |
| metal2 area cap field | CPERSQDIST 0.011 | interpreted as fF/um^2; C = (0.011e-3 x 2.0 + 2 x 1e-4) pF/um |
| metal2 edge cap | 1e-4 pF/um per edge | 0.1 fF/um per edge |
| metal2-to-metal1 via | 0.3375 ohm/cut | script passes 0.3375 / 1000 |
| other recorded values | poly 22 ohm/square; N/P diffusion 33/83 ohm/square; poly contact 5 ohm and metal2 contact 0.15 ohm | not part of this two-metal global-routing model |

The CPERSQDIST interpretation as fF/um^2 is a flow assumption pending written SCL confirmation. A literal pF/um^2 interpretation differs by 1000x. Magic and LEF sheet-R values also differ. Confirm units, actual worst-corner values, via/contact treatment, and capacitance with SCL. RC_SCALE=1.5 is a sensitivity margin, not characterized worst-case RC. No poly capacitance is applied in OpenROAD.

## Recorded RC sweep

Transcribed from saved logs. All sweep logs contain STA-1555 Liberty-name warnings. At x1.5 the fast and slow outputs are identical; verify corner loading before using these as corner signoff.

| RC scale | Slow setup | Slow hold | Fast setup | Fast hold |
|---:|---:|---:|---:|---:|
| 1.0 | +123.17 ns | +3.01 ns | +123.17 ns | +3.01 ns |
| 1.5 | +56.96 ns | +3.05 ns | +56.96 ns | +3.05 ns |
| 2.0 | -47.63 ns (fail) | +3.08 ns | -47.63 ns (fail) | +3.08 ns |

This set_layer_rc sweep differs from baseline STA in RESULTS/14_sta.txt. They must not be combined or called extracted-wire signoff.

## SDF GLS

scripts/write_sdf_real.tcl generates SDF after estimated layer RC and uses -divider .. The saved log ends with SDF_REAL_DONE. The recorded Icarus annotated run did not advance the expected count despite -gspecify. Cell specify paths, model matching, and SDF annotation are not validated.

## Static IR and EM

reports/ir_real_em.log records static analysis with estimated layer resistance and pad locations:

- VDD worst drop 2.64 mV; total grid power 19.3 mW.
- GROUND worst drop 9.35 mV.
- Maximum segment currents: VDD 2.45 mA; GROUND 2.04 mA.

These are model outputs, not foundry IR/EM signoff. The local current-density limits are in mA/um, while these logs report current in mA. Do not compare them without segment-width normalization and confirmation of the applicable SCL rule. Dynamic IR was not run.

## Tapeout checklist status

- DRC: recorded zero rule violations.
- LVS: recorded netlist match.
- Antenna and density: the available deck was reported to lack explicit checks; obtain the current SCL/fab checklist.
- Pad ESD/frame acceptance remains open.
- RC, EM, and SDF results are estimates/diagnostics, not foundry signoff.
