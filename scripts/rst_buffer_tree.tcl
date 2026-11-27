set_thread_count [exec nproc]
source scripts/common.tcl
read_db results/route.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
scl_set_parasitics
set_propagated_clock [all_clocks]
set_routing_layers -signal metal1-metal2 -clock metal1-metal2

set block [ord::get_db_block]
set trunk [$block findNet rst_n_c]
set vdd [$block findNet VDD]
set gnd [$block findNet GROUND]
if {$trunk eq "NULL" || $vdd eq "NULL" || $gnd eq "NULL"} { error "supply/reset nets missing" }

# Master for the buffer tree: reuse an existing BUFF00 master.
set buff NULL
foreach inst [$block getInsts] {
    set m [$inst getMaster]
    if {[$m getName] eq "BUFF00"} { set buff $m; break }
}
if {$buff eq "NULL"} { error "BUFF00 master not found" }

# Collect the sink terminals (everything except the pad input source).
set sinks {}
foreach it [$trunk getITerms] {
    set inst [$it getInst]
    if {[$inst getName] eq "u_pad_rst"} { continue }
    lappend sinks $it
}
puts "RESET sinks=[llength $sinks]"

# Pick eight placed filler sites spread over the core for the buffers.
set sites {}
foreach inst [$block getInsts] {
    if {![string match "FILLER*" [$inst getName]]} { continue }
    if {[$inst getPlacementStatus] eq "UNPLACED"} { continue }
    set loc [$inst getLocation]
    set x [lindex $loc 0]
    set y [lindex $loc 1]
    lappend sites [list $inst $x $y [$inst getOrient]]
}
set picked {}
set step [expr {[llength $sites] / 8}]
if {$step < 1} { set step 1 }
for {set i 0} {$i < 8} {incr i} {
    set idx [expr {($i + 1) * $step}]
    if {$idx >= [llength $sites]} { set idx [expr {[llength $sites] - 1}] }
    lappend picked [lindex $sites $idx]
}

set nbuf 0
set subnets {}
foreach site $picked {
    lassign $site finst x y orient
    if {$finst eq ""} { continue }
    incr nbuf
    set bname [format "RSTBUF_%02d" $nbuf]
    odb::dbInst_destroy $finst
    set bi [odb::dbInst_create $block $buff $bname]
    $bi setLocation $x $y
    $bi setOrient $orient
    $bi setPlacementStatus FIRM
    set sub [odb::dbNet_create $block [format "rst_n_c_b%02d" $nbuf]]
    lappend subnets $sub
    foreach it [$bi getITerms] {
        set pn [[$it getMTerm] getName]
        switch -- $pn {
            IN1 { $it connect $trunk }
            OUT1 { $it connect $sub }
            VDD { $it connect $vdd }
            GROUND { $it connect $gnd }
        }
    }
}
puts "Inserted $nbuf buffers"

# Redistribute the flop sinks evenly over the buffered sub-nets.
set k 0
foreach it $sinks {
    set sub [lindex $subnets [expr {$k % $nbuf}]]
    $it disconnect
    $it connect $sub
    incr k
}

# NDR 3.1 on the trunk and every buffered sub-net.
set ndr_name RST_TREE_WIDE_3P1
set width [expr {[info exists ::env(RST_NDR_WIDTH)] ? $::env(RST_NDR_WIDTH) : 3.1}]
create_ndr -name $ndr_name -width $width
set targets [list $trunk]
foreach sub $subnets { lappend targets $sub }
foreach net $targets {
    assign_ndr -ndr $ndr_name -net [$net getName]
    set wire [$net getWire]
    if {$wire ne "NULL"} { odb::dbWire_destroy $wire }
    puts "NDR_NET [$net getName]"
}

# Clear all existing routing so the router re-routes the entire design with
# the new reset tree present. Rip-up of reset nets only leaves the new
# sub-nets unrouted in this OpenROAD build.
set cleared 0
foreach net [$block getNets] {
    set wire [$net getWire]
    if {$wire ne "NULL"} { odb::dbWire_destroy $wire; incr cleared }
}
puts "CLEARED_WIRES $cleared"

global_route -guide_file results/route_rst_tree.guide

set end_iter 64
if {[info exists ::env(DRT_END_ITER)]} { set end_iter $::env(DRT_END_ITER) }
set or_seed [expr {[info exists ::env(OR_SEED)] ? $::env(OR_SEED) : 42}]
detailed_route -output_drc reports/route_rst_tree.rpt \
  -droute_end_iter $end_iter -or_seed $or_seed -verbose 1
write_db results/route_rst_tree.odb
write_def results/route_rst_tree.def
write_verilog -include_pwr_gnd -remove_cells $scl(fillers) results/route_rst_tree_pwr.v
puts "RST_TREE_DONE"

