set block [ord::get_db_block]
set dbu [$block getDbUnitsPerMicron]
proc place_pad {name orient x y} {
  global block dbu
  set inst [$block findInst $name]
  if {$inst eq "NULL"} { error "pad $name not found" }
  $inst setOrient $orient
  $inst setLocation [expr {int(round($x*$dbu))}] [expr {int(round($y*$dbu))}]
  $inst setPlacementStatus FIRM
  set bb [$inst getBBox]
  puts [format "PAD %-10s %-6s x %8.2f..%8.2f  y %8.2f..%8.2f" $name $orient [expr {[$bb xMin]/double($dbu)}] [expr {[$bb xMax]/double($dbu)}] [expr {[$bb yMin]/double($dbu)}] [expr {[$bb yMax]/double($dbu)}]]
}
place_pad u_pad_clk R90 0.000 350.000
place_pad u_pad_rst R0 1400.000 2695.100
place_pad u_pad_btn MXR90 2695.100 350.000
place_pad u_pad_seg0 MYR90 0.000 2456.850
place_pad u_pad_seg1 R270 2695.100 2456.850
place_pad u_pad_seg2 MX 1400.000 0.000
place_pad u_pad_seg3 R90 0.000 700.000
place_pad u_pad_seg4 R0 2450.000 2695.100
place_pad u_pad_seg5 R0 1050.000 2695.100
place_pad u_pad_seg6 R270 2695.100 2106.850
place_pad u_pad_led MX 350.000 0.000
place_pad u_pad_slp MX 1750.000 0.000
place_pad u_pad_vdd0 R90 0.000 1050.000
place_pad u_pad_vdd1 R270 2695.100 1750.000
place_pad u_pad_vss0 MYR90 0.000 1750.000
place_pad u_pad_vss1 MXR90 2695.100 1050.000

