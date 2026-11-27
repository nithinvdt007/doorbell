# Results index — RTL to GDS (3 mm, reset-sync candidate)

Trimmed logs, one file per stage. Full scripts are in `scripts/`, full commands in `FLOW.md`. GDS and raw VCD files are omitted; rendered SVG summaries are in `images/.

| File | Stage / meaning |
|---|---|
| `01_synth.txt` | Yosys synthesis summary and cell count |
| `02_floorplan.txt` | Core area, pad ring, PDN setup, floorplan complete |
| `03_placement.txt` | Placement completion |
| `04_cts.txt` | CTS completion |
| `05_route_stage.txt` | Stage wrapper: route pass, retries, signoff patch/ODB import |
| `06_route_detail.txt` | OpenROAD detailed-route convergence and runtime |
| `07_signoff_import.txt` | Patched DEF → ODB import |
| `08_finish.txt` | Power checks and netlist export |
| `09_gds.txt` | Streamout and frame merge |
| `10_drc_log.txt` | KLayout SCL DRC |
| `11_lvs_log.txt` | KLayout SCL LVS |
| `12_status.txt` | Final DRC/LVS status |
| `13_power_check.txt` | Power grid check/analysis log |
| `14_sta.txt` | Post-route STA result (assumed wire RC) |
| `15_spef.txt` | OpenROAD RCX SPEF stats (zero capacitance) |
| `16_rtl_sim.txt` | Chip-level RTL sim (count 1, 2, 3) |
| `17_gate_sim.txt` | Routed gate-level sim (matches RTL with sim-only flop delay) |

Final signoff: DRC 0, LVS match, power connected. Open items: see `OPEN_ITEMS.md`.

Rendered timing and simulation summaries: images/.

