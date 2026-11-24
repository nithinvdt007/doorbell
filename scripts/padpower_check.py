import re
pads = {"u_pad_vdd0 PVDD01 W": (0, 700, 304.9, 851.2), "u_pad_vss0 PVSS01 W": (0, 1050, 304.9, 1201.2),
        "u_pad_vdd1 PVDD01 E": (1695.1, 1050, 2000, 1201.2), "u_pad_vss1 PVSS01 E": (1695.1, 700, 2000, 851.2)}
hits = {k: {} for k in pads}; net = None; sec = False
rx = re.compile(r"(?:\+ ROUTED|NEW)\s+(\w+)\s+(\d+)\s+(?:\+ SHAPE \w+\s+)?\(\s*(\S+)\s+(\S+)\s*\)\s*\(\s*(\S+)\s+(\S+)\s*\)")
for line in open("results/floorplan.def"):
    if line.startswith("SPECIALNETS"): sec = True; continue
    if line.startswith("END SPECIALNETS"): break
    if not sec: continue
    m = re.match(r"\s*-\s+(\S+)", line)
    if m: net = m.group(1)
    for m in rx.finditer(line):
        lay, w, *c = m.groups()
        if "*" in c: continue
        x1, y1, x2, y2 = [float(v) / 1000 for v in c]; hw = int(w) / 2000
        r = (min(x1, x2) - hw, min(y1, y2) - hw, max(x1, x2) + hw, max(y1, y2) + hw)
        for k, p in pads.items():
            if r[0] < p[2] and r[2] > p[0] and r[1] < p[3] and r[3] > p[1]:
                hits[k][(net, lay)] = hits[k].get((net, lay), 0) + 1
for k, h in hits.items(): print("%-22s" % k, dict(h) if h else "NOTHING TOUCHES THIS PAD")
