# Export from the selected, post-route database so any inserted reset buffers
# and their connectivity are exactly the ones represented in the streamed DEF.
# The LVS deck excludes empty filler cells, so remove those from both exports.
source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)

# CP8D names its ground net GROUND (not VSS). Analyze first because
# check_power_grid reports connectivity using the PDNSim analysis state.
set pg_log [open reports/power_grid_check.log w]
foreach net {VDD GROUND} {
    set pg_errors [file normalize "reports/power_grid_${net}.rpt"]
    if {[catch {
        analyze_power_grid -net $net
        check_power_grid -net $net -error_file $pg_errors
    } result]} {
        puts $pg_log "$net: FAIL - $result"
        puts "WARNING: power-grid check failed for $net; see reports/power_grid_check.log and $pg_errors"
    } else {
        puts $pg_log "$net: check completed; see $pg_errors"
    }
}
close $pg_log

write_verilog -remove_cells $scl(fillers) results/route_output.v
write_verilog -include_pwr_gnd -remove_cells $scl(fillers) results/route_output_pwr.v
puts "LVS netlist exported from results/route.odb: results/route_output_pwr.v"
puts "CP8D FINISH COMPLETED"
