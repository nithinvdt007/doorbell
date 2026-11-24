import os
import sys

try:
    import klayout.db as db
except ImportError:
    import pya as db


def fail(message):
    sys.exit("SCL frame error: " + message)


frame_path = os.environ.get("FRAME")
if not frame_path or not os.path.isfile(frame_path):
    fail("FRAME must name an existing GDS file")

layout = db.Layout()
layout.read(frame_path)
tops = list(layout.top_cells())
if len(tops) != 1:
    fail("expected one top cell, found %d" % len(tops))
top = tops[0]
die = top.dbbox()
die_w = die.width()
die_h = die.height()
if abs(die.left) > 1e-6 or abs(die.bottom) > 1e-6 or abs(die_w - die_h) > 1e-6:
    fail("frame must be a square die with its lower-left corner at (0, 0)")

orientations = {
    (0, 0): "R0", (0, 90): "R90", (0, 180): "R180", (0, 270): "R270",
    (1, 0): "MX", (1, 90): "MXR90", (1, 180): "MY", (1, 270): "MYR90",
}
pad_slots = {"SPAD00": [], "ASPAD00": [], "PVDD01": [], "PVSS01": []}
for inst in top.each_inst():
    name = layout.cell(inst.cell_index).name
    if name not in pad_slots:
        continue
    transform = inst.dcplx_trans
    orient_key = (1 if transform.is_mirror() else 0, int(round(transform.angle)) % 360)
    if orient_key not in orientations:
        fail("unsupported orientation %s for %s" % (orient_key, name))
    bbox = inst.dbbox()
    pad_slots[name].append({
        "orient": orientations[orient_key],
        "x": round(bbox.left, 3),
        "y": round(bbox.bottom, 3),
        "bbox": bbox,
    })

for name, required in (("SPAD00", 6), ("ASPAD00", 6), ("PVDD01", 2), ("PVSS01", 2)):
    if len(pad_slots[name]) < required:
        fail("frame has %d %s slots; at least %d required" %
             (len(pad_slots[name]), name, required))


def perimeter_key(slot):
    box = slot["bbox"]
    tolerance = 0.01
    if box.left <= tolerance:
        return (0, box.center().y)
    if box.top >= die_h - tolerance:
        return (1, -box.center().x)
    if box.right >= die_w - tolerance:
        return (2, -box.center().y)
    if box.bottom <= tolerance:
        return (3, box.center().x)
    fail("pad slot is not on the die boundary: %s" % box)


def evenly_spaced(slots, count, name):
    ordered = sorted(slots, key=perimeter_key)
    if len(ordered) == count:
        return ordered
    if len(ordered) % count == 0:
        step = len(ordered) // count
        selected = ordered[::step]
    else:
        selected = [ordered[int(round(i * (len(ordered) - 1) / float(count - 1)))]
                    for i in range(count)]
    if len(selected) != count or len({(s["x"], s["y"]) for s in selected}) != count:
        fail("could not select %d distinct %s slots" % (count, name))
    return selected


signal_slots = {
    "SPAD00": evenly_spaced(pad_slots["SPAD00"], 6, "SPAD00"),
    "ASPAD00": evenly_spaced(pad_slots["ASPAD00"], 6, "ASPAD00"),
}
power_slots = {
    name: sorted(slots, key=perimeter_key)
    for name, slots in (("PVDD01", pad_slots["PVDD01"]), ("PVSS01", pad_slots["PVSS01"]))
}

placements = [
    ("u_pad_clk", signal_slots["SPAD00"][0]),
    ("u_pad_rst", signal_slots["SPAD00"][2]),
    ("u_pad_btn", signal_slots["SPAD00"][4]),
]
outputs = ["u_pad_seg%d" % index for index in range(7)] + ["u_pad_led", "u_pad_slp"]
output_slots = signal_slots["SPAD00"][1::2] + signal_slots["ASPAD00"]
if len(output_slots) != len(outputs):
    fail("pad frame does not provide exactly nine selected output slots")
placements.extend(zip(outputs, output_slots))
placements.extend(zip(("u_pad_vdd0", "u_pad_vdd1"), power_slots["PVDD01"]))
placements.extend(zip(("u_pad_vss0", "u_pad_vss1"), power_slots["PVSS01"]))
if len(placements) != 16:
    fail("expected 16 pad instances, found %d" % len(placements))

