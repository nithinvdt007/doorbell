source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
set_propagated_clock [all_clocks]
scl_set_parasitics
estimate_parasitics -placement
if {[catch {write_sdf results/route_output.sdf} msg]} {
    puts "WRITE_SDF_FAIL: $msg"
} else {
    puts "WRITE_SDF_OK results/route_output.sdf"
}
puts DONE

