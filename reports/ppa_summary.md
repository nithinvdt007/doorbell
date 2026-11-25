# PPA and signoff summary

**Build:** Doorbell ASIC v2, SCL CP8D, 3 mm die  
**Evidence date:** 2026-11-24 (Asia/Kolkata)  
**Final checks:** SCL DRC pass, full-chip SCL LVS pass

## Area

| Metric | Result | Source/meaning |
|---|---:|---|
| Mapped cells | 392 | Yosys mapped design, including pad cells |
| Sequential cells | 72 DFCL11 | 527.76 abstract Liberty area units |
| Total mapped Liberty area | 3,487.77 | Abstract Liberty `area`; do not interpret as physical µm² |
| Actual core box | 1797.9 × 1774.5 µm | Grid-snapped box from `logs/floorplan.log` |
| Core area | 3,190,373.55 µm² (3.1904 mm²) | Actual snapped core; 35.45% of the 9 mm² die |
| Placed standard-cell area | 329,121.6 µm² | OpenROAD detailed-placement report; 10.3% reported utilization |

## Placement and clock tree

- The global placer used target density 0.60; this is an optimization target, not the final utilization.
- Detailed placement reported 10.3% utilization, 11,435 µm total displacement, and legalized HPWL of 89,262.5 µm versus 82,849.0 µm before legalization (+8%). Maximum displacement was 225 µm.
- CTS covered 72 clock sinks with 57 clock buffers and a maximum tree depth of five levels. CTS then inserted 831 row filler instances.

## Routing

The final detailed-route completion in `logs/route.log` reports zero OpenROAD route violations:

| Metric | Result |
|---|---:|
| Total routed wire | 138,878 µm |
| Metal1 wire | 60,151 µm |
| Metal2 wire | 78,726 µm |
| Vias | 1,522 |
| Final detailed-route markers | 0 |

The passing GDS also includes the separate, documented geometry patch in `verify/SIGNOFF_FIX_NOTES.md`: four VDD followpins were extended to the core-ring straps, and two narrow reset-net Metal2 segments were shifted. The final ODB was rebuilt from that patched DEF before exporting the powered LVS netlist.

## Timing (assumed wire RC)

OpenROAD checked setup and hold at typ/max/min libraries with the flow's LEF-derived RC estimate. x2 and x4 are sensitivity multipliers of that same assumed model, not foundry RC corners. Slack is in ns; negative setup slack is a violation.

| RC scale | Corner | Setup slack | Hold slack |
|---|---|---:|---:|
| x1 | typ | 152.51 | 3.57 |
| x1 | max | 140.84 | 6.57 |
| x1 | min | 167.48 | 1.95 |
| x2 | typ | 88.89 | 4.02 |
| x2 | max | 100.02 | 7.41 |
| x2 | min | 92.48 | 2.43 |
| x4 | typ | **-224.07** | 4.95 |
| x4 | max | 2.80 | 7.84 |
| x4 | min | **-951.11** | 2.80 |

Nominal x1 and x2 checks meet setup and hold. The x4 sensitivity check has setup violations at typ and min; it is included to show the impact of the uncertain wire RC model. The available SCL OpenRCX capacitance coefficients are zero, so this is an estimate and not foundry signoff timing.

## Power and verification

- **Dynamic/leakage power:** not estimated; this flow has no activity-based power report.
- **Power-grid connectivity:** OpenROAD's terminal check reports PSM-0069 on VDD and GROUND. The four previously isolated core VDD rails are connected after the DEF fix; the remaining VDD markers are frame-corner shapes. The GROUND report contains many physical-only filler terminals. These reports need review and are not represented as a power-grid pass.
- **SCL DRC:** PASS — 0 rule violations and 0 guideline findings.
- **Full-chip SCL LVS:** PASS — extracted and powered schematic netlists match.

## Reproduction

Follow [`docs/FLOW_GUIDE.md`](../docs/FLOW_GUIDE.md). Detailed results are in the stage logs under `logs/`, the synthesis report in this directory, and the final DRC/LVS evidence under `verify/`.

