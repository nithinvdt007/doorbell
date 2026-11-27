# Reproducible Ubuntu flow

Set environment:

```bash
export PDK_ROOT=/home/nithinvdt001/PDKs
export PDK=scl_cp8d
export REF=/home/nithinvdt001/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u
export FRAME_GDS=/home/nithinvdt001/ASIC_Projects/frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds
export KLAYOUT=klayout
export OR=/home/nithinvdt001/Crucible/tools/openroad/26Q3-771-g7cfb2105c9/tool_bin/openroad
export YOSYS=/home/nithinvdt001/Crucible/tools/yosys/0.63.0/tool_bin/yosys
cd <this repo>
```

Full flow:

```bash
./run.sh synth
./run.sh floorplan
./run.sh place
./run.sh cts
./run.sh route
# route stage applies signoff DEF patches, rebuilds ODB and exports netlist
./run.sh gds
./run.sh verify
./run.sh sta
./run.sh spef
$OR -no_splash -exit scripts/write_sdf.tcl
$OR -no_splash -exit scripts/power_report.tcl
```

Simulation:

```bash
iverilog -gspecify -Tmax -o /tmp/rtl.vvp \
  /home/nithinvdt001/PDKs/scl_cp8d/libs.ref/digital_cp8d/verilog/cp8d.v \
  sim/power_pad_models.v rtl/doorbell.v rtl/doorbell_chip.v sim/tb_vcd.v
(cd /tmp && vvp rtl.vvp)

iverilog -gspecify -Tmax -o /tmp/gate.vvp \
  /home/nithinvdt001/PDKs/scl_cp8d/libs.ref/digital_cp8d/verilog/cp8d.v \
  sim/power_pad_models.v results/route_output.v sim/tb_vcd.v
(cd /tmp && vvp gate.vvp)
```

Raw VCD files are kept out of this public handoff; see the rendered SVG simulation summary in `images/`.

