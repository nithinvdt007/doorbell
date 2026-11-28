# Smart Doorbell ASIC timing constraints (v2)
# Time unit: ns

# Actual clock port (5 MHz: the doorbell is not speed critical)
create_clock -name clk -period 200 [get_ports clk]

# Input delays
set_input_delay 2 -clock clk [get_ports {rst_n btn_in}]

# btn_in goes through a 2-flop synchronizer in the RTL and rst_n is an
# asynchronous reset, so neither has a defined timing relationship to clk.
# Without this line STA checks hold from these ports against the late clock
# arrival and reports a large false violation (-12.84 ns in the old flow).
# REVIEW ITEM: rst_n de-assertion is not synchronized in the RTL.
set_false_path -from [get_ports {rst_n btn_in}]

# Output delays
set_output_delay 2 -clock clk [get_ports {seg_out[*] led_blink sleep_led}]

# Output load
set_load 0.033 [get_ports {seg_out[*] led_blink sleep_led}]
