# Retry from the pass-1 route. Reset fanout repair is an opt-in experiment; the
# CP8D trial inserted 74 buffers on rst_n_c and failed legalization/congestion.
# Does NOT call scl_correct_router_pin_abstracts / scl_add_cell_via_keepouts:
# their changes are already stored in route_pass1.odb and would be applied twice.
set_thread_count [exec nproc]
source scripts/common.tcl
set seed $::env(SEED)
set end_iter 20
if {[info exists ::env(DRT_END_ITER)]} { set end_iter $::env(DRT_END_ITER) }
read_db results/route_pass1.odb
# route_pass1.odb contains the baseline detailed route and guides. By default,
# retries only vary detailed routing; the opt-in block adds reset repair.
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
scl_set_parasitics
set_propagated_clock [all_clocks]
set_routing_layers -signal metal1-metal2 -clock metal1-metal2

if {[info exists ::env(APPLY_RST_BUFFERING)] && $::env(APPLY_RST_BUFFERING) eq "1"} {
    # The baseline pass has detailed wires, so this removes only rst_n_c's wire.
    # Protect every other existing net because repair_design has no per-net
    # option in this OpenROAD build.
    set block [ord::get_db_block]
    set reset_net [$block findNet rst_n_c]
    if {$reset_net eq "NULL"} {
        error "Net rst_n_c was not found in results/route_pass1.odb"
    }
    set reset_wire [$reset_net getWire]
    if {$reset_wire eq "NULL"} {
        error "Net rst_n_c has no detailed wire in results/route_pass1.odb"
    }
    global_route -start_incremental
    odb::dbWire_destroy $reset_wire
    set protected_nets [get_nets *]
    set_dont_touch $protected_nets
    unset_dont_touch [get_nets rst_n_c]
    set_max_fanout 32 [current_design]
    estimate_parasitics -placement
    repair_design -max_wire_length 1000000 -verbose
    unset_dont_touch $protected_nets
    detailed_placement -incremental
    global_route -end_incremental -guide_file "results/route_s$seed.guide" -verbose
} else {
    puts "Reset buffering experiment disabled; set APPLY_RST_BUFFERING=1 to test it."
}

detailed_route -output_drc reports/route_s$seed.rpt -droute_end_iter $end_iter -or_seed $seed -or_k 3 -verbose 1
set route_db [file normalize [format "results/route_s%s.odb" $seed]]
set route_def [file normalize [format "results/route_s%s.def" $seed]]
write_db $route_db
write_def $route_def
puts "CP8D ROUTING SEED $seed COMPLETED"
