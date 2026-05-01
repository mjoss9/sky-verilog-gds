/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none
module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Unused outputs
  assign uo_out[7:1] = 7'd0;
  assign uio_out     = 8'd0;
  assign uio_oe      = 8'd0;

  pwm1 pwm_inst (
      .clk        (clk),
      .rst_ni     (rst_n),
      .ref_bits   (ui_in[1:0]),   // ui_in[0..1] = ref_bits
      .state_bits (ui_in[3:2]),   // ui_in[2..3] = state_bits
      .pwm_out    (uo_out[0])     // uo_out[0]   = PWM output
  );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in, ui_in[7:4], 1'b0};

endmodule
