`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:59:57
// Design Name: 
// Module Name: fulladder
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


module fulladder(input a,b,cin,output sum,carry);
wire w1,w2,w3;
xor(w1,a,b);
xor(sum,w1,cin);
and(w2,a,b);
and(w3,w1,cin);
or(carry,w3,w2);
endmodule
