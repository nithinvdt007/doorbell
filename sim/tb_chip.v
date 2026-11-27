`timescale 1ns/1ps
// Chip-level directed TB. Production RTL has DEBOUNCE_BITS=16, so a press
// must be held for >2^16 clocks. Used for RTL vs routed-netlist equivalence.
module tb_chip;
  reg clk=0, rst_n=0, btn_in=0; wire [6:0] seg; wire led, slp;
  integer i;
  doorbell_chip dut (.clk(clk),.rst_n(rst_n),.btn_in(btn_in),
                     .seg_out(seg),.led_blink(led),.sleep_led(slp));
  always #5 clk=~clk;
  task press; begin btn_in=1; repeat(70000) @(posedge clk); btn_in=0; repeat(70000) @(posedge clk); end endtask
  initial begin
    #12 rst_n=1; repeat(10) @(posedge clk);
    $display("T=%0t RESET seg=%b led=%b sleep=%b",$time,seg,led,slp);
    for(i=0;i<3;i=i+1) begin
      press;
      $display("T=%0t PRESS%0d seg=%b led=%b sleep=%b",$time,i+1,seg,led,slp);
    end
    $finish;
  end
endmodule
