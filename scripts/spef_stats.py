#!/usr/bin/env python3
"""Report the real wire R and C found in a SPEF. Usage: spef_stats.py <file.spef>"""
import sys
lines = open(sys.argv[1]).read().split("\n")
print("header:", " | ".join(l for l in lines[:40] if l.startswith(("*C_UNIT", "*R_UNIT", "*DESIGN "))))
sect = None; nets = 0; netcap = []; caps = []; res = []
for l in lines:
    if l.startswith("*D_NET"):
        nets += 1; netcap.append(float(l.split()[2])); sect = None
    elif l.startswith("*CAP"): sect = "cap"
    elif l.startswith("*RES"): sect = "res"
    elif l.startswith("*END"): sect = None
    elif sect and l[:1].isdigit():
        try: (caps if sect == "cap" else res).append(float(l.split()[-1]))
        except ValueError: pass
nz = lambda a: sum(1 for x in a if x != 0)
print("nets %d | net total cap: sum %.6g, max %.6g, nets with nonzero cap %d" % (nets, sum(netcap), max(netcap or [0]), nz(netcap)))
print("capacitor entries %d (nonzero %d, sum %.6g) | resistor entries %d (nonzero %d, sum %.6g, max %.6g)" %
      (len(caps), nz(caps), sum(caps), len(res), nz(res), sum(res), max(res or [0])))
if sum(netcap) == 0:
    print("RESULT: zero wire capacitance. This extraction is NOT usable for timing.")

