import os, sys
from collections import Counter
try:
    import klayout.db as db
except ImportError:
    import pya as db
fr = db.Layout(); fr.read(os.environ["FRAME"])
ch = db.Layout(); ch.read(os.environ["CHIP"])
if abs(fr.dbu - ch.dbu) > 1e-12: sys.exit("DBU mismatch: frame %g chip %g" % (fr.dbu, ch.dbu))
frame_tops = list(fr.top_cells())
if len(frame_tops) != 1: sys.exit("Expected one SCL frame top cell, found %d" % len(frame_tops))
ftop = frame_tops[0]
ctop = ch.cell("doorbell_chip")
if ctop is None: sys.exit("chip top cell doorbell_chip is missing")
instances = Counter(ch.cell(i.cell_index).name for i in ctop.each_inst())
expected_instances = {"CORNER": 4, "SPAD00": 3, "OTPD01": 9, "PVDD01": 2, "PVSS01": 2}
for master, count in expected_instances.items():
    if instances[master] != count:
        sys.exit("Expected %d %s instances in the streamed chip, found %d" %
                 (count, master, instances[master]))
if ftop.dbbox() != ctop.dbbox():
    sys.exit("Frame/chip die mismatch: frame %s, chip %s" % (ftop.dbbox(), ctop.dbbox()))
print("chip top:", ctop.name, "bbox", ctop.dbbox(), "| frame bbox", ftop.dbbox())
print("SCL IO instances:", " ".join("%s=%d" % (name, instances[name]) for name in expected_instances))
expected = {(8, 0): (2, "polygon"), (28, 0): (1, "box"), (8, 7): (2, "text")}
frame_ring = db.Region()
for (l, d), (expected_count, expected_type) in expected.items():
    fl = fr.find_layer(l, d)
    if fl is None: sys.exit("SCL frame is missing required layer %d/%d" % (l, d))
    shapes = list(ftop.shapes(fl).each())
    if len(shapes) != expected_count:
        sys.exit("Expected %d shapes on frame layer %d/%d, found %d" %
                 (expected_count, l, d, len(shapes)))
    names = sorted(s.text.string for s in shapes if s.is_text())
    if expected_type == "text" and names != ["GROUND", "VDD"]:
        sys.exit("Expected GROUND/VDD labels on layer 8/7, found %s" % names)
    if expected_type == "polygon":
        for s in shapes:
            if not s.is_polygon(): sys.exit("Unexpected shape type on frame layer %d/%d" % (l, d))
            frame_ring.insert(s.polygon)
        chip_ring = db.Region(ctop.shapes(ch.layer(l, d)))
        if not (frame_ring - chip_ring).is_empty():
            sys.exit("Frame supply rails are missing from the streamed chip GDS")
        continue
    cl = ch.layer(l, d)
    for s in ftop.shapes(fl).each():
        if expected_type == "text" and s.is_text():
            ctop.shapes(cl).insert(s.text)
        elif expected_type == "box" and s.is_box():
            ctop.shapes(cl).insert(s.box)
        else:
            sys.exit("Unexpected shape type on required frame layer %d/%d" % (l, d))
    print("copied %d %s shape(s) on %d/%d" % (expected_count, expected_type, l, d))
ch.write(os.environ["OUT"]); print("wrote", os.environ["OUT"])
