`default_nettype none

// ── PWM submodule ────────────────────────────────────────────────────────────
module pwm1 (
    input  wire       clk,
    input  wire       rst_ni,
    input  wire [1:0] ref_bits,
    input  wire [1:0] state_bits,
    output reg        pwm_out
);
    reg [1:0] counter;

    always @(posedge clk or negedge rst_ni) begin
        if (!rst_ni) begin
            counter <= 2'd0;
            pwm_out <= 1'b0;
        end else begin
            counter <= counter + 1;
            pwm_out <= (counter < ref_bits) ? 1'b1 : 1'b0;
        end
    end
endmodule

// ── Top-level TT wrapper ─────────────────────────────────────────────────────
module tt_um_example (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    assign uo_out[7:1] = 7'd0;
    assign uio_out     = 8'd0;
    assign uio_oe      = 8'd0;

    pwm1 pwm_inst (
        .clk        (clk),
        .rst_ni     (rst_n),
        .ref_bits   (ui_in[1:0]),
        .state_bits (ui_in[3:2]),
        .pwm_out    (uo_out[0])
    );

    wire _unused = &{ena, uio_in, ui_in[7:4], 1'b0};
endmodule
