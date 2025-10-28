// $Id: $
// File name:   waveshaper.sv
// Created:     3/12/2025
// Author:      Nicha Muninnimit
// Description: waveshaper

`timescale 1ns / 10ps

module waveshaper (
    input logic clk, n_rst,
    input logic [7:0] scaled_count,
    input logic [1:0] mode,

    output logic [7:0] sample
);
    logic [7:0] n_sample;
    logic [7:0] triangle;

    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            sample <= 0;
        end else begin
            sample <= n_sample;
        end
    end

    always_comb begin
        triangle = 0;
        n_sample = sample;
        case (mode)

            2'b00: begin //off
                n_sample = 0;
            end

            2'b01: begin //square
                n_sample = (scaled_count > 127) ? 8'hFF : 8'h0;
            end

 	        2'b10: begin // sawtooth
    	        n_sample = scaled_count;
            end

 	        2'b11: begin// Triangle
    	        // if (scaled_count >= 128) begin
		        //     n_sample = 255 - scaled_count;
                // end else begin
		        //     n_sample = scaled_count;
                // end
                if (scaled_count < 128)
                    triangle = scaled_count;
                else
                    triangle = 255 - scaled_count;
                n_sample = (triangle << 1);  // triangle * 2
            end
            
            default: begin
                n_sample = sample;
            end
            
        endcase

    end

endmodule
