`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 15:32:13
// Design Name: 
// Module Name: Universal_SR
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
module Universal_SR(
    input clk,
    input rst,
    input sin,
    input [3:0] pin,
    input shift,
    input load,
    input [1:0] mod,
    output reg sout,
    output reg [3:0] pout
);

    reg [3:0] temp;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            temp <= 4'b0000;
        end 
        else begin
            case(mod)
                2'b00, 2'b01: begin 
                    if (shift) begin
                        temp <= {sin, temp[3:1]}; 
                    end
                end
                
                2'b10, 2'b11: begin 
                    if (!shift) begin
                        temp <= pin; 
                    end
                end
                
                default: temp <= temp;
            endcase
        end
    end

    always @(*) begin
        sout = 1'b0;
        pout = 4'b0000;

        if (load) begin
            case (mod)
                2'b00: begin 
                    sout = temp[0]; 
                    pout = 4'b0000;      
                end
                2'b01: begin 
                    sout = 1'b0;       
                    pout = temp;    
                end
                2'b10: begin 
                    sout = temp[0]; 
                    pout = 4'b0000;     
                end
                2'b11: begin 
                    sout = 1'b0;       
                    pout = temp;    
                end
                default: begin 
                    sout = 1'b0; 
                    pout = 4'b0000; 
                end
            endcase
        end
    end 
endmodule
