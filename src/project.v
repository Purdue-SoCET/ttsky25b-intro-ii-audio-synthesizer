/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_intro_ii_audio_synth (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7:1]  = '0;  // Unused dedicated outputs
  assign uio_out = '0;  // Not using bidirectional output path
  assign uio_oe  = '0;  // Will use ALL bidirectional pins as inputs

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[7:6], 1'b0};

  // Instantiate project
  audio_synth_top audio_synth_proj (
    .clk(clk),
    .n_rst(rst_n),
    .keypad_i({uio_in[5:0], ui_in}),
    .pwm(uo_out[0])
  );

endmodule
