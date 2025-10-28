`timescale 1ns / 10ps

module FSM(
    input logic n_rst,
    input logic modekey,
    input logic clk,
    
    output logic [1:0] mode);

    parameter [2:0] IDLE = 3'b000;
    parameter [2:0] WAITKEY_1 = 3'b001;
    parameter [2:0] SQUARE = 3'b011;
    parameter [2:0] WAITKEY_2 = 3'b010;
    parameter [2:0] SAW = 3'b110;
    parameter [2:0] WAITKEY_3 = 3'b111;
    parameter [2:0] TRIANGLE = 3'b101;
    parameter [2:0] WAITKEY_4 = 3'b100;
    
    logic [2:0] fsmState;
    logic [2:0] nextState;

    always_ff @ (posedge clk, negedge n_rst) begin //DFF memory
        if(~n_rst) begin
            fsmState <= IDLE;
        end else begin
            fsmState <= nextState;
        end
    end

    always_comb begin //Next state logic
        case (fsmState)
            IDLE: begin        
                if (modekey == 1'b0) begin
                    nextState = IDLE;
                end else begin
                    nextState = WAITKEY_1;
                end
            end

            WAITKEY_1: begin
                if (modekey == 1'b0) begin
                    nextState = SQUARE;
                end else begin
                    nextState = WAITKEY_1;
                end
            end

            SQUARE: begin        
                if (modekey == 1'b0) begin
                    nextState = SQUARE;
                end else begin 
                    nextState = WAITKEY_2;
                end
            end

            WAITKEY_2: begin      
                if (modekey == 1'b0) begin
                    nextState = SAW;
                end else begin 
                    nextState = WAITKEY_2;
                end
            end

            SAW: begin           
                if (modekey == 1'b0) begin
                    nextState = SAW;
                end else begin 
                    nextState = WAITKEY_3;
                end
            end

            WAITKEY_3: begin     
                if (modekey == 1'b0) begin 
                    nextState = TRIANGLE;
                end else begin 
                    nextState = WAITKEY_3;
                end 
            end

            TRIANGLE: begin      
                if (modekey == 1'b0) begin 
                    nextState = TRIANGLE;
                end else begin 
                    nextState = WAITKEY_4;
                end
            end

            WAITKEY_4: begin     
                if (modekey == 1'b0) begin 
                    nextState = IDLE;
                end else begin 
                    nextState = WAITKEY_4;
                end
            end

            default: begin       
                nextState = fsmState;
            end
            
        endcase
    end

    always_comb begin//output logic
        case(fsmState)
                IDLE:       mode = 2'b00;
                WAITKEY_1:  mode = 2'b00;
                SQUARE:     mode = 2'b01;
                WAITKEY_2:  mode = 2'b01;
                SAW:        mode = 2'b10;
                WAITKEY_3:  mode = 2'b10;
                TRIANGLE:   mode = 2'b11;
                WAITKEY_4:  mode = 2'b11;
                default:    mode = 2'b00;
        endcase
    end
endmodule