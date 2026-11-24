# Timing in three real corners, setup and hold, on the routed database.
# The PDK's OpenRCX rules have only zero coefficients, so extraction would give
# ideal wires (all SPEF capacitances are 0). Wire RC here is the ASSUMED model in
# config_ref/scl_cp8d.tcl, estimated from the layout and also scaled x2 and x4
# as a sensitivity check on that assumption.
source scripts/common.tcl
foreach c {typ max min} {
    read_liberty $scl(lib,$c)
    read_liberty $pads($c)
}
read_db results/route.odb
read_sdc constraints/doorbell.sdc
set_propagated_clock [all_clocks]

define_scene typ_scene -mode default -liberty [list $scl(lib,typ) $pads(typ)]
define_scene max_scene -mode default -liberty [list $scl(lib,max) $pads(max)]
define_scene min_scene -mode default -liberty [list $scl(lib,min) $pads(min)]

set base1 $scl(wire_rc,metal1)
set base2 $scl(wire_rc,metal2)
foreach m {1 2 4} {
    lassign $base1 r1 c1
    lassign $base2 r2 c2
    set scl(wire_rc,metal1) [list [expr {$r1 * $m}] [expr {$c1 * $m}]]
    set scl(wire_rc,metal2) [list [expr {$r2 * $m}] [expr {$c2 * $m}]]
    scl_set_parasitics
    estimate_parasitics -placement
    foreach s {typ_scene max_scene min_scene} {
        puts "=== STA x$m $s SETUP"
        report_checks -path_delay max -scenes $s -format end -group_path_count 1 -digits 2
        puts "=== STA x$m $s HOLD"
        report_checks -path_delay min -scenes $s -format end -group_path_count 1 -digits 2
    }
}
puts "=== STA DONE"
