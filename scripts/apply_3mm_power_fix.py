#!/usr/bin/env python3
"""Geometry-only power fix for the 3 mm CP8D signoff DEF.

Applied after apply_signoff_def_fix.py and before the ODB import. The GROUND
rails are NOT extended on metal1 (that would short them to the wide VDD
straps); each is tied to the GROUND ring on metal2, and the four corner VDD
pins are tied to the VDD frame ring on metal2.
"""
from pathlib import Path
import sys

path = Path(sys.argv[1] if len(sys.argv) > 1 else "results/route.def")
text = path.read_text(encoding="utf-8")
VIA = "via1_2_10000_7000_2_3_3000_3000"

def once(old, new):
    global text
    n = text.count(old)
    if n == 0 and text.count(new) >= 1:
        return  # already applied (idempotent)
    if n != 1:
        raise SystemExit(f"expected one occurrence, found {n}: {old}")
    text = text.replace(old, new, 1)

# Full bottom-row GROUND rail (the original was two fragments).
anchor = "NEW metal1 7000 + SHAPE FOLLOWPIN ( 567800 608400 ) ( 584400 608400 )"
once(anchor, anchor + "\n      NEW metal1 7000 + SHAPE FOLLOWPIN ( 567800 608400 ) ( 2431300 608400 )")

# Six GROUND rows with no via: tie on metal2 to the GROUND ring horizontal.
for y, ring_y in ((1064700, 584700), (1115400, 584700), (1166100, 584700),
                  (1774500, 2406600), (1825200, 2406600), (1875900, 2406600)):
    old = f"NEW metal1 7000 + SHAPE FOLLOWPIN ( 596800 {y} ) ( 2402300 {y} )"
    add = "\n".join([
        f"      NEW metal1 0 + SHAPE STRIPE ( 610000 {y} ) {VIA}",
        f"      NEW metal2 4000 + SHAPE STRIPE ( 610000 {y} ) ( 610000 {ring_y} )",
        f"      NEW metal1 0 + SHAPE STRIPE ( 610000 {ring_y} ) {VIA}",
    ])
    once(old, old + "\n" + add)

# Four corner-pad VDD pins to the VDD frame ring on metal2.
anchor = "NEW metal1 10412 + SHAPE STRIPE ( 214200 219406 ) ( 2785852 219406 )"
lines = []
for x, vy, ry in ((259550, 70000, 259550), (2740450, 70000, 259550),
                  (259550, 2920000, 2740450), (2740450, 2920000, 2740450)):
    lines += [
        f"      NEW metal1 0 + SHAPE STRIPE ( {x} {vy} ) {VIA}",
        f"      NEW metal2 4000 + SHAPE STRIPE ( {x} {vy} ) ( {x} {ry} )",
        f"      NEW metal1 0 + SHAPE STRIPE ( {x} {ry} ) {VIA}",
    ]
once(anchor, anchor + "\n" + "\n".join(lines))

path.write_text(text, encoding="utf-8", newline="")
print(f"Applied 3 mm power fix to {path}")

