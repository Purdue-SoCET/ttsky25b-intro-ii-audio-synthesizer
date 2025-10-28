// $Id: $
// File name:   clock_divider.sv
// Created:     3/12/2025
// Author:      Nicha Muninnimit
// Description: clock divider

`timescale 1ns / 10ps

module clock_divider (
    input logic clk, n_rst,

    output logic sample_now
);
    logic [7:0] count, n_count;
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            count <= 0;
        end else begin
            count <= n_count;
        end
    end

    always_comb begin
        if (count >= 63) begin
            n_count = 0;
        end else begin
            n_count = count + 1; 
        end
    end

    assign sample_now = (count == 63) ? 1 : 0;

endmodule
