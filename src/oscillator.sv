`timescale 1ns / 10ps

module oscillator(
    input logic         clk,
    input logic         n_rst,
    input logic  [15:0] divider,
    output logic [15:0] count
);

logic [15:0] n_count;

always_ff @(posedge clk, negedge n_rst) begin
if(~n_rst) begin
    count <= 0;
end
else begin// divider is a "frequency". this tells us out of how many clocks out of 2^16 we sample
                                 // if our clock is above that, we do what is determined by the mode, else we 
    count <= n_count;
end
end

always_comb begin
    if(count >= divider) begin
        n_count = 16'h0001;
    end
    else begin
        n_count = count + 1;
    end
end
endmodule
