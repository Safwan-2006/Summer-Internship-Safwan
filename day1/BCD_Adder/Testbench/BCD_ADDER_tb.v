`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 22:16:14
// Design Name: 
// Module Name: BCD_ADDER_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BCD_ADDER_tb();
reg [3:0]a_tb;
reg [3:0]b_tb;
reg c_tb;
wire [3:0]sum_tb;
wire cout_tb;

BCD_ADDER dut(a_tb, b_tb, c_tb, sum_tb, cout_tb);

initial
begin
{a_tb,b_tb,c_tb} = 0;
end
initial
begin
a_tb = 4'b0000; b_tb = 4'b0000; c_tb = 1'b0;
#50;
a_tb = 4'b0010; b_tb = 4'b0011; c_tb = 1'b0;
#50;
a_tb = 4'b0101; b_tb = 4'b0100; c_tb = 1'b0;
#50;
a_tb = 4'b0110; b_tb = 4'b0111; c_tb = 1'b0;
#50;
a_tb = 4'b1000; b_tb = 4'b1000; c_tb = 1'b0;
#50; 

$monitor("The value of a_tb is %b The value of b_tb is %b The value of c_tb is %b The value of sum_tb is %b The value of cout_tb is %b ",a_tb,b_tb,c_tb,sum_tb,cout_tb);
end
endmodule
