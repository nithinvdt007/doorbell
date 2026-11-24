#!/usr/bin/env python3
"""Turn logs/sta.log into a small table and a pass/fail verdict.
Exit code 1 if any check is VIOLATED at the base wire RC (x1)."""
import re, sys

tag = re.compile(r"^=== STA x(\d+) (\w+) (SETUP|HOLD)")
row = re.compile(r"(-?\d+\.\d+)\s+\((MET|VIOLATED)\)")
results, cur = {}, None
for line in open(sys.argv[1] if len(sys.argv) > 1 else "logs/sta.log"):
    m = tag.match(line)
    if m:
        cur = (int(m.group(1)), m.group(2), m.group(3)); continue
    m = row.search(line)
    if m and cur and cur not in results:
        results[cur] = (float(m.group(1)), m.group(2))

if not results:
    print("No timing rows found in the log. Open logs/sta.log."); sys.exit(2)

scenes = ("typ_scene", "max_scene", "min_scene")
print("Slack in ns (negative = violated). Wire RC scaled by x1 (assumed model), x2, x4.\n")
print("%-6s %-10s %18s %18s" % ("scale", "corner", "setup", "hold"))
bad_base = False
for m in (1, 2, 4):
    for s in scenes:
        cells = []
        for kind in ("SETUP", "HOLD"):
            r = results.get((m, s, kind))
            cells.append("n/a" if r is None else "%8.2f %-9s" % r)
            if r and r[1] == "VIOLATED" and m == 1:
                bad_base = True
        print("x%-5d %-10s %18s %18s" % (m, s, cells[0], cells[1]))
print()
print("VERDICT (x1 wire RC):", "FAIL - violated checks" if bad_base else "all three corners met")
print("NOTE: wire RC is an assumed model, not foundry extraction. Ask SCL for signoff RC data.")
sys.exit(1 if bad_base else 0)
