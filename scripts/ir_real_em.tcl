source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
scl_set_parasitics
set_pdnsim_net_voltage -net VDD -voltage 5.0
set_pdnsim_net_voltage -net GROUND -voltage 0.0
# Use real SCL sheet resistance for the power grid (from tech LEF/Magic tech).
set_layer_rc -layer metal1 -resistance [expr {0.07/1.7/1000.0}] -capacitance [expr {0.027e-3*1.7+2e-4}]
set_layer_rc -layer metal2 -resistance [expr {0.04/2.0/1000.0}] -capacitance [expr {0.011e-3*2.0+2e-4}]
set_layer_rc -via via -resistance [expr {0.3375/1000.0}]
foreach {net vsrc em} {
  VDD scripts/power_pads_vdd.loc reports/em_VDD.rpt
  GROUND scripts/power_pads_gnd.loc reports/em_GROUND.rpt
} {
  puts "=== $net real-pad static IR + EM ==="
  if {[catch {
    analyze_power_grid -net $net -vsrc $vsrc -source_type STRAPS \
      -enable_em -em_outfile $em -allow_reuse
  } msg]} { puts "FAIL $net: $msg" } else { puts "OK $net" }
}
puts IR_DONE
