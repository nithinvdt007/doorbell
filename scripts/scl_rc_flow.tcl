# Real SCL per-layer RC from tech LEF + SCL reference config interpretation.
# Scale RC by RC_SCALE (default 1.0) for margin sweeps.
source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
set_propagated_clock [all_clocks]

set scale [expr {[info exists ::env(RC_SCALE)] ? $::env(RC_SCALE) : 1.0}]
set r1 [expr {0.07 / 1.7 / 1000.0 * $scale}]
set c1 [expr {(0.027e-3 * 1.7 + 2.0 * 1e-4) * $scale}]
set r2 [expr {0.04 / 2.0 / 1000.0 * $scale}]
set c2 [expr {(0.011e-3 * 2.0 + 2.0 * 1e-4) * $scale}]
set rv [expr {0.3375 / 1000.0 * $scale}]
set_layer_rc -layer metal1 -resistance $r1 -capacitance $c1
set_layer_rc -layer metal2 -resistance $r2 -capacitance $c2
set_layer_rc -via via -resistance $rv
puts [format "SCL_RC scale=%.2f m1_r=%.6g m1_c=%.6g m2_r=%.6g m2_c=%.6g via_r=%.6g" $scale $r1 $c1 $r2 $c2 $rv]

set_routing_layers -signal metal1-metal2 -clock metal1-metal2
global_route -use_cugr -critical_nets_percentage 0 -guide_file results/route_rc.guide -verbose
estimate_parasitics -global_routing -spef_file results/route_scl_${scale}.spef

define_scene slow_scene -mode default -liberty [list $scl(lib,max) $pads(max)]
define_scene fast_scene -mode default -liberty [list $scl(lib,min) $pads(min)]
foreach s {slow_scene fast_scene} {
  puts "=== RC_SCALE $scale $s SETUP"
  report_checks -path_delay max -scenes $s -format end -group_path_count 1 -digits 2
  puts "=== RC_SCALE $scale $s HOLD"
  report_checks -path_delay min -scenes $s -format end -group_path_count 1 -digits 2
}
puts SCL_RC_DONE
