#!/usr/bin/env python3
"""Prepare PDK-derived inputs. The PDK itself is never modified.

1. Liberty: strip padding inside quoted next_state/clocked_on/clear/preset
   strings (e.g. " CLR'  " -> "CLR'"). Yosys dfflibmap cannot read the padded
   form and reports every flop as unmapped.
2. Pad LEF: snap RECT/POLYGON coordinates to 0.01 um. Some pad pin shapes are
   off the manufacturing grid and TritonRoute stops with DRT-0320.
"""
import os, re, sys

root = os.environ.get("PDK_ROOT", os.path.expanduser("~/PDKs"))
pdk = os.environ.get("PDK", "scl_cp8d")
ref = os.path.join(root, pdk, "libs.ref", "digital_cp8d")
os.makedirs("libs", exist_ok=True)

attrs = r"next_state|clocked_on|clear|preset|clear_preset_var1|clear_preset_var2|data_in|enable"
pat = re.compile(r'(%s)(\s*:\s*)"\s*([^"]*[^"\s])\s*"' % attrs)

missing = 0
for name in ("cp8d_core_typ", "cp8d_core_max", "cp8d_core_min",
             "cp8d_pads_typ", "cp8d_pads_max", "cp8d_pads_min"):
    src = os.path.join(ref, "lib", name + ".lib")
    if not os.path.isfile(src):
        print("MISSING:", src); missing += 1; continue
    text = open(src).read()
    out, n = pat.subn(r'\1\2"\3"', text)
    open(os.path.join("libs", name + ".clean.lib"), "w").write(out)
    print("%-14s %5d padded strings fixed" % (name, n))

src = os.path.join(ref, "lef", "pads_cp8d.lef")
if not os.path.isfile(src):
    print("MISSING:", src); missing += 1
else:
    line_pat = re.compile(r"^(\s*)(RECT|POLYGON)\s+(.*?)\s*;\s*$")
    out, count = [], 0
    for line in open(src).read().split("\n"):
        m = line_pat.match(line)
        if m:
            toks = []
            for t in m.group(3).split():
                try:
                    toks.append("%.2f" % (round(float(t) * 100) / 100))
                except ValueError:
                    toks.append(t)
            line = "%s%s %s ;" % (m.group(1), m.group(2), " ".join(toks))
            count += 1
        out.append(line)
    open(os.path.join("libs", "pads_cp8d_snapped.lef"), "w").write("\n".join(out))
    print("pads LEF: %d shapes snapped to 0.01 um" % count)

sys.exit(1 if missing else 0)

