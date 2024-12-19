`timescale 1ns / 1ps
module var2_2(
    input wire clk,
    input wire rst_n,
    input wire d,
    input wire t,
    output reg q_ff,
    output reg q_tff
);
    always @(posedge clk) begin
        if (!rst_n)
            q_ff <= 1'b0;
        else
            q_ff <= d;
    end
    always @(posedge clk) begin
        if (!rst_n)
            q_tff <= 1'b0;
        else if (t)
            q_tff <= ~q_tff;
    end
endmodule