# Library and file inventory

This list separates project sources from external technology inputs. The SCL PDK itself is not included or redistributed.

## External SCL CP8D files

From an authorized SCL CP8D 0.8 um digital PDK installation:

- Liberty: libs.ref/digital_cp8d/lib/cp8d_core_min.lib, cp8d_core_typ.lib, cp8d_core_max.lib, cp8d_pads_min.lib, cp8d_pads_typ.lib, cp8d_pads_max.lib.
- LEF: libs.ref/digital_cp8d/lef/tech_cp8d.lef, core_cp8d.lef, pads_cp8d.lef, corner_cp8d.lef.
- Verilog models: libs.ref/digital_cp8d/verilog/cp8d.v.
- CDL: libs.ref/digital_cp8d/cdl/core_iolib_cp8d.cdl.
- Standard-cell GDS used by streamout: libs.ref/digital_cp8d/gds/std_cells_cp8d.gds.
- KLayout technology/signoff: libs.tech/klayout/tech/scl_cp8d.map, scl_cp8d.lyp, scl_cp8d.lyt; libs.tech/klayout/drc/cp8d_drc.drc; libs.tech/klayout/lvs/lvs_os_scl_cp8d.lvs.
- OpenLane routing inputs: libs.tech/openlane/digital_cp8d/lef/tech_cp8d.lef and libs.tech/openlane/tracks.info.
- OpenRCX: libs.tech/openrcx/scl800.rcx.lib. The recorded file has zero coefficients.
- Magic extraction inputs: SCL_CP8D.tech, config/magicrc, and the provider's Magic RC extraction script.

The package structure can vary by release. Check the authorized PDK and its own manual. The PDK payload is not included here.

## Other external dependencies

- Reference flow: CRUCIBLE-WORKBENCH/apb-rtl-to-gds-scl-cp8d, example apb-scl-0.8u; config/scl_cp8d.tcl, config/physical_rules.tcl, config/scl_cp8d.sh, 10_gds/streamout.py, and its verification support.
- Pad frame: frame3mmx3mm.gds and frame3mmx3mm.cdl from the separately supplied frame database.
- Tools: Bash, Python 3, OpenROAD, Yosys, KLayout, Icarus Verilog, and Verilator.

## Project-local generated working libraries

./run.sh prep creates these ignored files from the authorized PDK: libs/cp8d_core_{min,typ,max}.clean.lib, libs/cp8d_pads_{min,typ,max}.clean.lib, and libs/pads_cp8d_snapped.lef.

## Complete tracked project file list

- .gitattributes
- .gitignore
- FLOW.md
- LIBRARY_FILE_INVENTORY.md
- OPEN_ITEMS.md
- README.md
- RESULTS/01_synth.txt
- RESULTS/02_floorplan.txt
- RESULTS/03_placement.txt
- RESULTS/04_cts.txt
- RESULTS/05_route_stage.txt
- RESULTS/06_route_detail.txt
- RESULTS/07_signoff_import.txt
- RESULTS/08_finish.txt
- RESULTS/09_gds.txt
- RESULTS/10_drc_log.txt
- RESULTS/11_lvs_log.txt
- RESULTS/12_status.txt
- RESULTS/13_power_check.txt
- RESULTS/14_sta.txt
- RESULTS/15_spef.txt
- RESULTS/16_rtl_sim.txt
- RESULTS/17_gate_sim.txt
- RESULTS_INDEX.md
- SCL_RC_AND_CHECKLIST.md
- SHA256SUMS.txt
- config_ref/physical_rules.tcl
- config_ref/scl_cp8d.sh
- config_ref/scl_cp8d.tcl
- constraints/doorbell.sdc
- images/simulation.svg
- images/timing.svg
- reports/drc_summary.txt
- reports/ir_real_em.log
- reports/klayout_lvs.log
- reports/power_grid_check.log
- reports/route_output.v
- reports/route_output_pwr.v
- reports/sta.log
- reports/sta_rc_1.0.log
- reports/sta_rc_1.5.log
- reports/sta_rc_2.0.log
- reports/status.txt
- reports/synth.log
- reports/write_sdf_real.log
- rtl/doorbell.v
- rtl/doorbell_chip.v
- run.sh
- scripts/apply_3mm_power_fix.py
- scripts/apply_rst_sync_width_fix.py
- scripts/apply_signoff_def_fix.py
- scripts/common.tcl
- scripts/cts.tcl
- scripts/cts_netlist.tcl
- scripts/drc_bins.py
- scripts/finish.tcl
- scripts/floorplan.tcl
- scripts/frame_geometry.tcl
- scripts/frame_pads.py
- scripts/frame_pads.tcl
- scripts/frame_power.tcl
- scripts/frame_power_geometry.tcl
- scripts/geometry.tcl
- scripts/gnd_straps.tcl
- scripts/import_signoff_def.tcl
- scripts/insert_rst_buffers.tcl
- scripts/ir_real_em.tcl
- scripts/lvs_diag.py
- scripts/merge_frame.py
- scripts/padpower_check.py
- scripts/patch_streamout.py
- scripts/placement.tcl
- scripts/power_pads_gnd.loc
- scripts/power_pads_vdd.loc
- scripts/power_real_pads.tcl
- scripts/power_report.tcl
- scripts/prep_pdk.py
- scripts/render_gds_preview.rb
- scripts/retry.tcl
- scripts/route.tcl
- scripts/rst_buffer_tree.tcl
- scripts/scl_rc_flow.tcl
- scripts/skip_port_nets.tcl
- scripts/spef.tcl
- scripts/spef_stats.py
- scripts/sta.tcl
- scripts/sta_summary.py
- scripts/synth.ys
- scripts/verify.sh
- scripts/write_sdf.tcl
- scripts/write_sdf_real.tcl
- sim/power_pad_models.v
- sim/run_sims.sh
- sim/tb_all.v
- sim/tb_chip.v
- sim/tb_sdf.v
- sim/tb_sdf_real.v
- sim/tb_vcd.v

The current file list includes no .gds or .vcd files. Generated GDS/VCD/SDF/ODB/SPEF and run directories are ignored by Git.
