// $Id: $
// File name:   sequential_divider.sv
// Created:     3/12/2025
// Author:      Nicha Muninnimit
// Description: sequential divider to scale down 16 bit count
//              to 8 bit count. we are using a sequential divider to comply
//              with the hardware contraints of the tinytapeout and not cause
//              timing issues.

`timescale 1ns / 10ps

module sequential_divider (
    input logic clk, n_rst, sample_now,
    input logic [23:0] divider, 
    input logic [23:0] count,

    output logic [7:0] scaled_count,
    output logic done
);
    logic [47:0] n_dividend, dividend;
    logic [4:0] n, n_n;
    logic [23:0] quo, n_quo;

    typedef enum logic [2:0] {
        IDLE,
        LSHIFT,
        COMPARE,
        SUB_SET,
        CHECK_CNT
    } state_t;

    state_t state, n_state;

    always_ff @(posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            dividend <= 0;
            state <= IDLE;
            n <= 0;
            quo <= 0;
        end else begin
            dividend <= n_dividend;
            state <= n_state;
            n <= n_n;
            quo <= n_quo;
        end
    end

    always_comb begin
        n_dividend = dividend;
        n_state = state;
        done = 0;
        n_n = n;
        n_quo = quo;

        case(state) 
            IDLE: begin
                if (sample_now & (divider != 0)) begin
                    n_state = LSHIFT;
                    n_dividend = {24'b0, count};
                    n_quo = 0;
                end
            end
            
            LSHIFT: begin
                n_dividend = {dividend[46:0], 1'b0};
                n_quo = {quo[22:0], 1'b0};
                n_state = COMPARE;
            end

            COMPARE: begin
                if (dividend[47:24] >= divider) begin
                    n_state = SUB_SET;
                end else begin
                    n_state = CHECK_CNT;
                end
            end

            SUB_SET: begin
                n_dividend = {dividend[47:24] - divider, dividend[23:0]};
                n_quo = {quo[23:1], 1'b1};
                n_state = CHECK_CNT;
            end   

            CHECK_CNT: begin
                if (n == 23) begin
                    done = 1;
                    n_state = IDLE;
                    n_n = 0;
                end else begin
                    n_n = n + 1;
                    n_state = LSHIFT;
                end
            end        

            default: begin
                n_dividend = dividend;
            end

        endcase
    end

    assign scaled_count = quo[7:0];
    

endmodule
