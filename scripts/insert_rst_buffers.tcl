# Insert an 8-way reset buffer tree into the post-CTS database, before routing.
# Run once on a fresh results/cts.odb in the candidate project.
source scripts/common.tcl
read_db results/cts.odb
set block [ord::get_db_block]
set trunk [$block findNet rst_n_c]
set vdd [$block findNet VDD]
set gnd [$block findNet GROUND]
if {$trunk eq "NULL" || $vdd eq "NULL" || $gnd eq "NULL"} { error "missing net" }

set buff NULL
foreach inst [$block getInsts] {
    set m [$inst getMaster]
    if {[$m getName] eq "BUFF00"} { set buff $m; break }
}
if {$buff eq "NULL"} { error "BUFF00 master not found" }

set sinks {}
foreach it [$trunk getITerms] {
    set inst [$it getInst]
    if {[$inst getName] eq "u_pad_rst"} { continue }
    lappend sinks $it
}
puts "RESET_SINKS [llength $sinks]"

# Pick eight well-spaced placed filler sites.
set sites {}
foreach inst [$block getInsts] {
    if {![string match "FILLER*" [$inst getName]]} { continue }
    if {[$inst getPlacementStatus] eq "UNPLACED"} { continue }
    set loc [$inst getLocation]
    lappend sites [list $inst [lindex $loc 0] [lindex $loc 1] [$inst getOrient]]
}
set n 16
set step [expr {[llength $sites] / $n}]
if {$step < 1} { set step 1 }
set subnets {}
for {set i 0} {$i < $n} {incr i} {
    set idx [expr {$i * $step}]
    if {$idx >= [llength $sites]} { set idx [expr {[llength $sites] - 1}] }
    lassign [lindex $sites $idx] finst x y orient
    set bname [format "RSTBUF_%02d" [expr {$i + 1}]]
    odb::dbInst_destroy $finst
    set bi [odb::dbInst_create $block $buff $bname]
    $bi setLocation $x $y
    $bi setOrient $orient
    $bi setPlacementStatus FIRM
    set sub [odb::dbNet_create $block [format "rst_n_c_b%02d" [expr {$i + 1}]]]
    lappend subnets $sub
    foreach it [$bi getITerms] {
        switch -- [[$it getMTerm] getName] {
            IN1 { $it connect $trunk }
            OUT1 { $it connect $sub }
            VDD { $it connect $vdd }
            GROUND { $it connect $gnd }
        }
    }
}
set k 0
foreach it $sinks {
    set sub [lindex $subnets [expr {$k % $n}]]
    $it disconnect
    $it connect $sub
    incr k
}
puts "RST_TREE_INSERTED buffers=$n subnets=[llength $subnets]"
write_db results/cts.odb
puts "CTS_RST_DONE"

