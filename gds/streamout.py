"""CP8D DEF preparation and rectangular-wire GDS streamout.

Executed by KLayout through Igny; importing the geometry helpers needs only
the Python standard library.
"""

from pathlib import Path
import re


POINT = re.compile(r"\(\s*(-?\d+|\*)\s+(-?\d+|\*)(?:\s+(-?\d+))?\s*\)")
ROUTE = re.compile(
    r"(?:\+\s+(?:ROUTED|FIXED|COVER)|\bNEW)\s+\S+.*?(?=\bNEW\s+|\+|;)",
    re.DOTALL,
)


def prepare_def(text):
    """Remove flush extensions only at internal, same-layer Manhattan bends.

    A zero extension at a bend truncates both joining legs in KLayout. Keep
    terminal extensions, via transitions, straight junctions and SPECIALNETS
    unchanged. The input DEF is never overwritten.
    """
    start = re.search(r"^NETS\s+\d+\s*;", text, re.MULTILINE)
    end = re.search(r"^END NETS\b", text, re.MULTILINE)
    if start is None or end is None or end.start() < start.end():
        raise ValueError("Expected a complete NETS section in the routed DEF")
    changes = 0

    def prepare_route(match):
        nonlocal changes
        route = match.group()
        points = []
        previous = None
        for point in POINT.finditer(route):
            if previous is None and "*" in point.group(1, 2):
                raise ValueError("First route point must have absolute coordinates")
            xy = tuple(old if value == "*" else int(value)
                       for value, old in zip(point.group(1, 2), previous or (0, 0)))
            points.append((point, xy))
            previous = xy
        replacements = []
        for index in range(1, len(points) - 1):
            _, before = points[index - 1]
            point, here = points[index]
            following, after = points[index + 1]
            if point.group(3) != "0":
                continue
            # A via at this point may switch layers: never bridge across it.
            if route[point.end():following.start()].strip():
                continue
            dx1, dy1 = here[0] - before[0], here[1] - before[1]
            dx2, dy2 = after[0] - here[0], after[1] - here[1]
            bend = ((dx1 == 0 and dy1 != 0 and dx2 != 0 and dy2 == 0)
                    or (dx1 != 0 and dy1 == 0 and dx2 == 0 and dy2 != 0))
            if bend:
                replacements.append((point.start(), point.end(),
                                     f"( {point.group(1)} {point.group(2)} )"))
        for begin, finish, replacement in reversed(replacements):
            route = route[:begin] + replacement + route[finish:]
        changes += len(replacements)
        return route

    nets = ROUTE.sub(prepare_route, text[start.end():end.start()])
    return text[:start.end()] + nets + text[end.start():], changes


def manhattan_boxes(points, width, begin_extension, end_extension):
    """Represent a centerline by rectangles, including its explicit end caps.

    Short end legs cannot always be represented by a valid joined GDS path.
    Independent rectangles give each internal corner a half-width overlap.
    """
    if width <= 0 or width % 2 or min(begin_extension, end_extension) < 0:
        raise ValueError("Expected a positive even wire width and nonnegative caps")
    vertices = []
    for point in points:
        if not vertices or point != vertices[-1]:
            vertices.append(point)
    if len(vertices) < 2:
        raise ValueError("Expected at least two distinct wire points")
    half = width // 2
    boxes = []
    for index, ((x1, y1), (x2, y2)) in enumerate(zip(vertices, vertices[1:])):
        begin = begin_extension if index == 0 else half
        end = end_extension if index == len(vertices) - 2 else half
        if y1 == y2:
            left, right = ((x1 - begin, x2 + end) if x2 > x1
                           else (x2 - end, x1 + begin))
            boxes.append((left, y1 - half, right, y1 + half))
        elif x1 == x2:
            bottom, top = ((y1 - begin, y2 + end) if y2 > y1
                           else (y2 - end, y1 + begin))
            boxes.append((x1 - half, bottom, x1 + half, top))
        else:
            raise ValueError("Non-Manhattan routing requires a separate streamout policy")
    return boxes


def main(parameters):
    # pya belongs to the Igny-bound KLayout executable; no pip dependency.
    import pya

    names = ("input_def", "output_gds", "tech_lef", "cell_lef", "cell_gds",
             "layer_map", "work_dir", "top_cell")
    for name in names:
        if not parameters.get(name):
            raise ValueError(f"Missing KLayout parameter: {name}")
    work = Path(parameters["work_dir"])
    work.mkdir(parents=True, exist_ok=True)
    prepared = work / "route.streamout.def"
    text, bends = prepare_def(Path(parameters["input_def"]).read_text())
    prepared.write_text(text)

    config = pya.LEFDEFReaderConfiguration()
    config.read_lef_with_def = False
    config.lef_files = [
        parameters["tech_lef"],
        parameters["cell_lef"],
        str(Path(parameters["cell_lef"]).with_name("pads_cp8d.lef")),
        str(Path(parameters["cell_lef"]).with_name("corner_cp8d.lef")),
    ]
    config.macro_resolution_mode = 2
    cell_gds = Path(parameters["cell_gds"])
    config.macro_layout_files = [
        parameters["cell_gds"],
        str(cell_gds.with_name("pads_cp8d.gds")),
        str(cell_gds.with_name("CORNER.gds")),
    ]
    config.map_file = parameters["layer_map"]
    config.joined_paths = False
    # DEF routing keepouts are constraints, not fabricated via polygons.
    # Actual routed/library vias are still imported through the layer map.
    config.produce_blockages = False
    options = pya.LoadLayoutOptions()
    options.lefdef_config = config
    layout = pya.Layout()
    layout.read(str(prepared), options)
    top = layout.cell(parameters["top_cell"])
    if top is None:
        raise ValueError(f"Missing top cell: {parameters['top_cell']}")

    wires = rectangles = 0
    # Only routed top-level geometry is rewritten. Library cells stay intact.
    for layer in layout.layer_indices():
        shapes = top.shapes(layer)
        for shape in list(shapes.each()):
            if not shape.is_path():
                continue
            path = shape.path
            if path.round:
                raise ValueError("Unexpected round-ended path in CP8D streamout")
            boxes = manhattan_boxes([(p.x, p.y) for p in path.each_point()],
                                    path.width, path.bgn_ext, path.end_ext)
            prop_id = shape.prop_id
            for bounds in boxes:
                shapes.insert(pya.Box(*bounds), prop_id)
            shape.delete()
            wires += 1
            rectangles += len(boxes)

    output = Path(parameters["output_gds"])
    pending = work / "APB_Protocol.pending.gds"
    layout.write(str(pending))
    pending.replace(output)
    print(f"Streamout: normalized {bends} internal flush bends")
    print(f"Streamout: converted {wires} wire paths to {rectangles} rectangles")
    print(f"GDS written: {output}")


if __name__ == "__main__":
    main(globals())
