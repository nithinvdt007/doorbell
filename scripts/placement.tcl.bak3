source scripts/common.tcl
read_db results/floorplan.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
scl_set_parasitics
set_dont_use $dont_use_cells

# top-level ports on the pad bond pins (one list argument)
if {[catch {place_io_terminals -allow_non_top_layer {u_pad_*/PADIN u_pad_*/PAD}} err]} {
    puts "NOTE place_io_terminals: $err"
}

global_placement -skip_io -density 0.60

# Keep one site on each side of NND200: direct NND200/INVR00 abutment leaves an
# implant neck below SCL's minimum (reference flow, 07_placement).
scl_apply_implant_padding
detailed_placement
check_placement -verbose

write_db  results/placed.odb
write_def results/placed.def
report_design_area
puts "CP8D PLACEMENT COMPLETED"
