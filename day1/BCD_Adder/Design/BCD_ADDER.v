`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:52:19
// Design Name: 
// Module Name: BCD_ADDER
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


module BCD_ADDER(
input [3:0]a,
input [3:0]b,
input c,
output [3:0]sum,
output cout);

wire [3:0] s;     
wire cout1;           
wire [3:0] w;      
wire cout2;  

RIPPLE_CARRY_ADDER RCA1 (a, b, c, s, cout1);
assign cout = cout1 | (s[3] & s[2]) | (s[3] & s[1]);
assign w = {1'b0, cout, cout, 1'b0};
RIPPLE_CARRY_ADDER RCA2 (s, w, 1'b0, sum, cout2);

endmodule