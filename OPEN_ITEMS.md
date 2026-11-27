# Open items preventing fabrication signoff

## Closed in this candidate

- Reset fanout/synchronizer: two-flop async-assert/sync-deassert synchronizer in RTL.
- Reset width markers: three M2 segments shifted in the signoff DEF patch (`scripts/apply_rst_sync_width_fix.py`).
- Physical closure: DRC 0, LVS match, power grid connected.

## Still open

1. **Wire RC / extracted timing**
   - SCL `scl800.rcx.lib` has zero coefficients; OpenROAD SPEF has 0 capacitance on 500/500 nets.
   - Magic extracts real C (8,416 capacitors) but `extresist all` segfaults on the full chip; R uses SCL tech-LEF sheet resistance.
   - No foundry-quality extracted RC for STA/IR.

2. **SDF / timing-annotated GLS**
   - `results/route_output.sdf` uses the assumed wire-RC model.
   - Verilator ignores `$sdf_annotate`. Icarus with `$sdf_annotate` produced a failing sim while zero-delay GLS passed, so the annotation flow is not validated.
   - Need valid RC → SDF → SDF-capable simulator.

3. **IR drop**
   - Real power-pad coordinates are configured (no bump pattern), but wire R/C are assumed; no dynamic IR and no foundry IR signoff.

4. **Pad ESD / frame site confirmation**
   - 9 outputs use OTPD01 (2 mA). OTP pads have only a substrate ESD diode, no VDD clamp.
   - Needs written SCL/fab acceptance or a standard output-pad change plus frame CDL update.

5. **Formal equivalence**
   - Directed gate-level sim matches RTL; no formal equivalence tool run completed.

6. **Single-command reproducibility**
   - Flow is split into `run.sh` stages plus signoff patch scripts; no single unattended RTL→GDS command.

## 2 mm variant

Not signoff-ready; parked in `doorbell_v3_2mm_20261125`.

