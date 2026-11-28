# Open items before fabrication signoff

## Recorded checks

- DRC: 0 rule violations in saved report.
- LVS: netlists match in saved report.
- Power grid: VDD and GROUND connected in saved check.
- Simulation summaries are recorded in RESULTS/.

These are saved results; this repository audit did not rerun the EDA flow.

## Still open

1. **RC extraction and corner validation**
   - OpenRCX has zero coefficients; its saved SPEF reports zero capacitance on all 500 nets.
   - The separate set_layer_rc sweep uses a first-order interpretation of tech-LEF values. CPERSQDIST units and Magic-vs-LEF resistance differences need SCL confirmation.
   - Sweep logs include STA-1555 Liberty-name warnings and identical fast/slow results. Confirm the intended min/max Liberty corners loaded.
   - Full-chip Magic extresist crashed. Foundry-quality extracted parasitics are unavailable.

2. **SDF / timing-annotated GLS**
   - Estimated-RC SDF generation completed in the saved log.
   - Annotated Icarus simulation did not advance the expected count; SDF cell/path annotation is unvalidated.

3. **IR drop and EM**
   - Static analysis with estimated wire resistance completed; this is not foundry signoff.
   - Compare segment current with current-density limits only after width normalization and rule confirmation.
   - Dynamic IR was not run; obtain fab requirements.

4. **Antenna, density, and pad ESD**
   - The available DRC deck was reported to have no explicit antenna/density checks.
   - Obtain the current SCL tapeout checklist and written pad-frame/ESD acceptance.

5. **Formal equivalence**
   - No formal equivalence run is recorded.

6. **Full-flow automation**
   - run.sh has explicit stages; its all target stops after route. GDS, verification, STA, RC sweep, IR/EM, and SDF are separate commands.
   - A fresh run requires an authorized SCL PDK, reference-flow repository, and external frame GDS/CDL.
