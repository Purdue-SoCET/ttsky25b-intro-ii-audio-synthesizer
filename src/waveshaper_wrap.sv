// $Id: $
// File name:   waveshaper_wrap.sv
// Created:     4/11/2025
// Author:      Nicha Muninnimit
// Description: sequential divider to scale down 16 bit count
//              to 8 bit count. we are using a sequential divider to comply
//              with the hardware contraints of the tinytapeout and not cause
//              timing issues.

`timescale 1ns / 10ps

module waveshaper_wrap (
    input logic clk, n_rst, sample_now,
    input logic [15:0] divider, count,
    input logic [1:0] mode,

    output logic [7:0] sample,
    output logic done
);
    logic [7:0] scaled_count;

    sequential_divider seq_div (
        .clk(clk),
        .n_rst(n_rst),
        .divider({8'b0, divider}),
        .count({count, 8'b0}),
        .sample_now(sample_now),

        .done(done),
        .scaled_count(scaled_count)
    );

    waveshaper shaper (
        .clk(clk),
        .n_rst(n_rst),
        .scaled_count(scaled_count),
        .mode(mode),

        .sample(sample)
    );

endmodule
