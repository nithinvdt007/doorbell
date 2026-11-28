# Results index

## Core RTL-to-GDS stages

| File | Meaning |
|---|---|
| RESULTS/01_synth.txt | Yosys mapping and cell area |
| RESULTS/02_floorplan.txt | Core, pad ring, PDN and floorplan |
| RESULTS/03_placement.txt | Placement |
| RESULTS/04_cts.txt | Clock-tree synthesis |
| RESULTS/05_route_stage.txt | Routing/retry summary |
| RESULTS/06_route_detail.txt | Detailed-route convergence |
| RESULTS/07_signoff_import.txt | DEF-to-ODB import |
| RESULTS/08_finish.txt | Power connections and netlist export |
| RESULTS/09_gds.txt | Streamout/frame merge summary |
| RESULTS/10_drc_log.txt | KLayout DRC |
| RESULTS/11_lvs_log.txt | KLayout LVS |
| RESULTS/12_status.txt | Recorded DRC/LVS status |
| RESULTS/13_power_check.txt | Power-grid connectivity |
| RESULTS/14_sta.txt | Baseline fast/slow setup and hold |
| RESULTS/15_spef.txt | OpenRCX SPEF; zero wire capacitance |
| RESULTS/16_rtl_sim.txt | RTL simulation summary |
| RESULTS/17_gate_sim.txt | Directed gate simulation summary |

## RC, SDF, and static IR/EM diagnostics

| File | Meaning |
|---|---|
| reports/sta_rc_1.0.log | First-order set_layer_rc sweep at 1.0x |
| reports/sta_rc_1.5.log | First-order set_layer_rc sweep at 1.5x |
| reports/sta_rc_2.0.log | First-order set_layer_rc sweep at 2.0x |
| reports/write_sdf_real.log | SDF generation log using estimated RC |
| reports/ir_real_em.log | Static grid/EM summary using estimated layer R |
| reports/power_grid_check.log | VDD/GROUND connectivity check |
| reports/drc_summary.txt | Recorded DRC result |
| reports/klayout_lvs.log | Recorded LVS result |
| reports/status.txt | Recorded final DRC/LVS status |

The point-level EM current tables and generated SDF remain generated local artifacts. Review SCL_RC_AND_CHECKLIST.md and OPEN_ITEMS.md before interpreting results as signoff.
