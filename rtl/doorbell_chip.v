module doorbell_chip (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       btn_in,
    output wire [6:0] seg_out,
    output wire       led_blink,
    output wire       sleep_led
);
    wire clk_c, rst_n_c, btn_c, led_c, sleep_c;
    wire [6:0] seg_c;

    // Reset synchronizer: asynchronous assertion, synchronous deassertion.
    // The two flops break the reset fanout and prevent metastable release
    // from resetting different flops on different cycles.
    reg rst_sync_0, rst_sync_1;
    reg rst_zero;
    wire rst_sync_d;

    // A real cell-based constant-high source avoids VDDCON/VSSCON tie cells,
    // which have no physical layout and break LVS pin matching.
    always @(posedge clk_c or negedge rst_n_c) begin
        if (!rst_n_c)
            rst_zero <= 1'b0;
        else
            rst_zero <= rst_zero;
    end
    INVR00 u_rst_tie_hi (.IN1(rst_zero), .OUT1(rst_sync_d));

    always @(posedge clk_c or negedge rst_n_c) begin
        if (!rst_n_c) begin
            rst_sync_0 <= 1'b0;
            rst_sync_1 <= 1'b0;
        end else begin
            rst_sync_0 <= rst_sync_d;
            rst_sync_1 <= rst_sync_0;
        end
    end

    SPAD00 u_pad_clk (.PADIN(clk),   .OUT1(clk_c));
    SPAD00 u_pad_rst (.PADIN(rst_n), .OUT1(rst_n_c));
    SPAD00 u_pad_btn (.PADIN(btn_in),   .OUT1(btn_c));

    OTPD01 u_pad_seg0 (.IN1(seg_c[0]), .PAD(seg_out[0]));
    OTPD01 u_pad_seg1 (.IN1(seg_c[1]), .PAD(seg_out[1]));
    OTPD01 u_pad_seg2 (.IN1(seg_c[2]), .PAD(seg_out[2]));
    OTPD01 u_pad_seg3 (.IN1(seg_c[3]), .PAD(seg_out[3]));
    OTPD01 u_pad_seg4 (.IN1(seg_c[4]), .PAD(seg_out[4]));
    OTPD01 u_pad_seg5 (.IN1(seg_c[5]), .PAD(seg_out[5]));
    OTPD01 u_pad_seg6 (.IN1(seg_c[6]), .PAD(seg_out[6]));
    OTPD01 u_pad_led  (.IN1(led_c),    .PAD(led_blink));
    OTPD01 u_pad_slp  (.IN1(sleep_c),  .PAD(sleep_led));

    PVDD01 u_pad_vdd0 ();
    PVDD01 u_pad_vdd1 ();
    PVSS01 u_pad_vss0 ();
    PVSS01 u_pad_vss1 ();

    doorbell_top u_core (
        .clk(clk_c), .rst_n(rst_sync_1), .btn_in(btn_c),
        .seg_out(seg_c), .led_blink(led_c), .sleep_led(sleep_c)
    );
endmodule
