# PPA and signoff summary

**Build:** Doorbell ASIC v2 · SCL CP8D · 3 mm die  
**Evidence date:** 2026-11-24 (Asia/Kolkata) · **STA model:** assumed LEF-derived RC at x1

| PPA / signoff metric | Result |
|---|---:|
| Mapped cells | 392 |
| Total mapped Liberty area | 3,487.77 abstract units |
| Actual snapped core | 1797.9 × 1774.5 µm; 3.1904 mm² |
| Placed standard-cell area | 329,121.6 µm²; 10.3% utilization |
| Routed wire / vias | 138,878 µm / 1,522 |
| Final detailed-route markers | 0 |
| DRC / LVS | PASS: 0 rule violations / PASS: netlists match |
| Power-grid connectivity | PASS: no unconnected VDD or GROUND shapes |
| STA setup / hold | PASS at fast and slow corners using assumed x1 RC |
| Final framed GDS SHA-256 | 9562577bbee66d0ca9bab486826c6d92cadc9dd77a2aae82629cd3a8c2734035 |

## Floorplan, placement, and clock tree

The die is 3000 × 3000 µm (9 mm²). The target core is centered at (600, 600) µm with a nominal size of 1800 × 1800 µm. Row/site and routing-grid snapping gives (600.6, 608.4)–(2398.5, 2382.9) µm, or 1797.9 × 1774.5 µm = 3,190,373.55 µm² (35.45% of the die). The floorplan has 70 core rows and 461 core sites per row after alternate-row removal. Pad locations follow the supplied frame.

The global placer used target density 0.60; this is an optimization target, not final utilization. Detailed placement reports 329,121.6 µm² placed standard-cell area, 10.3% utilization, 11,435 µm total displacement, 225 µm maximum displacement, and legalized HPWL of 89,262.5 µm versus 82,849.0 µm before legalization (+8%).

CTS covers 72 clock sinks with 57 clock buffers and a maximum depth of five levels. It inserted 831 row filler instances.

## Routing and signoff geometry

Final detailed routing reports 138,878 µm total wire (60,151 µm on Metal1 and 78,726 µm on Metal2), 1,522 vias, and zero route markers. The final GDS uses the documented DEF geometry fixes: four VDD followpins were extended to the core-ring straps and two narrow reset-net Metal2 segments were shifted. The final ODB was regenerated from that patched DEF before the powered LVS netlist was exported. See verify/SIGNOFF_FIX_NOTES.md.

## Timing: fast and slow corners

OpenROAD checked setup and hold at the x1 assumed wire-RC model. The PDK max library is the slow corner (4.5 V, 85 °C); the min library is the fast corner (5.5 V, −20 °C). Slack is in ns.

| Corner | Setup slack | Hold slack |
|---|---:|---:|
| Slow (max library) | 140.84 | 6.57 |
| Fast (min library) | 167.48 | 1.95 |

Both setup and hold checks pass at these corners. This is an estimate, not foundry timing signoff: the PDK OpenRCX capacitance coefficients are zero, so the flow uses an assumed wire-RC model based on LEF values. Obtain validated RC data from SCL before claiming foundry signoff.

## Power and verification

- Power-grid connectivity: PASS. check_power_grid -dont_require_terminals reports no unconnected shapes on VDD or GROUND; IR analysis completed for both nets. The GROUND followpins and corner-pad supply connections were fixed in the final DEF. See reports/power_grid_check.log and verify/SIGNOFF_FIX_NOTES.md.
- DRC: PASS — zero rule violations and zero guideline findings.
- LVS: PASS — the extracted full-chip netlist matches the powered schematic netlist.
- Power estimation: no dynamic or leakage estimate was run because there is no activity-based power report.

## Reproduction

Follow docs/FLOW_GUIDE.md. Stage logs are in logs/, synthesis counts are in reports/synthesis_stat.txt, and final DRC/LVS evidence is in verify/.

