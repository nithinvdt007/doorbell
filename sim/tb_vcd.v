`timescale 1ns/1ps
// Shared testbench for RTL and routed gate-level VCD capture.
module tb_vcd;
  reg clk=0, rst_n=0, btn_in=0; wire [6:0] seg; wire led, slp;
  integer i;
  doorbell_chip dut (.clk(clk),.rst_n(rst_n),.btn_in(btn_in),
                     .seg_out(seg),.led_blink(led),.sleep_led(slp));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, tb_vcd);
  end

  always #5 clk=~clk;
  task press; begin btn_in=1; repeat(70000) @(posedge clk); btn_in=0; repeat(70000) @(posedge clk); end endtask

  initial begin
    #12 rst_n=1; repeat(10) @(posedge clk);
    for(i=0;i<3;i=i+1) press;
    $finish;
  end
endmodule
