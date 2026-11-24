# Render a reproducible KLayout PNG preview from the top-level GDS.
include RBA

input_gds = ENV.fetch("INPUT_GDS")
output_png = ENV.fetch("OUTPUT_PNG")
layer_props = ENV.fetch("LAYER_PROPS")

view = LayoutView.new(false)
view.load_layout(input_gds)
view.load_layer_props(layer_props, false)
view.set_config("background-color", "#ffffff")
view.set_config("grid-visible", "false")
view.max_hier
view.zoom_fit
view.save_image(output_png, 2400, 1800)
puts "Rendered #{input_gds} -> #{output_png}"

