source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
set_propagated_clock [all_clocks]
set_layer_rc -layer metal1 -resistance [expr {0.07/1.7/1000.0}] -capacitance [expr {0.027e-3*1.7+2e-4}]
set_layer_rc -layer metal2 -resistance [expr {0.04/2.0/1000.0}] -capacitance [expr {0.011e-3*2.0+2e-4}]
set_layer_rc -via via -resistance [expr {0.3375/1000.0}]
set_routing_layers -signal metal1-metal2 -clock metal1-metal2
global_route -use_cugr -critical_nets_percentage 0 -guide_file results/route_sdf.guide -verbose
estimate_parasitics -global_routing -spef_file results/route_real.spef
define_scene slow_scene -mode default -liberty [list $scl(lib,max) $pads(max)]
define_scene fast_scene -mode default -liberty [list $scl(lib,min) $pads(min)]
write_sdf -divider . -scene slow_scene -digits 3 results/doorbell_chip_real.sdf
puts SDF_REAL_DONE
