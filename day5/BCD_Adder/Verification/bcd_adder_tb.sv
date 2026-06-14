`timescale 1ns / 1ps

interface bcd_adder_if;
  logic [3:0] a;
  logic [3:0] b;
  logic c;
  logic [3:0] sum;
  logic cout;
endinterface

module bcd_adder_tb();

  bcd_adder_if vif();

  bcd_adder dut (
    vif.a, 
    vif.b, 
    vif.c, 
    vif.sum, 
    vif.cout
  );

  initial begin
    {vif.a, vif.b, vif.c} = 0;
  end

  initial begin
    vif.a = 4'b0000; vif.b = 4'b0000; vif.c = 1'b0; 
    #50;   
    vif.a = 4'b0010; vif.b = 4'b0011; vif.c = 1'b0; 
    #50;
    vif.a = 4'b0101; vif.b = 4'b0100; vif.c = 1'b0; 
    #50;
    vif.a = 4'b0110; vif.b = 4'b0111; vif.c = 1'b0; 
    #50;
    vif.a = 4'b1000; vif.b = 4'b1000; vif.c = 1'b0; 
    #50; 
    $finish;
  end

endmodule
