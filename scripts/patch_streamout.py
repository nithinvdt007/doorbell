#!/usr/bin/env python3
"""Copy the reference streamout.py and apply the three changes this design needs.

1. lef_files: add the PDK pad and corner LEFs (the DEF contains SCL I/O cells).
2. macro_layout_files: add the pad and corner GDS next to the standard cells.
3. KLayout 0.30.0 has no Shape.set_properties(): insert with the property id instead.
Usage: patch_streamout.py <reference streamout.py> <output>
"""
import sys

src, dst = sys.argv[1:3]
text = open(src).read()

def sub(old, new):
    global text
    if old not in text:
        sys.exit("patch target not found: " + old[:70])
    text = text.replace(old, new, 1)

sub('config.lef_files = [parameters["tech_lef"], parameters["cell_lef"]]',
    '''config.lef_files = [
        parameters["tech_lef"],
        parameters["cell_lef"],
        str(Path(parameters["cell_lef"]).with_name("pads_cp8d.lef")),
        str(Path(parameters["cell_lef"]).with_name("corner_cp8d.lef")),
    ]''')
sub('config.macro_layout_files = [parameters["cell_gds"]]',
    '''cell_gds = Path(parameters["cell_gds"])
    config.macro_layout_files = [
        parameters["cell_gds"],
        str(cell_gds.with_name("pads_cp8d.gds")),
        str(cell_gds.with_name("CORNER.gds")),
    ]''')
sub('''            properties = shape.properties()
            for bounds in boxes:
                new_shape = shapes.insert(pya.Box(*bounds))
                if properties:
                    new_shape.set_properties(properties)
''', '''            prop_id = shape.prop_id
            for bounds in boxes:
                shapes.insert(pya.Box(*bounds), prop_id)
''')
open(dst, "w").write(text)
print("patched:", dst)
