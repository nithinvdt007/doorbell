source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
scl_set_parasitics
set_pdnsim_net_voltage -net VDD -voltage 5.0
set_pdnsim_net_voltage -net GROUND -voltage 0.0

set rep [open "reports/power_integrity_report.txt" w]
puts $rep "================================================================"
puts $rep "DOORBELL CP8D - POWER INTEGRITY REPORT"
puts $rep "Database: results/route.odb"
puts $rep "Supply: VDD = 5.0 V, GROUND = 0.0 V (from cp8d liberty voltage_map)"
puts $rep "Flow: check_power_grid -dont_require_terminals, then analyze_power_grid"
puts $rep "================================================================"
foreach net {VDD GROUND} {
    puts $rep ""
    puts $rep "NET $net"
    set err [file normalize "reports/pwrtest_${net}_check.rpt"]
    catch {file delete -force $err}
    if {[catch {check_power_grid -net $net -dont_require_terminals -error_file $err} msg]} {
        puts $rep "  check_power_grid : FAIL - $msg"
    } else {
        puts $rep "  check_power_grid : PASS (no unconnected shapes)"
        if {[file exists $err]} {
            puts $rep "  unexpected error file: $err"
        }
    }
    set air [file normalize "reports/pwrtest_${net}_ir.rpt"]
    catch {file delete -force $air}
    if {[catch {analyze_power_grid -net $net -error_file $air} msg]} {
        puts $rep "  analyze_power_grid: FAIL - $msg"
    } else {
        puts $rep "  analyze_power_grid: PASS (analysis completed)"
        if {[file exists $air]} {
            puts $rep "  IR report: $air"
        }
    }
}
puts $rep ""
puts $rep "================================================================"
close $rep
puts "POWER_REPORT_DONE"

