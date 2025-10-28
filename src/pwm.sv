// $Id: $
// File name:   pwm.sv
// Created:     3/12/2025
// Author:      Nicha Muninnimit
// Description: pwm

`timescale 1ns / 10ps

module pwm (
    input logic clk, n_rst,
    input logic [7:0] sample,
    input logic done,

    output logic pwm
);
    logic [7:0] n_count, count, active_sample, n_active_sample;
    logic n_pwm;
    
    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            count <= 1;
            pwm <= 0;
            active_sample <= 0;
        end else begin
            count <= n_count;
            pwm <= n_pwm;
            active_sample <= n_active_sample;
        end
    end

    always_comb begin
        n_count = (count == 255) ? 1 : count + 1;
        n_active_sample = active_sample;
        if (done) begin
            n_active_sample = sample;
        end

        n_pwm = (count <= active_sample) ? 1 : 0;
    end

endmodule
