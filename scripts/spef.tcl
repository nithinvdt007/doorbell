# Extract parasitics with the PDK's OpenRCX rules and write a SPEF (INFORMATION ONLY).
# The rules file has zero capacitance coefficients, so the result is not valid RC.
source scripts/common.tcl
read_liberty $scl(lib,typ)
read_liberty $pads(typ)
read_db results/route.odb
define_process_corner -ext_model_index 0 $scl(rcx_rules)
extract_parasitics -ext_model_file $scl(rcx_rules)
write_spef results/route_rcx.spef
puts "CP8D SPEF COMPLETED"
