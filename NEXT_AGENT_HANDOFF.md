# Doorbell CP8D: current investigation handoff

Updated 2026-11-25. This file records the latest state of the copied workspace
`C:\Users\Admin\OneDrive\Documents\New project\doorbell_v3_rebuild_20261124`.

> **RESOLVED later on 2026-11-24:** see `verify/SIGNOFF_FIX_NOTES.md`. The
> promoted `results/doorbell_chip.gds` now passes SCL DRC (0 violations) and
> full-chip LVS (`verify/status.txt`). The status text below is historical.
> STA nominal and 2x wire-RC checks pass; the 4x sensitivity run has setup
> violations. Pad locations remain constrained by the supplied frame and were
> not changed. See `SIGNOFF_STATUS.md` for current evidence.

## Current status (historical, before the fix)

**Not signoff-ready.** The latest completed baseline run has zero OpenROAD detailed-route markers, but the framed GDS still fails SCL DRC and LVS:

- DRC: 4 violations of SCL rule 10.2.1, minimum Metal2 width 2.0 um.
- LVS: 31 library-cell circuit pairs match; the top `doorbell_chip` circuit does not. The top comparison has 5 unmatched nets (four layout-only nets plus VDD) and 63 unmatched subcircuit pairs.
- OpenROAD `check_power_grid` reports PSM-0069 for both `VDD` and `GROUND`. The diagnostic is recorded in `reports/power_grid_check.log`; error reports were not produced.
- The final GDS was regenerated from the selected baseline DEF. Its frame merge validated the expected VDD and GROUND labels on layer 8/7. Labels are present, but their presence does not prove that every physical power shape is connected.

The current passing/failed distinction matters: **0 OpenROAD route markers is not a passing SCL DRC or LVS result.** Do not treat the current GDS as signoff-ready.

## Latest evidence and artifacts

- `verify/status.txt` — latest DRC/LVS status.
- `verify/drc_summary.txt`, `verify/scl_drc.lyrdb`, `verify/klayout_drc.log` — latest SCL DRC results.
- `verify/klayout_lvs.log`, `verify/doorbell_chip.lvsdb`, `verify/doorbell_chip.cdl`, `verify/doorbell_chip_extracted.cir`, `verify/lvs_diagnostics.txt` — latest LVS inputs and diagnostics.
- `reports/route_pass1.rpt`, `logs/route.log`, `results/route_pass1.{odb,def}`, `results/route.{odb,def}` — selected baseline route. The log reports `pass 1: 0 violations`.
- `results/route_output_pwr.v` — powered Verilog freshly exported from `results/route.odb` by `scripts/finish.tcl`.
- `results/doorbell_chip.gds` — GDS streamed from the selected DEF and merged with the 3 mm frame.
- `reports/power_grid_check.log`, `logs/finish.log` — OpenROAD supply-grid diagnostic and export stage.

The four width markers are on `rst_n_c`, near two areas around `(1339.35–1340.65, 1471.1–1472.6) um` and `(1479.75–1481.05, 1471.1–1472.6) um`. `scripts/drc_bins.py verify/scl_drc.lyrdb` reproduces the locations. DEF connectivity shows `rst_n_c` driven by `u_pad_rst/OUT1` to 72 flop `CLR` pins.

The LVS diagnostic reports all primitive/library-cell circuit definitions matched, but the top design has net/subcircuit connectivity mismatches. The powered schematic netlist contains VDD and GROUND and is generated from the final ODB. This rules out a stale pre-route schematic as the sole cause, but does not yet distinguish a physical open in the PDN/route from a DEF-to-GDS streamout connectivity error.

## Experiments performed

### Baseline route and signoff checks

Environment used from Ubuntu:

```bash
export OR=/home/nithinvdt001/Crucible/tools/openroad/26Q3-771-g7cfb2105c9/tool_bin/openroad
export PDK_ROOT=/home/nithinvdt001/PDKs
export PDK=scl_cp8d
export REF=/home/nithinvdt001/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u
export FRAME_GDS=/home/nithinvdt001/ASIC_Projects/frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds
export KLAYOUT=klayout
cd "/mnt/c/Users/Admin/OneDrive/Documents/New project/doorbell_v3_rebuild_20261124"
./run.sh route
./run.sh gds
./run.sh verify
```

The flow ran as root in WSL, so the runner's `$HOME` defaults were wrong. Set `OR`, `PDK_ROOT`, `REF`, and `FRAME_GDS` explicitly as above. The PDK and reference files remain external; do not copy or commit them.

Routing selected the baseline pass with 0 detailed-route markers. `gds` succeeded. `verify` returned four 10.2.1 minimum-M2-width markers and a top-level LVS mismatch.

### Reset buffer-tree proposal

