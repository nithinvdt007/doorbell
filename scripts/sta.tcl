# Timing at SCL fast/slow Liberty corners using the assumed x1 wire-RC model.
# PDK OpenRCX capacitance coefficients are zero, so use the LEF-derived estimate
# in config_ref/scl_cp8d.tcl. This is not foundry-extracted RC.
source scripts/common.tcl
foreach c {max min} {
    read_liberty $scl(lib,$c)
    read_liberty $pads($c)
}
read_db results/route.odb
read_sdc constraints/doorbell.sdc
set_propagated_clock [all_clocks]

define_scene slow_corner -mode default -liberty [list $scl(lib,max) $pads(max)]
define_scene fast_corner -mode default -liberty [list $scl(lib,min) $pads(min)]

scl_set_parasitics
estimate_parasitics -placement
foreach s {slow_corner fast_corner} {
    puts "=== STA x1 $s SETUP"
    report_checks -path_delay max -scenes $s -format end -group_path_count 1 -digits 2
    puts "=== STA x1 $s HOLD"
    report_checks -path_delay min -scenes $s -format end -group_path_count 1 -digits 2
}
puts "=== STA DONE"

