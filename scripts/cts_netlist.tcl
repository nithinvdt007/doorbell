source scripts/common.tcl
read_db results/cts.odb
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
write_verilog -include_pwr_gnd -remove_cells $scl(fillers) verify/preroute/cts_output_pwr.v
puts "CP8D PRE-ROUTE NETLIST COMPLETED"

