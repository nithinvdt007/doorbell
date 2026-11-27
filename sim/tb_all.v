`timescale 1ns/1ps
// Self-checking testbenches for the doorbell RTL, adapted to the modules
// implemented in rtl/doorbell.v. Select one with Verilator --top-module.

module tb_debouncer;
  reg clk=0, rst_n=0, btn_in=0; wire btn_out; integer errors=0;
  debouncer #(.CNT_WIDTH(4)) dut (.clk(clk),.rst_n(rst_n),.btn_in(btn_in),.btn_out(btn_out));
  always #5 clk=~clk;
  initial begin
    #12 rst_n=1; btn_in=1; repeat(40) @(posedge clk);
    if(btn_out!==1'b1) begin $display("FAIL stable press"); errors=errors+1; end else $display("PASS stable press");
    btn_in=0; @(posedge clk); btn_in=1; @(posedge clk); btn_in=0; @(posedge clk); btn_in=1; @(posedge clk); btn_in=0; @(posedge clk);
    if(btn_out!==1'b1) begin $display("FAIL bounce filtered"); errors=errors+1; end else $display("PASS bounce filtered");
    btn_in=0; repeat(40) @(posedge clk);
    if(btn_out!==1'b0) begin $display("FAIL settle low"); errors=errors+1; end else $display("PASS settle low");
    if(errors==0) $display("tb_debouncer: ALL PASS"); else $display("tb_debouncer: %0d FAIL",errors);
    $finish;
  end
endmodule

module tb_edge_detector;
  reg clk=0, rst_n=0, sig_in=0; wire rise_pulse; integer errors=0, pulses=0;
  edge_detector dut (.clk(clk),.rst_n(rst_n),.sig_in(sig_in),.rise_pulse(rise_pulse));
  always #5 clk=~clk;
  always @(posedge clk) if(rise_pulse) pulses=pulses+1;
  initial begin
    #12 rst_n=1; @(posedge clk); #1 sig_in=1; repeat(4) @(posedge clk);
    if(sig_in!==1'b1) begin $display("FAIL sig"); errors=errors+1; end
    #1 sig_in=0; repeat(3) @(posedge clk);
    $display("pulses=%0d (expect 1)",pulses);
    if(pulses!=1) begin $display("FAIL edge count"); errors=errors+1; end
    if(errors==0) $display("tb_edge_detector: ALL PASS"); else $display("tb_edge_detector: %0d FAIL",errors);
    $finish;
  end
endmodule

module tb_bcd_counter;
  reg clk=0, rst_n=0, inc=0; wire [3:0] count; integer errors=0,i;
  bcd_counter dut (.clk(clk),.rst_n(rst_n),.inc(inc),.count(count));
  always #5 clk=~clk;
  initial begin
    #12 rst_n=1; @(posedge clk);
    if(count!==4'd0) begin $display("FAIL reset"); errors=errors+1; end else $display("PASS reset");
    for(i=1;i<=9;i=i+1) begin inc=1; @(posedge clk); inc=0; @(posedge clk);
      if(count!==i[3:0]) begin $display("FAIL count %0d got %0d",i,count); errors=errors+1; end end
    $display("count after 9 = %0d",count);
    inc=1; @(posedge clk); inc=0; @(posedge clk);
    if(count!==4'd0) begin $display("FAIL wrap"); errors=errors+1; end else $display("PASS wrap 9->0");
    if(errors==0) $display("tb_bcd_counter: ALL PASS"); else $display("tb_bcd_counter: %0d FAIL",errors);
    $finish;
  end
endmodule

module tb_seg7_decoder;
  reg [3:0] bcd=0; wire [6:0] seg; integer errors=0,i;
  reg [6:0] exp [0:15];
  seg7_decoder dut (.bcd_in(bcd),.seg_out(seg));
  initial begin
    exp[0]=7'b0111111; exp[1]=7'b0000110; exp[2]=7'b1011011; exp[3]=7'b1001111;
    exp[4]=7'b1100110; exp[5]=7'b1101101; exp[6]=7'b1111101; exp[7]=7'b0000111;
    exp[8]=7'b1111111; exp[9]=7'b1101111;
    for(i=10;i<=15;i=i+1) exp[i]=7'b0000000;
    for(i=0;i<=15;i=i+1) begin bcd=i[3:0]; #1;
      if(seg!==exp[i]) begin $display("FAIL bcd=%0d seg=%b exp=%b",i,seg,exp[i]); errors=errors+1; end end
    if(errors==0) $display("tb_seg7_decoder: ALL 16 PASS"); else $display("tb_seg7_decoder: %0d FAIL",errors);
    $finish;
  end
endmodule

module tb_sleep_fsm;
  reg clk=0, rst_n=0, activity=0; wire sleep_out; integer errors=0;
  sleep_fsm #(.IDLE_BITS(4)) dut (.clk(clk),.rst_n(rst_n),.activity(activity),.sleep_out(sleep_out));
  always #5 clk=~clk;
  initial begin
    #12 rst_n=1; @(posedge clk);
    if(sleep_out!==1'b0) begin $display("FAIL awake"); errors=errors+1; end else $display("PASS awake");
    repeat(20) @(posedge clk);
    if(sleep_out!==1'b1) begin $display("FAIL sleep timeout"); errors=errors+1; end else $display("PASS sleep timeout");
    activity=1; @(posedge clk); activity=0; @(posedge clk);
    if(sleep_out!==1'b0) begin $display("FAIL wake"); errors=errors+1; end else $display("PASS wake");
    if(errors==0) $display("tb_sleep_fsm: ALL PASS"); else $display("tb_sleep_fsm: %0d FAIL",errors);
    $finish;
  end
endmodule

module tb_doorbell_top;
  reg clk=0, rst_n=0, btn_in=0; wire [6:0] seg; wire led, slp; integer errors=0;
  reg [6:0] tab [0:9]; integer i;
  doorbell_top #(.DEBOUNCE_BITS(3),.BLINK_BITS(3),.IDLE_BITS(6)) dut
    (.clk(clk),.rst_n(rst_n),.btn_in(btn_in),.seg_out(seg),.led_blink(led),.sleep_led(slp));
  always #5 clk=~clk;
  task press; begin btn_in=1; repeat(12) @(posedge clk); btn_in=0; repeat(12) @(posedge clk); end endtask
  initial begin
    tab[0]=7'b0111111; tab[1]=7'b0000110; tab[2]=7'b1011011; tab[3]=7'b1001111; tab[4]=7'b1100110;
    tab[5]=7'b1101101; tab[6]=7'b1111101; tab[7]=7'b0000111; tab[8]=7'b1111111; tab[9]=7'b1101111;
    #12 rst_n=1; repeat(5) @(posedge clk);
    if(seg!==tab[0]) begin $display("FAIL reset display %b",seg); errors=errors+1; end else $display("PASS reset display 0");
    press; if(seg!==tab[1]) begin $display("FAIL first press %b",seg); errors=errors+1; end else $display("PASS first press -> 1");
    for(i=0;i<8;i=i+1) press;
    if(seg!==tab[9]) begin $display("FAIL count to 9 %b",seg); errors=errors+1; end else $display("PASS count to 9");
    press; if(seg!==tab[0]) begin $display("FAIL wrap %b",seg); errors=errors+1; end else $display("PASS wrap 9->0");
    if(errors==0) $display("tb_doorbell_top: ALL PASS"); else $display("tb_doorbell_top: %0d FAIL",errors);
    $finish;
  end
endmodule
