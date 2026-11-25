# Flow guide

This repository contains a reproducible RTL-to-GDS flow for the Doorbell ASIC using the external SCL CP8D PDK and 3 mm pad-frame. PDK libraries and the binary frame stay outside the repository. The supplied frame defines the die, pad sites, pad orientations, and supply geometry; the pad locations in `scripts/frame_pads.tcl` are frame-specific.

## Design inputs

- `rtl/doorbell.v`: synthesizable doorbell logic.
- `rtl/doorbell_chip.v`: chip wrapper and pad-cell connections.
- `constraints/doorbell.sdc`: 5 MHz clock, I/O delays, output loads, and asynchronous input false paths.
- `config_ref/`: project-owned SCL setup that points to PDK files by path. It does not contain the PDK libraries.
- `scripts/`: synthesis, floorplan, placement, clock tree, routing, streamout, timing, and verification steps.

## Run order

Set the locations for the external PDK, reference flow, pad-frame, and tool binaries in WSL. The shell variables can be exported once per terminal:

```bash
export PDK_ROOT="$HOME/PDKs"
export PDK=scl_cp8d
export REF="$HOME/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u"
export FRAME_GDS="$HOME/ASIC_Projects/frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds"
export OR="$HOME/Crucible/tools/openroad/26Q3-771-g7cfb2105c9/tool_bin/openroad"
export YOSYS="$HOME/Crucible/tools/yosys/0.63.0/tool_bin/yosys"
export KLAYOUT=klayout
```

Run one stage at a time from the repository root:

```bash
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

Each stage writes a named log under `logs/`. Routing can take several minutes while the detailed router iterates. Do not run two route jobs in the same results directory.

## What each stage does

1. **prep** — checks external inputs, normalizes local PDK copies used by the run, and prepares the snapped pad LEF. PDK data remains outside Git.
2. **synth** — maps the RTL with Yosys to CP8D cells using the MAX timing library and writes `results/mapped.v` plus `reports/synthesis_stat.txt`.
3. **floorplan** — reads the 3 mm frame, creates die/core and I/O rows, snaps the core to legal sites, places frame-defined pad cells and corners, builds the supply grid, and writes `results/floorplan.odb`.
4. **place** — places the movable standard cells and legalizes them into rows; writes `results/placed.odb`.
5. **cts** — builds the clock tree for the 72 clock sinks, legalizes the buffers, fills rows, and writes `results/cts.odb`.
6. **route** — globally and detailed-routes the design. The selected DEF is then patched by `scripts/apply_signoff_def_fix.py` for the measured SCL reset-width and VDD-rail issues. The patch is scoped and idempotent; it stops if a future router produces different geometry. `scripts/import_signoff_def.tcl` rebuilds the ODB from that exact DEF before `scripts/finish.tcl` exports the matching powered netlist.
7. **sta** — checks setup and hold at the SCL fast and slow Liberty corners using the assumed x1 LEF-derived wire-RC model.
8. **gds** — streams the routed DEF and merges the matching frame to produce the local GDS.
9. **verify** — runs the SCL KLayout DRC and LVS decks against the GDS and powered netlist, then checks VDD/GROUND connectivity and runs IR analysis.

## Floorplan arithmetic

The supplied frame is 3000 × 3000 µm (9.000 mm²). The target core is 1800 µm square, centered in the die:

```text
target lower-left = ((3000 - 1800) / 2, (3000 - 1800) / 2)
                 = (600, 600) µm
target core area = 1800 × 1800 = 3,240,000 µm²
```

The row/site and routing-grid snap gives the actual core box `(600.6, 608.4)–(2398.5, 2382.9) µm`, or 1797.9 × 1774.5 µm = 3,190,373.55 µm². This is 35.45% of the 9 mm² die. The floorplan log reports 70 core rows and 461 core sites per row after alternate-row removal. Pad positions stay on the supplied frame's sites.

## Reading the result files

- `reports/ppa_summary.md`: compact current PPA/signoff summary and limitations.
- `reports/synthesis_stat.txt`: Yosys mapped-cell counts and abstract Liberty area.
- `logs/floorplan.log`, `placement.log`, `cts.log`, and `route.log`: detailed stage output for calculations and decisions.
- `logs/sta.log`: x1 fast/slow setup and hold paths used by `reports/ppa_summary.md`.
- `verify/status.txt`, `drc_summary.txt`, and the two KLayout logs: final DRC/LVS evidence.
- `verify/SIGNOFF_FIX_NOTES.md`: exact DEF geometry corrections and signoff provenance.

The binary GDS/ODB, extracted netlists, DRC databases, and PDK LEF/Liberty/CDL files are local build artifacts and are intentionally excluded from the public repository. The checked fabrication package is in the local FAB_HANDOFF directory.



