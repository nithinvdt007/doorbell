# Doorbell CP8D signoff handoff

> **Current continuation handoff:** See [NEXT_AGENT_HANDOFF.md](NEXT_AGENT_HANDOFF.md) for the latest 2026-11-24 routed GDS/DRC/LVS results, exact WSL environment, reset experiments, and prioritized next steps. This document contains earlier investigation history; newer results in `NEXT_AGENT_HANDOFF.md` supersede older status figures below.

## Status

**Not ready for signoff or fabrication.** The stored full-chip GDS fails both SCL checks:

The DRC/LVS results immediately below describe the **original project’s stored GDS**, not the isolated rebuild. The rebuild now has separate, pre-route evidence recorded later in this handoff.

- DRC reports 5 rule violations: 3 minimum metal2-to-metal2 spacing violations (rule 10.1.1) and 2 minimum metal2 width violations (rule 10.2.1).
- LVS reports that the layout and reference netlists do not match.

These results were reproduced with `./run.sh verify` after the routing retry was stopped. The check used the existing `results/doorbell_chip.gds`; it was not regenerated from the routing retry. The interrupted retry left no `results/route.def`, so the normal GDS stage cannot currently produce a new full-chip result.

## LVS evidence and next investigation

The LVS report on the stored GDS shows:

- The standard-cell circuits listed in the report match.
- `OTPD01` and `SPAD00` are `NoMatch`. Each has one unmatched schematic pin, `VDD`; the layout side has no corresponding pin in the extracted circuit.
- The top-level `doorbell_chip` comparison is skipped because those subcircuits did not match.

An earlier isolated pad-LVS run also reported failures for `IPAD00`, `IPPD00`, `IPPU00`, and `IPSH00`. That result is prior evidence and should be rerun when continuing the pad investigation.

**Do not hide this mismatch** by changing LVS equivalences, suppressing the comparison, or adding schematic aliases without verifying the actual pad-cell power connectivity. Determine from the licensed SCL documentation and the supplied GDS/CDL/LEF whether the unmatched `VDD` is a pad-cell model/extraction issue or a real missing physical terminal/connection. Then make a physically justified change and rerun both isolated pad LVS and top-level LVS.

Relevant current outputs:

- `verify/status.txt`
- `verify/klayout_lvs.log`
- `verify/doorbell_chip.lvsdb`
- `verify/doorbell_chip_extracted.cir`
- `verify/doorbell_chip.cdl`
- `verify/pads/summary.txt` (earlier isolated-pad run)
- `scripts/lvs_diag.py`

## DRC and routing evidence

The current GDS's DRC results are in `verify/drc_summary.txt` and `verify/scl_drc.lyrdb`. The five reported errors are metal2 spacing/width errors. Prior marker binning placed them in the core, approximately near (702, 1180) twice and (1276, 1127) for spacing, and (509, 1471) for width. Re-bin the current report before editing geometry.

A detailed-route retry was started to investigate physical routing violations, **not** to fix LVS. Routing cannot correct a pad-subcircuit pin mismatch. The retry was stopped before the seed loop completed:

- The first detailed-route pass reported 2 violations.
- Seeds 11 and 23 each also reported 2 violations.
- Seed 5 was interrupted while at 80% with 4 violations; later seeds did not run.
- The script had removed `results/route.odb` and `results/route.def` at startup and had not reached the step that selects/copies a final route. Do not treat the partial route outputs as the final route.

The user-provided `logs/route_s13.log` is also incomplete: its fourth detailed-route iteration ends with 33 routing violations (29 metal2 spacing and 4 shorts), then it starts a fifth iteration and the log stops. It is not evidence of a finished route.

The route logs and partial databases are diagnostic only. If routing is resumed, first ensure the database state is understood, run it interactively in the user's terminal, then generate a fresh GDS from the selected final DEF and rerun DRC and LVS.

## Follow-up physical connectivity check (original project)

The `VDD` text labels for `SPAD00` and `OTPD01` are present in both the source pad GDS and the full-chip GDS, at the same cell-local coordinates. Therefore, the earlier hypothesis that streamout dropped these labels is not supported.

A temporary streamout of `results/route_pass1.def` was checked without replacing the project GDS:

- Its LVS result has the same two failing pad circuits and the top-level circuit remains skipped.
- Its DRC result has 6 violations (4 metal2 spacing, 2 metal2 width), so this route candidate is not an improvement over the existing GDS's 5 violations.
- Geometric overlap checks found no top-level metal overlap with the signal-pad VDD pin bars for any of the placed `SPAD00`/`OTPD01` instances. The GROUND pad bars also had no direct top-level metal overlap in this candidate. This is evidence of missing physical pad-to-PDN connections in the custom frame and needs confirmation against the SCL pad-frame guidance before selecting a repair.

A test-only copy of the LVS deck with its substrate global changed from `VSS` to `GROUND` still reported the same pad VDD mismatches. Do not edit the installed PDK deck or use netlist aliases as a workaround; the mismatch is not fixed by that name change.

