# Re-run global routing with metal2 capacity held back, then detail-route into new files.
set_thread_count [exec nproc]
source scripts/common.tcl
read_db results/route_pass1.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_sdc constraints/doorbell.sdc
scl_set_parasitics
set_propagated_clock [all_clocks]
set_routing_layers -signal metal1-metal2 -clock metal1-metal2
set_global_routing_layer_adjustment metal2 0.2
global_route -use_cugr -critical_nets_percentage 0 -guide_file results/route_g.guide -verbose
detailed_route -output_drc reports/route_g.rpt -droute_end_iter 30 -verbose 1
write_db results/route_g.odb
write_def results/route_g.def
puts "GUIDE RETRY COMPLETED"
