# Export from the selected, post-route database so any inserted reset buffers
# and their connectivity are exactly the ones represented in the streamed DEF.
# The LVS deck excludes empty filler cells, so remove those from both exports.
source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
# The database rebuilt from DEF does not carry the project's RC assumptions.
scl_set_parasitics

# CP8D names its ground net GROUND (not VSS). Run the connectivity check
# FIRST: analyze_power_grid fails on a fragmented net and would otherwise hide
# the PSM-0038 unconnected-shape report. The design has power ITerms but no
# BTerms, so the connectivity check needs -dont_require_terminals.
set pg_log [open reports/power_grid_check.log w]
foreach net {VDD GROUND} {
    set pg_errors [file normalize "reports/power_grid_${net}.rpt"]
    # OpenROAD only writes the error file on failure; remove any stale one.
    catch {file delete -force $pg_errors}
    if {[catch {check_power_grid -net $net -dont_require_terminals -error_file $pg_errors} result]} {
        puts $pg_log "$net: CHECK FAIL - $result"
        puts "WARNING: power-grid connectivity check failed for $net; see $pg_errors"
    } else {
        puts $pg_log "$net: check completed (no unconnected shapes)"
    }
    # CP8D liberty: voltage_map(VDD,5), voltage_map(GROUND,0).
    if {$net eq "VDD"} {
        set vdd_voltage [expr {[info exists ::env(PDNSIM_VDD_VOLTAGE)] ? $::env(PDNSIM_VDD_VOLTAGE) : 5.0}]
        set_pdnsim_net_voltage -net $net -voltage $vdd_voltage
    } else {
        set_pdnsim_net_voltage -net $net -voltage 0.0
    }
    if {[catch {analyze_power_grid -net $net} result]} {
        puts $pg_log "$net: ANALYZE FAIL - $result"
    } else {
        puts $pg_log "$net: analysis completed"
    }
}
close $pg_log

write_verilog -remove_cells $scl(fillers) results/route_output.v
write_verilog -include_pwr_gnd -remove_cells $scl(fillers) results/route_output_pwr.v
puts "LVS netlist exported from results/route.odb: results/route_output_pwr.v"
puts "CP8D FINISH COMPLETED"

