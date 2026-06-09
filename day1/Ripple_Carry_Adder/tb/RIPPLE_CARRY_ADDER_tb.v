`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 15:55:08
// Design Name: 
// Module Name: RIPPLE_CARRY_ADDER_tb
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


module RIPPLE_CARRY_ADDER_tb();
    reg [3:0] a_tb;
    reg [3:0] b_tb;
    reg cin_tb;
    wire [3:0]sum_tb;
    wire cout_tb;

RIPPLE_CARRY_ADDER dut(a_tb, b_tb, cin_tb, sum_tb, cout_tb);

initial 
begin
{ a_tb, b_tb, cin_tb }=0;
end
initial
begin
        a_tb = 4'b0000; b_tb = 4'b0000; cin_tb = 1'b0;
        #100;

        a_tb = 4'b0010; b_tb = 4'b0011; cin_tb = 1'b0;
        #100;

        a_tb = 4'b0101; b_tb = 4'b0101; cin_tb = 1'b1;
        #100;

        a_tb = 4'b1000; b_tb = 4'b1000; cin_tb = 1'b0;
        #100;

        a_tb = 4'b1111; b_tb = 4'b1111; cin_tb = 1'b1;
        #100;
        
        $monitor("The value of a_tb is %b The value of b_tb is %b The value of cin_tb is %b The value of sum_tb is %b The value of cout_tb is %b ",a_tb,b_tb,cin_tb,sum_tb,cout_tb);
        
end

endmodule
