`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 14:24:36
// Design Name: 
// Module Name: block_memory_generator_tb
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


module block_memory_generator_tb();

reg clk_tb,arstn_tb,wrenb_tb;
reg [2:0]write_address_tb;
reg [2:0]read_address_tb;
reg [7:0]data_in_tb;

wire [7:0]data_out_tb;

block_memory_generator dut(clk_tb,arstn_tb,wrenb_tb,write_address_tb,read_address_tb,data_in_tb,data_out_tb);

initial
begin
    {clk_tb,arstn_tb,wrenb_tb,write_address_tb,read_address_tb,data_in_tb}=0;
end

always #5 clk_tb=~clk_tb;

initial
begin
        #15;
        arstn_tb = 1;
        
        @(posedge clk_tb);
        wrenb_tb = 1;                   
        write_address_tb = 8'h05;      
        data_in_tb = 8'b10111001;      
        
        @(posedge clk_tb);
        write_address_tb = 8'h0A;      
        data_in_tb = 8'b11110000;      

        @(posedge clk_tb);
        wrenb_tb = 0;                   
        read_address_tb = 8'h05;        

        @(posedge clk_tb);
        #1;
        read_address_tb = 8'h0A;       
        #20;
        $finish;
end


endmodule
