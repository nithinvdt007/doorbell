# Flow logs

Logs are kept by stage so the run can be followed in the same order as `run.sh`.

| Log | Stage and what to look for |
|---|---|
| `reports/synthesis_stat.txt` | Yosys mapped-cell counts and area; the earlier synthesis invocation was quiet and produced an empty `synth.log`. `run.sh synth` now records full Yosys output for future runs. |
| `frame_extract.log` | Reads the supplied 3 mm frame and extracts its pad/power geometry. |
| `floorplan.log` | Die/core boxes, row/site snap, pad coordinates, and power-grid setup. |
| `placement.log` | Global placement, legalization displacement, HPWL, and final placement utilization. |
| `cts.log` | Clock sink count, inserted buffers, tree depth, filler placement, and completion marker. |
| `route.log` | Detailed-router iterations, final wire length by layer, vias, and final OpenROAD violation count. |
| finish.log | Power-grid connectivity checks and powered Verilog export. |
| power_report.log | Final passing OpenROAD connectivity and IR analysis, including power and voltage-drop values. |
| `sta.log` | x1 setup and hold paths at the SCL fast and slow Liberty corners. |
| `gds_signoff_candidate.log` | Streamout log for the patched DEF that was promoted as the signoff GDS. |
| `frame_merge_signoff_candidate.log` | Confirms die/frame bounds and frame labels for that GDS. |

The floorplan, placement, CTS, and routing logs document the route before the small geometry-only signoff edits. The final power-grid checks pass for VDD and GROUND. `verify/SIGNOFF_FIX_NOTES.md` records those edits and shows that the final DEF/ODB, powered netlist, GDS, DRC, and LVS were brought back into alignment. The binary databases and GDS remain local and are excluded from Git.



