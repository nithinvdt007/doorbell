`timescale 1ns/1ps

// ===== doorbell_top (TOP FOR ASIC FLOW) =====
// =============================================================
// Chip Yatra - Smart Doorbell Counter
// Top-level module: doorbell_top
//
// Function:
//  - Debounces a noisy push-button input
//  - Detects each button "press" as a rising edge
//  - Increments a 4-bit visitor counter (wraps 0-9, BCD style)
//  - Decodes counter value to a 7-segment display
//  - Pulses an LED for ~1 clock-domain "blink window" on each press
//  - Implements a simple sleep/wake FSM for low power (Session 6)
//
// I/O Summary (also see docs/spec.md):
//  clk        : system clock
//  rst_n      : active-low asynchronous reset
//  btn_in     : raw push-button input (active-high, noisy)
//  seg_out[6:0] : 7-segment display segments (a-g), active-high
//  led_blink  : LED that pulses briefly on each registered press
//  sleep_led  : indicates chip is in SLEEP (low power) state
// =============================================================

module doorbell_top #(
    parameter DEBOUNCE_BITS = 16,   // debounce counter width
    parameter BLINK_BITS    = 20,   // blink pulse width
    parameter IDLE_BITS     = 24    // idle->sleep timeout width
) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        btn_in,

    output wire [6:0]  seg_out,
    output wire        led_blink,
    output wire        sleep_led
);

    // ---------------------------------------------------------
    // 1. Button Debouncer
    // ---------------------------------------------------------
    wire btn_clean;
    debouncer #(.CNT_WIDTH(DEBOUNCE_BITS)) u_debounce (
        .clk      (clk),
        .rst_n    (rst_n),
        .btn_in   (btn_in),
        .btn_out  (btn_clean)
    );

    // ---------------------------------------------------------
    // 2. Edge Detector (rising edge = one "press" event)
    // ---------------------------------------------------------
    wire press_pulse;
    edge_detector u_edge (
        .clk        (clk),
        .rst_n      (rst_n),
        .sig_in     (btn_clean),
        .rise_pulse (press_pulse)
    );

    // ---------------------------------------------------------
    // 3. Visitor Counter (0-9, BCD wrap)
    // ---------------------------------------------------------
    wire [3:0] count_val;
    bcd_counter u_counter (
        .clk      (clk),
        .rst_n    (rst_n),
        .inc      (press_pulse),
        .count    (count_val)
    );

    // ---------------------------------------------------------
    // 4. 7-Segment Decoder
    // ---------------------------------------------------------
    seg7_decoder u_decoder (
        .bcd_in  (count_val),
        .seg_out (seg_out)
    );

    // ---------------------------------------------------------
    // 5. LED Blink Pulse Generator
    // ---------------------------------------------------------
    blink_pulse #(.CNT_WIDTH(BLINK_BITS)) u_blink (
        .clk     (clk),
        .rst_n   (rst_n),
        .trigger (press_pulse),
        .pulse   (led_blink)
    );

    // ---------------------------------------------------------
    // 6. Sleep/Wake FSM (Low Power - Session 6)
    // ---------------------------------------------------------
    sleep_fsm #(.IDLE_BITS(IDLE_BITS)) u_sleep (
        .clk        (clk),
        .rst_n      (rst_n),
        .activity   (press_pulse),
        .sleep_out  (sleep_led)
    );

endmodule

// ===== debouncer =====
// =============================================================
// Chip Yatra - debouncer
// Session 4 (RTL Design): Sequential logic example #1
//
// Concept:
//   A mechanical push-button "bounces" - when pressed, the signal
//   can flicker between 0 and 1 several times within microseconds
//   before settling. If we don't filter this, our counter would
//   increment multiple times for ONE press.
//
// How it works:
//   We sample btn_in every clock cycle. If the input has been
//   STABLE (same value) for 2^CNT_WIDTH consecutive cycles, we
//   update btn_out to match it. Any change in btn_in resets the
//   stability counter.
// =============================================================

module debouncer #(
    parameter CNT_WIDTH = 16
) (
    input  wire clk,
    input  wire rst_n,
    input  wire btn_in,
    output reg  btn_out
);

    reg btn_sync_0, btn_sync_1;     // 2-stage synchronizer (avoids metastability)
    reg [CNT_WIDTH-1:0] stable_cnt;

    // 2-flop synchronizer: btn_in is an external/async signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            btn_sync_0 <= 1'b0;
            btn_sync_1 <= 1'b0;
        end else begin
            btn_sync_0 <= btn_in;
            btn_sync_1 <= btn_sync_0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stable_cnt <= {CNT_WIDTH{1'b0}};
            btn_out    <= 1'b0;
        end else if (btn_sync_1 != btn_out) begin
            // Input differs from current output - count stability
            if (stable_cnt == {CNT_WIDTH{1'b1}}) begin
                btn_out    <= btn_sync_1;   // accept new stable value
                stable_cnt <= {CNT_WIDTH{1'b0}};
            end else begin
                stable_cnt <= stable_cnt + 1'b1;
            end
        end else begin
            // Input matches output - reset counter, nothing to do
            stable_cnt <= {CNT_WIDTH{1'b0}};
        end
    end

endmodule

// ===== edge_detector =====
// =============================================================
// Chip Yatra - edge_detector
// Session 4 (RTL Design): Sequential logic example #2
//
// Concept:
//   We want ONE pulse (1 clock cycle) every time sig_in goes
//   from 0 -> 1 ("rising edge" = a button press). Without this,
//   the counter would keep incrementing for as long as the
//   button is held down.
//
// How it works:
//   Store the previous value of sig_in. Rising edge is detected
//   when current value = 1 AND previous value = 0.
// =============================================================

module edge_detector (
    input  wire clk,
    input  wire rst_n,
    input  wire sig_in,
    output wire rise_pulse
);

    reg sig_prev;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sig_prev <= 1'b0;
        else
            sig_prev <= sig_in;
    end

    assign rise_pulse = sig_in & ~sig_prev;

endmodule

// ===== bcd_counter =====
// =============================================================
// Chip Yatra - bcd_counter
// Session 4 (RTL Design): Sequential logic example #3 (memory!)
//
// Concept:
//   This is our "visitor counter". It counts 0,1,2,...,9,0,1,...
//   This is the first block that has REAL MEMORY - it remembers
//   its value across clock cycles, unlike combinational logic
//   which has no memory at all.
//
// How it works:
//   On every 'inc' pulse (1 clock wide), increment count by 1.
//   If count reaches 9, wrap back to 0 on the next increment.
// =============================================================

module bcd_counter (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       inc,
    output reg  [3:0] count
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'd0;
        else if (inc) begin
            if (count == 4'd9)
                count <= 4'd0;
            else
                count <= count + 4'd1;
        end
    end

endmodule

// ===== seg7_decoder =====
// =============================================================
// Chip Yatra - seg7_decoder
// Session 4 (RTL Design): Combinational logic example
//
// Concept:
//   This is PURE COMBINATIONAL LOGIC - the output depends ONLY
//   on the current input, with NO memory. It's a "lookup table":
//   given a 4-bit BCD digit (0-9), output the 7 segment signals
//   (a,b,c,d,e,f,g) needed to light up that digit on a common
//   7-segment display.
//
// Segment bit order: seg_out = {g,f,e,d,c,b,a}
// Active-HIGH: 1 = segment ON.
//
//      a
//    -----
//   |     |
//  f|     |b
//   |  g  |
//    -----
//   |     |
//  e|     |c
//   |     |
//    -----
//      d
// =============================================================

module seg7_decoder (
    input  wire [3:0] bcd_in,
    output reg  [6:0] seg_out   // {g,f,e,d,c,b,a}
);

    always @(*) begin
        case (bcd_in)
            4'd0: seg_out = 7'b0111111; // 0
            4'd1: seg_out = 7'b0000110; // 1
            4'd2: seg_out = 7'b1011011; // 2
            4'd3: seg_out = 7'b1001111; // 3
            4'd4: seg_out = 7'b1100110; // 4
            4'd5: seg_out = 7'b1101101; // 5
            4'd6: seg_out = 7'b1111101; // 6
            4'd7: seg_out = 7'b0000111; // 7
            4'd8: seg_out = 7'b1111111; // 8
            4'd9: seg_out = 7'b1101111; // 9
            default: seg_out = 7'b0000000; // blank for invalid input
        endcase
    end

endmodule

// ===== blink_pulse =====
// =============================================================
// Chip Yatra - blink_pulse
// Session 4 (RTL Design): Sequential logic - one-shot timer
//
// Concept:
//   When 'trigger' pulses high for 1 cycle, hold 'pulse' high
//   for 2^CNT_WIDTH clock cycles, then turn off automatically.
//   This is the "doorbell rang!" LED indicator.
// =============================================================

module blink_pulse #(
    parameter CNT_WIDTH = 20
) (
    input  wire clk,
    input  wire rst_n,
    input  wire trigger,
    output reg  pulse
);

    reg [CNT_WIDTH-1:0] cnt;
    reg running;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt     <= {CNT_WIDTH{1'b0}};
            running <= 1'b0;
            pulse   <= 1'b0;
        end else if (trigger) begin
            // (Re)start the pulse window
            cnt     <= {CNT_WIDTH{1'b0}};
            running <= 1'b1;
            pulse   <= 1'b1;
        end else if (running) begin
            if (cnt == {CNT_WIDTH{1'b1}}) begin
                running <= 1'b0;
                pulse   <= 1'b0;
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end

endmodule

// ===== sleep_fsm =====
// =============================================================
// Chip Yatra - sleep_fsm
// Session 6 (Low Power Design): FSM-based clock gating control
//
// Concept:
//   This is our chip's first FINITE STATE MACHINE (FSM) - the
//   most "real chip" concept in this design. It has two states:
//
//     AWAKE : normal operation (sleep_out = 0)
//     SLEEP : idle for too long, gate the clock to save power
//             (sleep_out = 1)
//
//   If no 'activity' (button press) occurs for 2^IDLE_BITS
//   cycles, the FSM moves to SLEEP. Any activity wakes it
//   immediately back to AWAKE.
//
//   In Session 6 we extend this design by using sleep_out to
//   gate the clock to the counter/display logic via a clock-gate
//   cell (see docs/low_power_notes.md for the gated-clock variant
//   and why naive clock gating with an AND gate can be risky -
//   it can create glitches; real designs use a "clock gating
//   cell" / integrated clock gate (ICG) which is glitch-free).
// =============================================================

module sleep_fsm #(
    parameter IDLE_BITS = 24
) (
    input  wire clk,
    input  wire rst_n,
    input  wire activity,
    output reg  sleep_out
);

    localparam AWAKE = 1'b0;
    localparam SLEEP = 1'b1;

    reg state;
    reg [IDLE_BITS-1:0] idle_cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= AWAKE;
            idle_cnt  <= {IDLE_BITS{1'b0}};
            sleep_out <= 1'b0;
        end else begin
            case (state)
                AWAKE: begin
                    if (activity) begin
                        idle_cnt <= {IDLE_BITS{1'b0}};
                    end else if (idle_cnt == {IDLE_BITS{1'b1}}) begin
                        state     <= SLEEP;
                        sleep_out <= 1'b1;
                    end else begin
                        idle_cnt <= idle_cnt + 1'b1;
                    end
                end

                SLEEP: begin
                    if (activity) begin
                        state     <= AWAKE;
                        sleep_out <= 1'b0;
                        idle_cnt  <= {IDLE_BITS{1'b0}};
                    end
                    // else: remain in SLEEP, sleep_out stays 1
                end
            endcase
        end
    end

endmodule

// ===== doorbell_top_lowpower + clock_gate_icg =====
// =============================================================
// Chip Yatra - Low Power Variant
// Session 6 (Low Power Design): Clock Gating
//
// Concept:
//   Clock gating = stop toggling the clock to a block of logic
//   when it's not needed. Since dynamic power is proportional to
//   how often signals switch (P = C * V^2 * f), if the counter's
//   clock never toggles while we sleep, the counter burns ZERO
//   dynamic power during sleep.
//
// THE COMMON MISTAKE (naive gating):
//   gated_clk = clk & enable;
//   This is DANGEROUS: if 'enable' changes while clk = 1, you
//   get a "glitch" - a short, unintended extra clock pulse that
//   can corrupt the counter's state. This is why simple AND-gate
//   clock gating is a classic interview "what's wrong with this
//   circuit?" question.
//
// THE CORRECT WAY (clock_gate_icg below):
//   An Integrated Clock Gate (ICG) is a small latch-based cell
//   that only allows 'enable' to change while clk = 0. This
//   guarantees gated_clk has no glitches. Real standard-cell
//   libraries (including Sky130) provide pre-verified ICG cells;
//   here we model the behavior in RTL for teaching purposes.
// =============================================================

module clock_gate_icg (
    input  wire clk_in,
    input  wire enable,     // 1 = clock passes through, 0 = gated low
    output wire clk_out
);

    reg en_latched;

    // Latch 'enable' only on the LOW phase of clk_in, so any
    // change in 'enable' cannot create a glitch on clk_out.
    always @(*) begin
        if (!clk_in)
            en_latched = enable;
    end

    assign clk_out = clk_in & en_latched;

endmodule


// =============================================================
// doorbell_top_lowpower
// Same function as doorbell_top, but the counter/display logic
// runs on a GATED clock that is disabled while sleep_out = 1.
// The sleep_fsm itself MUST stay on the ungated clock (it needs
// to keep counting idle time and detect wake-up events!).
// =============================================================

module doorbell_top_lowpower #(
    parameter DEBOUNCE_BITS = 16,
    parameter BLINK_BITS    = 20,
    parameter IDLE_BITS     = 24
) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        btn_in,

    output wire [6:0]  seg_out,
    output wire        led_blink,
    output wire        sleep_led
);

    wire btn_clean;
    wire press_pulse;
    wire [3:0] count_val;
    wire gated_clk;

    debouncer #(.CNT_WIDTH(DEBOUNCE_BITS)) u_debounce (
        .clk     (clk),
        .rst_n   (rst_n),
        .btn_in  (btn_in),
        .btn_out (btn_clean)
    );

    edge_detector u_edge (
        .clk        (clk),
        .rst_n      (rst_n),
        .sig_in     (btn_clean),
        .rise_pulse (press_pulse)
    );

    // ---------------------------------------------------------
    // Sleep FSM ALWAYS runs on the real clock - it is the thing
    // that wakes the chip up, so it cannot itself be gated off!
    // ---------------------------------------------------------
    sleep_fsm #(.IDLE_BITS(IDLE_BITS)) u_sleep (
        .clk       (clk),
        .rst_n     (rst_n),
        .activity  (press_pulse),
        .sleep_out (sleep_led)
    );

    // ---------------------------------------------------------
    // Gate the clock for the counter + display logic.
    // enable = ~sleep_led  ->  clock flows only when AWAKE.
    // ---------------------------------------------------------
    clock_gate_icg u_icg (
        .clk_in  (clk),
        .enable  (~sleep_led),
        .clk_out (gated_clk)
    );

    bcd_counter u_counter (
        .clk    (gated_clk),
        .rst_n  (rst_n),
        .inc    (press_pulse),
        .count  (count_val)
    );

    seg7_decoder u_decoder (
        .bcd_in  (count_val),
        .seg_out (seg_out)
    );

    blink_pulse #(.CNT_WIDTH(BLINK_BITS)) u_blink (
        .clk     (gated_clk),
        .rst_n   (rst_n),
        .trigger (press_pulse),
        .pulse   (led_blink)
    );

endmodule

