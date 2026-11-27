set block [ord::get_db_block]
set dbu [$block getDbUnitsPerMicron]
set die [$block getDieArea]
source scripts/frame_geometry.tcl
source scripts/frame_power_geometry.tcl
set expected_w [expr {round($DIE_W * $dbu)}]
set expected_h [expr {round($DIE_H * $dbu)}]
if {[$die xMin] != 0 || [$die yMin] != 0 ||
    [$die xMax] != $expected_w || [$die yMax] != $expected_h} {
  error "SCL frame power rails do not match the initialized die"
}

set metal1 [[$block getTech] findLayer metal1]
if {$metal1 eq "NULL"} { error "metal1 layer is missing" }
foreach rect $FRAME_POWER_RECTS {
  lassign $rect net_name x1 y1 x2 y2
  set net [$block findNet $net_name]
  if {$net eq "NULL"} { error "special net $net_name is missing" }
  set swires [$net getSWires]
  if {[llength $swires] == 0} { error "special net $net_name has no special wire" }
  set sw [lindex $swires 0]
  set x1 [expr {int(round($x1 * $dbu))}]
  set y1 [expr {int(round($y1 * $dbu))}]
  set x2 [expr {int(round($x2 * $dbu))}]
  set y2 [expr {int(round($y2 * $dbu))}]
  if {[catch {odb::dbSBox_create $sw $metal1 $x1 $y1 $x2 $y2 "STRIPE"} err]} {
    error "failed to add $net_name frame rail: $err"
  }
}
puts "SCL FRAME POWER RAILS ADDED: [llength $FRAME_POWER_RECTS] shapes"

