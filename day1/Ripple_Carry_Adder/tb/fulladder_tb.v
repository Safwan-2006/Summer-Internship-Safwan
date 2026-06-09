`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 14:42:49
// Design Name: 
// Module Name: fulladder_tb
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


module fulladder_tb();
reg a_tb,b_tb,c_tb;
wire sum_tb,cout_tb;

fulladder_behav dut(a_tb,b_tb,c_tb,sum_tb,cout_tb); //instansiation

initial
begin
{a_tb,b_tb,c_tb}=0;
end
initial
begin
a_tb=1'b0;
b_tb=1'b0;
c_tb=1'b0;
 
#1;

a_tb=1'b0;
b_tb=1'b0;
c_tb=1'b1;

#1;
a_tb=1'b0;
b_tb=1'b1;
c_tb=1'b0;

#1;
a_tb=1'b0;
b_tb=1'b1;
c_tb=1'b1;

#1;
a_tb=1'b1;
b_tb=1'b0;
c_tb=1'b0;

#1;
a_tb=1'b1;
b_tb=1'b0;
c_tb=1'b1;

#1;
a_tb=1'b1;
b_tb=1'b1;
c_tb=1'b0;

#1;
a_tb=1'b1;
b_tb=1'b1;
c_tb=1'b1;
$monitor("The value of a_tb is %b The value of b_tb is %b The value of c_tb is %b The value of sum_tb is %b The value of cout_tb is %b ",a_tb,b_tb,c_tb,sum_tb,cout_tb);

end

endmodule
