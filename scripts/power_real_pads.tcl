source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
scl_set_parasitics
set_pdnsim_net_voltage -net VDD -voltage 5.0
set_pdnsim_net_voltage -net GROUND -voltage 0.0
set pg [open reports/power_real_pads.log w]
foreach {net vsrc} {VDD scripts/power_pads_vdd.loc GROUND scripts/power_pads_gnd.loc} {
    puts $pg "=== $net with real pad sources ($vsrc) ==="
    if {[catch {
        analyze_power_grid -net $net -vsrc $vsrc \
            -error_file reports/power_real_${net}.rpt
    } msg]} {
        puts $pg "FAIL: $msg"
    } else {
        puts $pg "OK"
    }
}
close $pg
puts DONE

