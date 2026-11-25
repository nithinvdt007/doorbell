# Doorbell ASIC v2 — SCL CP8D

Followable RTL-to-GDS project for the Doorbell ASIC. The flow uses external SCL CP8D libraries and a supplied 3 mm pad-frame; PDK and generated layout databases are not stored in Git.

![KLayout screenshot of the doorbell chip](evidence/doorbell_chip_klayout_screenshot.png)

## Current result

- SCL DRC: **PASS**, 0 rule violations.
- Full-chip SCL LVS: **PASS**, extracted and schematic netlists match.
- STA at assumed wire RC x1: setup and hold pass at both fast and slow corners.
- Power-grid connectivity: **PASS**, no unconnected VDD or GROUND shapes; IR analysis completed for both nets.
- Dynamic/leakage power was not estimated.

See [reports/ppa_summary.md](reports/ppa_summary.md) for area, floorplan, placement, clock-tree, routing, x1 fast/slow timing, and limits. See [docs/FLOW_GUIDE.md](docs/FLOW_GUIDE.md) for the stage-by-stage calculations and commands. The measured signoff geometry edits are in [verify/SIGNOFF_FIX_NOTES.md](verify/SIGNOFF_FIX_NOTES.md).

## Repository map

| Path | Purpose |
|---|---|
| `rtl/` | Doorbell logic and top-level pad wrapper |
| `constraints/` | Clock and I/O timing constraints |
| `config_ref/` | PDK path setup and project-specific physical rules |
| `scripts/` | Yosys/OpenROAD/KLayout flow scripts, including DEF signoff patch/import |
| `logs/` | One compact stage log per completed flow stage |
| `reports/` | PPA summary and machine-generated area/power-grid reports |
| `verify/` | Final DRC/LVS summaries, logs, and signoff fix notes |
| `evidence/` | User-provided KLayout screenshot |

## Run the flow

Install the external SCL CP8D PDK, the reference flow, the supplied frame GDS, OpenROAD, Yosys, and KLayout. Set their paths in WSL, then run each stage from the repository root:

```bash
export PDK_ROOT="$HOME/PDKs"
export PDK=scl_cp8d
export REF="$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u"
export FRAME_GDS="$HOME/ASIC_Projects/frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds"
export OR="$HOME/Crucible/tools/openroad/26Q3-771-g7cfb2105c9/tool_bin/openroad"
export YOSYS="$HOME/Crucible/tools/yosys/0.63.0/tool_bin/yosys"
export KLAYOUT=klayout

./run.sh prep
./run.sh synth
./run.sh floorplan
./run.sh place
./run.sh cts
./run.sh route
./run.sh sta
./run.sh gds
./run.sh verify
```

`run.sh route` patches the two measured reset-wire necks and four VDD followpins, imports that DEF into the final ODB, then exports the powered LVS netlist. The pad positions remain those defined by the supplied frame. Each stage writes a matching file in `logs/`; detailed stage behavior is documented in the flow guide.

## Local-only physical outputs

The `.gitignore` excludes PDK libraries, ODB/DEF/GDS outputs, extracted circuits, and the full-resolution layout preview because they contain PDK cell geometry. Generate these locally using the flow above. The screenshot in `evidence/` is included as a visual reference.


## Local fabrication handoff

The checked handoff is in the local FAB_HANDOFF directory. All packaged files are listed in and verified against FAB_HANDOFF/SHA256SUMS.txt. The final framed GDS SHA-256 is 9562577bbee66d0ca9bab486826c6d92cadc9dd77a2aae82629cd3a8c2734035. The binary layout and extracted circuit files stay in that local package; the public repository keeps source, flow, summaries, and the visual screenshot.