pad_tcl_path = os.environ.get("PAD_TCL", "scripts/frame_pads.tcl")
with open(pad_tcl_path, "w") as output:
    output.write("set block [ord::get_db_block]\nset dbu [$block getDbUnitsPerMicron]\n")
    output.write(
        "proc place_pad {name orient x y} {\n"
        "  global block dbu\n"
        "  set inst [$block findInst $name]\n"
        "  if {$inst eq \"NULL\"} { error \"pad $name not found\" }\n"
        "  $inst setOrient $orient\n"
        "  $inst setLocation [expr {int(round($x*$dbu))}] [expr {int(round($y*$dbu))}]\n"
        "  $inst setPlacementStatus FIRM\n"
        "  set bb [$inst getBBox]\n"
        "  puts [format \"PAD %-10s %-6s x %8.2f..%8.2f  y %8.2f..%8.2f\" $name $orient "
        "[expr {[$bb xMin]/double($dbu)}] [expr {[$bb xMax]/double($dbu)}] "
        "[expr {[$bb yMin]/double($dbu)}] [expr {[$bb yMax]/double($dbu)}]]\n"
        "}\n"
    )
    for name, slot in placements:
        output.write("place_pad %s %s %.3f %.3f\n" %
                     (name, slot["orient"], slot["x"], slot["y"]))

geometry_tcl_path = os.environ.get("GEOMETRY_TCL", "scripts/frame_geometry.tcl")
with open(geometry_tcl_path, "w") as output:
    output.write("set DIE_W %.3f\nset DIE_H %.3f\n" % (die_w, die_h))
    output.write("set FRAME_TOP %s\n" % top.name)


def polygon_rectangles(polygon):
    points = list(polygon.each_point_hull())
    ys = sorted(set(point.y for point in points))
    rectangles = []
    for y1, y2 in zip(ys, ys[1:]):
        if y2 <= y1:
            continue
        scan_y = (y1 + y2) / 2.0
        intersections = []
        for index, first in enumerate(points):
            second = points[(index + 1) % len(points)]
            if first.y == second.y:
                continue
            if min(first.y, second.y) < scan_y < max(first.y, second.y):
                x = first.x + (scan_y - first.y) * (second.x - first.x) / (second.y - first.y)
                intersections.append(x)
        intersections.sort()
        if len(intersections) % 2:
            fail("frame power polygon is not rectilinear")
        for index in range(0, len(intersections), 2):
            x1 = int(round(intersections[index]))
            x2 = int(round(intersections[index + 1]))
            if x2 > x1:
                rectangles.append((x1, y1, x2, y2))
    if sum((x2 - x1) * (y2 - y1) for x1, y1, x2, y2 in rectangles) != polygon.area():
        fail("could not exactly decompose a frame power polygon")
    return rectangles


power_layer = layout.find_layer(8, 0)
label_layer = layout.find_layer(8, 7)
if power_layer is None or label_layer is None:
    fail("frame is missing SCL power geometry or labels on layers 8/0 and 8/7")
power_polygons = [shape.polygon for shape in top.shapes(power_layer).each() if shape.is_polygon()]
labels = [shape.text.string for shape in top.shapes(label_layer).each() if shape.is_text()]
if len(power_polygons) != 2 or sorted(labels) != ["GROUND", "VDD"]:
    fail("expected two supply polygons and VDD/GROUND labels; found %d polygons, labels %s" %
         (len(power_polygons), labels))
power_polygons.sort(key=lambda polygon: polygon.bbox().width() * polygon.bbox().height())
power_rectangles = []
for net, polygon in zip(("VDD", "GROUND"), power_polygons):
    for x1, y1, x2, y2 in polygon_rectangles(polygon):
        scale = layout.dbu
        power_rectangles.append((net, x1 * scale, y1 * scale, x2 * scale, y2 * scale))

power_tcl_path = os.environ.get("POWER_TCL", "scripts/frame_power_geometry.tcl")
with open(power_tcl_path, "w") as output:
    output.write("set FRAME_POWER_RECTS {\n")
    for net, x1, y1, x2, y2 in power_rectangles:
        output.write("  {%s %.3f %.3f %.3f %.3f}\n" % (net, x1, y1, x2, y2))
    output.write("}\n")

print("SCL frame:", top.name, "%.1f x %.1f um" % (die_w, die_h))
for name in ("SPAD00", "ASPAD00", "PVDD01", "PVSS01"):
    print("SCL frame slots: %s %d total, %d used" %
          (name, len(pad_slots[name]), len(signal_slots.get(name, power_slots.get(name, [])))))
print("SCL frame power: %d generated special-net rectangles" % len(power_rectangles))
print("wrote:", pad_tcl_path, geometry_tcl_path, power_tcl_path)
