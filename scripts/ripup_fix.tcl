set_thread_count [exec nproc]
source scripts/common.tcl
read_db results/route_pass1.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
scl_set_parasitics
set_propagated_clock [all_clocks]
set_routing_layers -signal metal1-metal2 -clock metal1-metal2
# Extra detailed route passes focused on the violations
detailed_route -output_drc reports/route_ripup.rpt -droute_end_iter 60 \
    -verbose 1 -or_seed 42 -or_k 5
write_db  results/route_ripup.odb
write_def results/route_ripup.def
write_verilog -include_pwr_gnd results/route_ripup_pwr.v
puts "RIPUP FIX COMPLETED"
