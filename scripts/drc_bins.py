#!/usr/bin/env python3
"""Where are the DRC markers? Counts per rule, inside the core or in the pad ring,
and the busiest 100 um bins. Usage: drc_bins.py <report.lyrdb>"""
import re, sys
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict

geo = open("scripts/geometry.tcl").read()
frame_geo = open("scripts/frame_geometry.tcl").read()
core_size_match = re.search(r"CORE_SIZE\s+([\d.]+)", geo)
die_w_match = re.search(r"DIE_W\s+([\d.]+)", frame_geo)
die_h_match = re.search(r"DIE_H\s+([\d.]+)", frame_geo)
if not (core_size_match and die_w_match and die_h_match):
    sys.exit("Could not read the generated SCL die/core dimensions")
core_size = float(core_size_match.group(1))
die_w = float(die_w_match.group(1))
die_h = float(die_h_match.group(1))
lo_x, hi_x = (die_w - core_size) / 2.0, (die_w + core_size) / 2.0
lo_y, hi_y = (die_h - core_size) / 2.0, (die_h + core_size) / 2.0
root = ET.parse(sys.argv[1]).getroot()
cats = defaultdict(list)
for it in root.iter("item"):
    cat = (it.findtext("category") or "?").strip("'")
    if cat.startswith("@GUIDELINE"):
        continue
    cell = it.findtext("cell") or "?"
    pts = []
    for v in it.iter("value"):
        pts += [(float(a), float(b)) for a, b in re.findall(r"(-?\d+\.?\d*),(-?\d+\.?\d*)", v.text or "")]
    if pts:
        x = sum(p[0] for p in pts) / len(pts); y = sum(p[1] for p in pts) / len(pts)
        cats[cat].append((cell, x, y, (it.find("values/value").text or "")[:110]))
if not cats:
    print("No rule violations in the report.")
for cat, items in sorted(cats.items(), key=lambda kv: -len(kv[1])):
    inside = sum(1 for c, x, y, s in items if lo_x <= x <= hi_x and lo_y <= y <= hi_y)
    print("\n%s  count %d  in core area %d  in pad ring/outside %d" % (cat, len(items), inside, len(items) - inside))
    print("  cells:", Counter(c for c, *_ in items).most_common(4))
    bins = Counter((int(x // 100) * 100, int(y // 100) * 100) for _, x, y, _ in items)
    print("  top 100um bins (x,y):", bins.most_common(4))
    print("  sample:", items[0][3])
