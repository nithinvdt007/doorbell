#!/usr/bin/env python3
"""Widen the three reset-sync M2 wire intersections flagged by SCL 10.2.1.
Geometry-only, applied after routing; idempotent.
"""
from pathlib import Path
import sys

p = Path(sys.argv[1] if len(sys.argv) > 1 else "results/route.def")
t = p.read_text(encoding="utf-8")

edits = [
    ("NEW metal2 ( 1647750 1461500 ) ( * 1472600 0 )",
     "NEW metal2 ( 1648450 1461500 ) ( * 1472600 0 )"),
    ("NEW metal2 ( 1912950 1783400 0 ) ( * 1879600 )",
     "NEW metal2 ( 1913650 1783400 0 ) ( * 1879600 )"),
    ("NEW metal2 ( 1441050 1783400 0 ) ( * 1809300 )",
     "NEW metal2 ( 1441750 1783400 0 ) ( * 1809300 )"),
]
for old, new in edits:
    n = t.count(old)
    if n == 1:
        t = t.replace(old, new, 1)
    elif t.count(new) >= 1:
        continue
    else:
        raise SystemExit(f"expected one match for {old}, got {n}")
p.write_text(t, encoding="utf-8", newline="")
print("Applied reset-sync width fix")

