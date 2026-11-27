# Doorbell CP8D — 3 mm signoff handoff

Reset-synchronizer candidate. DRC and LVS pass; power-grid connectivity checks pass; x1 fast/slow setup and hold meet using the assumed wire-RC model. See OPEN_ITEMS.md for limitations.

## Contents

- reports/ and RESULTS/: signoff summaries, stage results, timing, power, RTL and gate-level simulation output.
- scripts/: active synthesis, floorplan, placement, CTS, route, signoff, and verification Tcl/Python scripts.
- images/: rendered signoff timing and simulation summaries (SVG).
- FLOW.md: Ubuntu setup and reproducible commands.
- OPEN_ITEMS.md: remaining signoff issues.
- SHA256SUMS.txt: checksums of the files in this public handoff.

The GDS and raw VCD waveforms are intentionally omitted; the SVG figures provide readable result views.
