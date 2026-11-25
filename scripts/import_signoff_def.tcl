# Rebuild the physical database from the patched signoff DEF. Do not run
# read_verilog/link_design after read_def: the DEF already contains the full
# placed design, routes, pads, fillers, and special nets.
source scripts/common.tcl
read_lef $scl(tech_lef)
read_lef $scl(cell_lef)
read_lef [file join $scl_ref lef corner_cp8d.lef]
read_lef libs/pads_cp8d_snapped.lef

if {[info exists ::env(SIGNOFF_DEF)]} {
    set def_path $::env(SIGNOFF_DEF)
} else {
    set def_path results/route.def
}
if {[info exists ::env(SIGNOFF_ODB)]} {
    set odb_path $::env(SIGNOFF_ODB)
} else {
    set odb_path results/route.odb
}

read_def $def_path
write_db $odb_path
puts "CP8D SIGNOFF DEF IMPORTED: $def_path -> $odb_path"

