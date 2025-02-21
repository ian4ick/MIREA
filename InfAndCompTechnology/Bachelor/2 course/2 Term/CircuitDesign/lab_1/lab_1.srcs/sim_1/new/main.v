`timescale 1ns / 1ps
module main();
reg clk, sync;
reg [3:0] val;
wire [7:0] anods;
wire [6:0] segments;

integer count;
reg is_random;
initial
begin
    clk = 0;
    val = 7;
    count = -1;
    #50 $srandom(33985);
    is_random = 1;
end
always #10 clk = ~clk;

always @(posedge clk)
begin
    count = count + 1;
    case(count)
        29: is_random = 0;
        30: sync = 1;
        129: is_random = 1;       
        159: is_random = 0;
        160: sync = 0;
        161: val = 5;
        262: is_random = 1;
        292: is_random = 0;
        293: sync = 1;
        default: 
            begin
            if (is_random)
                sync = $random;
            end
    endcase
end

reg [31:0] numbers;
reg [3:0] number;
always #10
begin
    case (segments)
        7'b1000000: number = 4'h0;
        7'b1111001: number = 4'h1;
        7'b0100100: number = 4'h2;
        7'b0110000: number = 4'h3;
        7'b0011001: number = 4'h4;
        7'b0010010: number = 4'h5;
        7'b0000010: number = 4'h6;
        7'b1111000: number = 4'h7;
        7'b0000000: number = 4'h8;
        7'b0010000: number = 4'h9;
        7'b0001000: number = 4'ha;
        7'b0000011: number = 4'hb;
        7'b1000110: number = 4'hc;
        7'b0100001: number = 4'hd;
        7'b0000110: number = 4'he;
        7'b0001110: number = 4'hf;
        default: number = 4'hx;
    endcase
    if (~anods[0])
        numbers[3:0] = number;
    if (~anods[1])
        numbers[7:4] = number;
    if (~anods[2])
        numbers[11:8] = number;
    if (~anods[3])
        numbers[15:12] = number;
    if (~anods[4])
        numbers[19:16] = number;
    if (~anods[5])
        numbers[23:20] = number;
    if (~anods[6])
        numbers[27:24] = number;
    if (~anods[7])
        numbers[31:28] = number;
end
up_level display(
    .clk(clk),
    .btn_c(sync),
    .SW(val),
    .AN(anods),
    .SEG(segments)
);
endmodule
