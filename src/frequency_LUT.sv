// $Id: $
// File name:   frequency_LUT.sv
// Created:     3/12/2025
// Author:      Nicha Muninnimit
// Description: pwm generator

`timescale 1ns / 10ps

module frequency_LUT (
    input logic [3:0] keycode,

    output logic [15:0] divider
);

    always_comb begin
        case (keycode)

            4'b0001: begin // C7
                divider = 23889;
            end

            4'b0010: begin // C#7
                divider = 22548;
            end

            4'b0011: begin // D7
                divider = 21283;
            end

            4'b0100: begin // D#7
                divider = 20088;
            end

            4'b0101: begin // E7
                divider = 18961;
            end

            4'b0110: begin // F7
                divider = 17895;
            end

            4'b0111: begin // F#7
                divider = 16892;
            end

            4'b1000: begin // G7
                divider = 15944;
            end

            4'b1001: begin // G#7
                divider = 15051;
            end

            4'b1010: begin // A7
                divider = 14205;
            end

            4'b1011: begin // A#7
                divider = 13408;
            end
            
            4'b1100: begin // B
                divider = 12655;
            end

            4'b1101: begin // C8
                divider = 11945;
            end

            4'b0000: begin
                divider = 0;
            end
            
            default: begin
                divider = 0;
            end

        endcase
    
    end

endmodule