The original project's custom pad arrangement does not connect the signal-pad supply bars to the generated top-level power metal. The stock 2 mm frame was independently checked with the selected PDK: its DRC report has 0 violations and its LVS netlists match.

Inspection of the fresh rebuild's `results/floorplan.def` clarifies the existing power-pad connections: the VDD special net has four M1 stripes (lines 567-570) reaching the side power-pad locations, while GROUND has two M2 straps (line 482, including the manually added PVSS connection). These straps connect the power-pad instances; they do not form the missing supply connections for the twelve signal-pad instances. Do not treat the absence of a VDD strap to signal pads as an absence of VDD metal at the power pads.

An earlier experiment on the original project added only the stock frame's two VDD/GROUND polygons and labels to that chip GDS. That candidate extracted signal-pad pins incorrectly and must not be used. It is distinct from the fresh rebuild candidate below, whose pad placements are generated from the supplied frame and whose extracted signal nets remain separate from VDD/GROUND.

The earlier `quickcheck` on `results/route_pass1.def` used the invalid frame-polygon overlay described above and must not be treated as an LVS result. The routing DEF itself is only a partial candidate and is not final.

After removing that invalid overlay, `./run.sh verify` was rerun on the stored GDS: DRC remains at 5 violations (3 metal2 spacing, 2 metal2 width), and LVS still fails because `SPAD00` and `OTPD01` each have an unmatched schematic VDD pin. The route-pass1 quickcheck without the overlay has 6 DRC violations (4 spacing, 2 width); it is not the selected/final route.

## Fresh rebuild validation update (2026-11-24)

The isolated rebuild is at CTS and has not been detailed-routed. Its frame slots and orientations come from the supplied 2 mm frame. `scripts/frame_power.tcl` adds the supply rings as explicit VDD/GROUND special-net geometry before routing, so the router sees the rails. Streamout checks that this geometry covers the source frame rings, then adds the frame outline and labels; it rejects a missing frame, mismatched die, or unexpected required layer content. The PDK/frame GDS remains external to the rebuild source.

Verified on the fresh CTS candidate:

- `./run.sh quickcheck` (with the PDK environment set) completed with **0 SCL DRC violations and 0 guideline findings** after frame integration.
- KLayout extracted all 12 pad instances with `VDD` and `GROUND` separate from each pad's signal net. The extraction-only invocation reported the expected missing-schematic error because this CTS candidate is not a full LVS comparison; this is pad-connectivity evidence, not a top-level LVS pass.
- `results/cts.def` contains the frame rails on the VDD/GROUND special nets; the floorplan, placement, and CTS stages were regenerated after adding them.
- No final routed GDS or routed DRC exists in the rebuild. Pre-route diagnostic LVS has since been run and failed as described below.

This evidence supersedes the older "pad power still missing" statement for the rebuild only. It does not repair or change the original project's stored GDS.

## Detailed route optimization (2026-11-24)

The fresh rebuild route reached 4 reported markers in pass 1 and completed seeds 11, 23, and 5. The reports place them in two local conflicts: internal net `_331_` versus the clock tree near x=737 um, y=1175 um, and clock-tree metal versus reset net/cell `_740_` near x=736-747 um, y=1014-1031 um. The markers include duplicate geometry reports at a location, so there are two localized problem areas rather than four independent regions. Seed 23 saved its report/database/DEF before OpenROAD printed a Tcl error; the retry script now constructs those output paths explicitly, and the runner evaluates complete saved candidates while still reporting any process error.

Seed 7 was stopped during an intermediate optimization iteration that showed 34 markers; this is not its final result. The currently selected route database has 4 markers. The optional `./run.sh route-extra` stage now retries seed 7 plus seeds 29, 37, and 41 with up to 60 detailed-route iterations each, then keeps the candidate with the lowest reported marker count. Run it only after the current `./run.sh route` process exits; never run multiple routers against the same result directory. This is a targeted deeper search, not a guarantee of zero violations. Final DRC/LVS still decide signoff.

## Pre-route LVS diagnostic (2026-11-24)

Before restarting detailed routing, the active route process was stopped and `./run.sh lvs-preroute` was run using a GDS streamed from `results/cts.def` plus a schematic written from `results/cts.odb`. The SCL LVS deck returned **FAIL**. In the 32 circuit pairs, `PVDD01` and `PVSS01` matched, 29 library-cell circuits did not match their signal pins (the layout-side pin names are reported as `-`), and the top `doorbell_chip` comparison was skipped. See `verify/preroute/klayout_lvs.log` and `verify/preroute/lvs_diagnostics.txt`.

This is not final full-chip signoff because CTS DEF has no detailed signal routing. The widespread cell-level pin mismatches appear before routing and should be investigated before another detailed-route search. No detailed routing is currently running.

## PDK and reproducible verification

