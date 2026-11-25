#!/usr/bin/env python3
"""Summarize fast/slow x1 setup and hold checks from logs/sta.log."""
import re
import sys

tag = re.compile(r"^=== STA x1 (fast_corner|slow_corner) (SETUP|HOLD)")
row = re.compile(r"(-?\d+\.\d+)\s+\((MET|VIOLATED)\)")
results, cur = {}, None
for line in open(sys.argv[1] if len(sys.argv) > 1 else "logs/sta.log", encoding="utf-8"):
    m = tag.match(line)
    if m:
        cur = (m.group(1), m.group(2))
        continue
    m = row.search(line)
    if m and cur and cur not in results:
        results[cur] = (float(m.group(1)), m.group(2))

if not results:
    print("No fast/slow timing rows found in the log. Open logs/sta.log.")
    sys.exit(2)

print("Slack in ns (negative = violated). Assumed x1 wire-RC model.\n")
print("%-12s %18s %18s" % ("corner", "setup", "hold"))
bad = False
for scene, label in (("slow_corner", "slow"), ("fast_corner", "fast")):
    cells = []
    for kind in ("SETUP", "HOLD"):
        result = results.get((scene, kind))
        cells.append("n/a" if result is None else "%8.2f %-9s" % result)
        if result is None or result[1] == "VIOLATED":
            bad = True
    print("%-12s %18s %18s" % (label, cells[0], cells[1]))
print()
print("VERDICT:", "FAIL - violated or missing checks" if bad else "fast and slow setup/hold checks met")
print("NOTE: assumed wire RC is not foundry extraction. Ask SCL for signoff RC data.")
sys.exit(1 if bad else 0)