The reset-only experiment was run on a routed candidate. With `APPLY_RST_BUFFERING=1` and `SEED=42`, `repair_design` inserted **74 buffers in one net** (`rst_n_c`). Detailed placement retained hundreds of violations and incremental global route failed with `GRT-0232` congestion (total congestion 1414). Log: `logs/route_s42.log`.

The experiment is kept opt-in in `scripts/retry.tcl` because it does not produce a usable route in this library/flow. Do not enable it as the default retry behavior without changing the buffer strategy and proving that placement/routing completes.

### Net-specific reset-width route proposal

The project already had `scripts/rst_n_c_local_route.tcl`, which destroys only the reset wire, assigns a 2.1 um NDR to `rst_n_c`, and runs detailed routing into separate candidate files. `DRT_END_ITER` is now configurable for bounded experiments.

The latest attempt used `APPLY_RST_FIX=1 DRT_END_ITER=20`. It was stopped during stubborn-tile optimization after reaching one remaining OpenROAD routing marker; the script did not finish and did not write `results/route_rst_n_c_fix.odb` or `.def`. Its log is `logs/route_rst_n_c_fix.log`. It was not DRC/LVS checked and must not be selected as a candidate.

An earlier unbounded attempt also failed to complete in reasonable time. The original baseline files remain selected; the NDR experiment did not overwrite them.

## Code and PDK observations

- `scripts/finish.tcl` now exports `route_output_pwr.v` with `write_verilog -include_pwr_gnd` from the selected final ODB. It also runs PDNSim analysis and `check_power_grid` on the project nets `VDD` and `GROUND`. The checks are caught and logged so their failures do not prevent netlist export.
- The ground name for this design is `GROUND`, not `VSS`. The SCL LVS deck has a separate substrate-global setting of `VSS`; a prior test-only change of that setting did not resolve earlier pad mismatches. Do not rename nets or add implicit LVS aliases as a workaround.
- The SCL LVS deck maps metal1/via/metal2 as GDS 8/0, 9/0, and 10/0 and connects metal1-to-via-to-metal2; the streamout layer map uses those same layers. The installed PDK cell circuits all match in the latest LVS. That is evidence against a broad standard-cell-library defect, but it does not exclude a LEF/DRC view inconsistency or a top-level mapping issue.
- KLayout connectivity is geometry-based: touching shapes on a layer connect; vias connect layers when they overlap; labels name connected shapes. Labels alone do not join physically separate islands. See [KLayout LVS connectivity](https://www.klayout.org/downloads/master/doc-qt5/manual/lvs_connect.html).
- OpenROAD `repair_design` is a design-wide repair command without a per-net selector in this installed build; its buffering behavior is documented at [OpenROAD repair_design](https://openroad.readthedocs.io/en/latest/main/openroad/rsz/README.html). The observed 74-buffer result confirms that the suggested default repair is unsuitable without additional control.
- `scripts/merge_frame.py` checks the top-cell frame labels and required supply geometry. Successful merge validates their presence/coverage, not electrical continuity from every pad through the PDN.
- The project directory has no `.git` directory. Preserve the current handoff and outputs before further experiments.

## Recommended next work

1. **Trace the LVS topology before changing nets.** Use `verify/doorbell_chip.lvsdb` in KLayout's LVS report browser and trace VDD plus the four layout-only unmatched nets. Determine whether the splits first appear in the routed DEF, the KLayout-streamed unframed GDS, or only after frame merge.
2. **Audit the streamout path.** Compare `results/route.def`, `results/doorbell_chip_unframed.gds`, and the final framed GDS around mismatched nets. Review `gds/streamout.py`/`scripts/patch_streamout.py`, especially `prepare_def`'s handling of internal zero-extension bends and via transitions. Do not assume a DEF/GDS conversion error is a PDK fault.
3. **Check PDN connectivity against the reference floorplan.** Inspect special-net geometry and actual pad pin shapes for `VDD`/`GROUND`; compare against SCL's reference layout/flow. `check_power_grid` currently reports PSM-0069, but the log includes physical-only filler/corner terminals, so identify which terminals are actually disconnected before drawing straps or changing global connections.
4. **Resolve the reset width markers with a bounded candidate.** The reset-only 2.1 um NDR is a plausible targeted test, but the last run did not complete. Try controlled seeds/iterations and retain a candidate only after both OpenROAD routing and SCL DRC complete. The global buffer-tree attempt is known to fail congestion.
5. **Regenerate and run final checks for any accepted candidate:** export powered netlist from that exact ODB; stream its matching DEF; merge the frame; run `./run.sh verify`. Require zero SCL DRC violations and a passing full-chip LVS before signoff.

Do not run multiple OpenROAD route processes against the same results directory. Candidate experiments should write separate outputs and leave `results/route.odb`, `results/route.def`, and `results/doorbell_chip.gds` unchanged until independently verified.

