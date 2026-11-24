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
set target_net rst_n_c
set net [$block findNet $target_net]
if {$net eq "NULL"} {
    error "Net $target_net was not found in results/route.odb"
}

puts "Target net: [$net getName]"
puts "KLayout M2 markers are near x=1339.35-1340.65 and 1479.75-1481.05 um, y=1471.1-1472.6 um."
puts "Connected block terminals:"
foreach bterm [$net getBTerms] {
    puts "  [$bterm getName]"
}
puts "Connected instance terminals:"
foreach iterm [$net getITerms] {
    set inst [$iterm getInst]
    set term [$iterm getMTerm]
    puts "  [$inst getName]/[$term getName]"
}

if {![info exists ::env(APPLY_RST_FIX)] || $::env(APPLY_RST_FIX) ne "1"} {
    puts "Inspection only. Set APPLY_RST_FIX=1 to apply the net-specific route experiment."
    exit 0
}

set wire [$net getWire]
if {$wire eq "NULL"} {
    error "Net $target_net has no routed wire to rip up"
}

# This OpenROAD build exposes a scalar NDR width; check both metal layers for spacing.
set ndr_name RST_N_C_WIDE
create_ndr -name $ndr_name -width 2.1
assign_ndr -ndr $ndr_name -net $target_net
odb::dbWire_destroy $wire

set end_iter 64
if {[info exists ::env(DRT_END_ITER)]} { set end_iter $::env(DRT_END_ITER) }
detailed_route \
    -output_drc reports/route_rst_n_c_fix.rpt \
    -droute_end_iter $end_iter \
    -or_seed 42 \
    -verbose 1

write_db results/route_rst_n_c_fix.odb
write_def results/route_rst_n_c_fix.def
write_verilog -include_pwr_gnd -remove_cells $scl(fillers) \
    results/route_rst_n_c_fix_pwr.v
puts "Candidate written to results/route_rst_n_c_fix.{odb,def}; original route is unchanged."
