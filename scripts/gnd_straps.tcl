set blk [ord::get_db_block]
set dbu [$blk getDbUnitsPerMicron]
set m2  [[$blk getTech] findLayer metal2]
set gnd [$blk findNet GROUND]
set vdd [$blk findNet VDD]
proc m2_boxes {net} {
  set res {}
  foreach sw [$net getSWires] {
    foreach b [$sw getWires] {
      if {[$b isVia]} continue
      if {[[$b getTechLayer] getName] eq "metal2"} { lappend res [list [$b xMin] [$b yMin] [$b xMax] [$b yMax]] }
    }
  }
  return $res
}
set die [$blk getDieArea]
set midx [expr {([$die xMin] + [$die xMax]) / 2}]
set sw [lindex [$gnd getSWires] 0]
set rings {}
foreach b [m2_boxes $gnd] { if {[lindex $b 3] - [lindex $b 1] > 500 * $dbu} { lappend rings $b } }
puts "GNDSTRAP ground metal2 vertical segments: [llength $rings]"
foreach padname {u_pad_vss0 u_pad_vss1} {
  set inst [$blk findInst $padname]
  set bb [$inst getBBox]
  set yc [expr {([$bb yMin] + [$bb yMax]) / 2}]
  set hw [expr {5 * $dbu}]
  set west [expr {[$bb xMax] < $midx}]
  set ring ""
  foreach r $rings {
    set rc [expr {([lindex $r 0] + [lindex $r 2]) / 2}]
    if {$west && $rc < $midx && ($ring eq "" || $rc < [expr {([lindex $ring 0] + [lindex $ring 2]) / 2}])} { set ring $r }
    if {!$west && $rc > $midx && ($ring eq "" || $rc > [expr {([lindex $ring 0] + [lindex $ring 2]) / 2}])} { set ring $r }
  }
  if {$ring eq ""} { puts "GNDSTRAP $padname: no ground metal2 ring found"; continue }
  set rc [expr {([lindex $ring 0] + [lindex $ring 2]) / 2}]
  if {$west} { set x1 [expr {[$bb xMax] - 15 * $dbu}]; set x2 $rc } else { set x1 $rc; set x2 [expr {[$bb xMin] + 15 * $dbu}] }
  set y1 [expr {$yc - $hw}]; set y2 [expr {$yc + $hw}]
  set blocked 0
  foreach v [m2_boxes $vdd] {
    if {[lindex $v 0] < $x2 && [lindex $v 2] > $x1 && [lindex $v 1] < $y2 && [lindex $v 3] > $y1} { set blocked 1 }
  }
  if {$blocked} { puts "GNDSTRAP $padname BLOCKED by VDD metal2 - not added"; continue }
  if {[catch {odb::dbSBox_create $sw $m2 $x1 $y1 $x2 $y2 "STRIPE"} err]} { puts "GNDSTRAP $padname create failed: $err"; continue }
  puts [format "GNDSTRAP %s added x %.1f..%.1f y %.1f..%.1f" $padname [expr {$x1/double($dbu)}] [expr {$x2/double($dbu)}] [expr {$y1/double($dbu)}] [expr {$y2/double($dbu)}]]
}
