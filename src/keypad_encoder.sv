`default_nettype none
// $Id: $
// File name:   keypad_encoder.sv
// Created:     3/12/2025
// Author:     Vid Suresh
// Description: keypad encoder

`timescale 1ns / 10ps


module keypad_encoder (
    input logic [13:0]keypad_i,
    input logic clk, 
    input logic n_rst, 
    output logic [3:0] keycode, 
    output logic modekey);
    
    logic [13:0] keypad_reg;
    logic [3:0]  n_keycode;
    logic n_modekey;

    always_ff @(posedge clk, negedge n_rst) begin 
        if (~n_rst) begin
            keypad_reg <= 0;
        end else begin
            keypad_reg <= keypad_i;
        end
    end

    always_ff @(posedge clk or negedge n_rst) begin
        if (~n_rst) begin
            keycode <= 4'b0000;
            modekey <= 1'b0;
        end else begin
            keycode <= n_keycode;
            modekey <= n_modekey;
        end
    end
    always_comb begin 
        n_keycode = 4'b0000;          // Default output
        n_modekey = 1'b0;           // Default mode select
    

        case (keypad_reg)
            14'b00000000000001: n_keycode = 4'b0001; // Key 0
            14'b00000000000010: n_keycode = 4'b0010; // Key 1
            14'b00000000000100: n_keycode = 4'b0011; // Key 2
            14'b00000000001000: n_keycode = 4'b0100; // Key 3
            14'b00000000010000: n_keycode = 4'b0101; // Key 4
            14'b00000000100000: n_keycode = 4'b0110; // Key 5
            14'b00000001000000: n_keycode = 4'b0111; // Key 6
            14'b00000010000000: n_keycode = 4'b1000; // Key 7
            14'b00000100000000: n_keycode = 4'b1001; // Key 8
            14'b00001000000000: n_keycode = 4'b1010; // Key 9
            14'b00010000000000: begin
                n_keycode = 4'b1011; // Key A
                //n_modekey = 1'b1; // Mode select active
            end
            14'b00100000000000: begin
                n_keycode = 4'b1100; // Key B
                //n_modekey = 1'b1; // Mode select active
            end
            14'b01000000000000: begin
                n_keycode = 4'b1101; // Key C
                //n_modekey = 1'b1; // Mode select active
            end
            14'b10000000000000: begin 
                n_keycode = keycode; // Key D
                n_modekey = 1'b1; // Mode select active
            end
            default: n_keycode = 0; // Default case
        endcase
    end

endmodule