The selected PDK is the user's extracted Downloads copy. Do not copy or commit PDK files; the supplied PDK carries its own use and distribution restrictions.

In WSL, from the project directory, rerun verification with:

```bash
cd /home/nithinvdt001/ASIC_Projects/doorbell_v3
export HOME=/home/nithinvdt001
export PDK_ROOT=/mnt/c/Users/Admin/Downloads/SCL_PDK/SCL_CP8D_PDK_v1/digital_cp8d/extracted/my_dtech_cp8d/Open_Source_SCL_0.8micron_PDK_digital/open_source_scl_cp8d/open_pdks
export PDK=scl_cp8d
export REF=/home/nithinvdt001/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u
./run.sh verify
```

For the original project, the streamout patcher and its call sites were updated to derive the pad and corner library files from the selected PDK's core LEF/GDS paths rather than use a hardcoded installed-PDK location. Those changes are in `scripts/patch_streamout.py`, `run.sh`, and `scripts/quickcheck.sh`. GDS generation from the Downloads PDK succeeded, but that path correction did not resolve the original project's LVS or DRC failures.

## Recommended order of work

1. The fresh rebuild's pad-frame integration is in place and has passed the pre-route geometry/pad-connectivity checks above.
2. Resolve the pre-route library-cell pin extraction mismatch, then rerun `./run.sh lvs-preroute`.
3. Run detailed routing in the user's WSL terminal; the flow automatically tries additional seeds. Do not start another route concurrently.
4. Generate framed GDS from the selected final route, then run top-level SCL LVS and DRC. Proceed to SCL signoff only when the required checks pass and remaining foundry requirements are confirmed.

Suggested command for the next routing run (run in WSL; allow roughly 20–80 minutes):

```bash
cd /home/nithinvdt001/ASIC_Projects/doorbell_v3_rebuild_20261124
export HOME=/home/nithinvdt001
export PDK_ROOT=/home/nithinvdt001/PDKs
export PDK=scl_cp8d
export REF=/home/nithinvdt001/apb-rtl-to-gds-scl-cp8d/examples/apb-scl-0.8u
export FRAME_GDS=/home/nithinvdt001/ASIC_Projects/frame_work/Padframe_database/pad_frame_gds/frame3mmx3mm.gds
./run.sh route
```

After routing, run `./run.sh gds` and `./run.sh verify`. Routing is still not signoff-ready until the final routed DRC and full-chip LVS pass.

## Repository/publishing state

The project directory currently has no `.git` repository and no configured Git remote, so there is no project history or destination available here to commit or push this handoff. This report is saved locally in the project directory. The project/source and verification outputs have not been pushed.

## 3 mm SCL frame update (2026-11-24)

The rebuild now defaults to the supplied SCL `frame3mmx3mm.gds`. Before floorplanning, `scripts/frame_pads.py` derives the die dimensions, pad coordinates/orientations, and exact VDD/GROUND rail polygons from that frame. Six of each of the 12 SPAD00 and 12 ASPAD00 slots are selected for the design's 12 signal pads; the four power pads and four SCL corners are included in the floorplan. The 1800 um square core is centered in the 3000 um die.

The floorplan follows the SCL pad-ring order (`make_io_sites`, `place_corners`, pad placement, `connect_by_abutment`) and adds the frame supply polygons to the OpenROAD special nets before routing. CTS quickcheck passed with 0 SCL DRC violations and 0 guideline findings. This is only pre-route geometry evidence; detailed-route and final GDS DRC/LVS results are still required.

## Latest routed verification and local DRC diagnosis (2026-11-24)

The selected route's routed Verilog was regenerated from `results/route.odb`,
the framed GDS was regenerated from `results/route.def`, and SCL verification
was rerun on that pair. The result remains **not signoff-ready**: 4 SCL
minimum-metal2-width markers and a top-level LVS mismatch.

The four width markers are two physical sites with duplicate edge-pair
measurements, near (1339.35-1340.65, 1471.1-1472.6) um and
(1479.75-1481.05, 1471.1-1472.6) um. The corresponding M2 route segments in
`results/route.def` belong to `rst_n_c`, which connects `u_pad_rst/OUT1` to 72
flop `CLR` pins. The SCL DRC requires 2.0 um M2 width, matching the technology
LEF's nominal metal2 width. The markers therefore identify local geometry on
the reset route, not a missing global width setting or a frame-only issue.

`scripts/rst_n_c_local_route.tcl` is a read-only OpenDB pin inspection by
default. Its opt-in `APPLY_RST_FIX=1` mode assigns a net-specific 2.1 um NDR,
removes only the existing `rst_n_c` wire, and runs detailed routing against
the saved route database into separate candidate files. That repair mode has
not been run; review its candidate DRC/LVS before selecting it. `repair_design
-max_wire_length 0` is not a net-specific buffer-tree request, and the
installed `detailed_route` command has no net-selection option.
