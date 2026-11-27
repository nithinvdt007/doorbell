source scripts/common.tcl
read_db results/placed.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
scl_set_parasitics
set_dont_use $dont_use_cells
estimate_parasitics -placement

# Single-output BUFF00 only; no dummy loads (they break LVS pin matching).
clock_tree_synthesis \
  -root_buf $scl(cts_buffer) \
  -buf_list [list $scl(cts_buffer)] \
  -sink_clustering_enable \
  -sink_clustering_size 20 \
  -dont_use_dummy_load
set_propagated_clock [all_clocks]
repair_clock_nets
estimate_parasitics -placement

# Optional hold repair, OFF by default. The old flow ran repair_timing here and
# it inserted five buffers on the btn_in path to fix a false hold violation.
# Turn on only if sta shows real reg-to-reg hold violations:  HOLD_FIX=1 ./run.sh cts
if {[info exists ::env(HOLD_FIX)] && $::env(HOLD_FIX) eq "1"} {
    puts "HOLD_FIX enabled"
    repair_timing -hold -hold_margin 0.3
}

# Re-legalize after CTS (padding is process-local, so apply it again)
scl_apply_implant_padding
detailed_placement
check_placement -verbose

# Fill remaining row gaps with filler cells: continuous rails and wells
scl_release_implant_padding
filler_placement $scl(fillers)
check_placement -verbose
global_connect

write_db  results/cts.odb
write_def results/cts.def
puts "CP8D CTS COMPLETED"

