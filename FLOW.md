# Reproducible Ubuntu/WSL flow

## External prerequisites

Use an authorized SCL CP8D 0.8 um digital PDK. It is not distributed here. Also obtain the supplied 3 mm pad-frame GDS/CDL and the CRUCIBLE-WORKBENCH reference flow. Install Bash, Python 3, OpenROAD, Yosys, KLayout, Icarus Verilog, and Verilator.

Set paths for your machine:

```bash
export PDK_ROOT="$HOME/PDKs"
export PDK=scl_cp8d
export REF="$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u"
export FRAME_GDS="/absolute/path/to/frame3mmx3mm.gds"
export OR="/path/to/openroad"
export YOSYS="/path/to/yosys"
export KLAYOUT=klayout
export VERILATOR=verilator
```

If needed, clone the public reference flow:

```bash
git clone https://github.com/CRUCIBLE-WORKBENCH/apb-rtl-to-gds-scl-cp8d.git "$HOME/apb-rtl-to-gds-scl-cp8d"
export REF="$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u"
```

## RTL-to-route and signoff stages

Run from the repository root. Preparation creates ignored PDK-derived local library inputs.

```bash
./run.sh prep
./run.sh synth
./run.sh floorplan
./run.sh place
./run.sh cts
./run.sh route
./run.sh gds
./run.sh verify
./run.sh sta
```

The runner's all target stops after route. GDS, verification, and timing are explicit stages. Generated outputs stay out of Git.

## RC estimate and timing margin

The OpenRCX rule file used in the recorded flow has zero coefficients; its SPEF has zero capacitance. Do not use ./run.sh spef as timing extraction. The supplemental script applies a first-order metal1/metal2 estimate and an RC_SCALE sensitivity margin. The CPERSQDIST unit interpretation remains unconfirmed.

```bash
for scale in 1.0 1.5 2.0; do
  RC_SCALE="$scale" "$OR" -no_splash -exit scripts/scl_rc_flow.tcl > "logs/sta_rc_$scale.log" 2>&1
done
```

This runs global routing and writes results/route_scl_<scale>.spef. It is an estimate, not foundry RC extraction. Review reports/sta_rc_*.log for Liberty warnings and verify the intended min/max corner loading.

## Static IR/EM and SDF

```bash
"$OR" -no_splash -exit scripts/ir_real_em.tcl > logs/ir_real_em.log 2>&1
"$OR" -no_splash -exit scripts/write_sdf_real.tcl > logs/write_sdf_real.log 2>&1
```

Both use the same estimated layer RC. SDF is generated at results/doorbell_chip_real.sdf. Dynamic IR is not run; check fab requirements separately.

## Simulation

```bash
bash sim/run_sims.sh rtl
bash sim/run_sims.sh gate
```

For an Icarus SDF diagnostic, run the SDF script first:

```bash
iverilog -gspecify -Tmax -o /tmp/doorbell_sdf.vvp \
  "$PDK_ROOT/$PDK/libs.ref/digital_cp8d/verilog/cp8d.v" \
  sim/power_pad_models.v results/route_output.v sim/tb_sdf_real.v
vvp /tmp/doorbell_sdf.vvp
```

The saved annotated Icarus run did not pass; the SDF path/cell annotation is not validated. See OPEN_ITEMS.md. The committed reports/route_output.v is the saved netlist snapshot; a fresh route stage writes results/route_output.v.

## Generated files

Git ignores GDS, VCD, SDF, ODB, SPEF, and generated run directories. SVG summaries under images/ are tracked.
