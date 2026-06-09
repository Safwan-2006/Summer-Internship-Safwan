`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 16:00:33
// Design Name: 
// Module Name: Universal_SR_tb
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


module Universal_SR_tb();

reg clk_tb;
reg rst_tb;
reg sin_tb;
reg [3:0]pin_tb;
reg shift_tb;
reg load_tb;
reg [1:0]mod_tb;
wire sout_tb;
wire [3:0]pout_tb;

Universal_SR dut(clk_tb,rst_tb,sin_tb,pin_tb,shift_tb,load_tb,mod_tb,sout_tb,pout_tb);

initial begin
    {clk_tb,rst_tb,sin_tb,pin_tb,shift_tb,load_tb,mod_tb}=0;
    end
    

always #5 clk_tb=~clk_tb;

initial begin
    rst_tb = 1;
    #15 rst_tb = 0;
    
    load_tb = 1;
    mod_tb = 2'b00;
    shift_tb = 1;
    
    sin_tb = 1; #10;
    sin_tb = 0; #10;
    sin_tb = 1; #10;
    sin_tb = 1; #10;
    
    mod_tb = 2'b01;
    sin_tb = 0; #10;
    sin_tb = 1; #10;
    sin_tb = 0; #10;
    sin_tb = 1; #10;
    
    mod_tb = 2'b10;
    shift_tb = 0;
    pin_tb = 4'b1010; #10;
    shift_tb = 1;
    #40;
    
    // --- MODE 3: PIPO DEMONSTRATION ---
    mod_tb = 2'b11;
    shift_tb = 0;          // Required by your main code to unlock 'pin'
    
    pin_tb = 4'b1100; #10; // pout becomes 'c'
    pin_tb = 4'b0110; #10; // pout becomes '6'
    pin_tb = 4'b1001; #10; // pout becomes '9'
    pin_tb = 4'b1111; #10; // pout becomes 'f'
    // ----------------------------------
    
    load_tb = 0;
    #20;
    
    load_tb = 1;
    mod_tb = 2'b00;
    shift_tb = 0;
    sin_tb = 1; 
    #20;
end
    
endmodule
