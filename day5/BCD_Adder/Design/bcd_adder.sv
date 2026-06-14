`timescale 1ns / 1ps

module bcd_adder(
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


module RIPPLE_CARRY_ADDER(input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout);
wire w1,w2,w3;

fulladder FA1(a[0],b[0],cin,sum[0],w1);
fulladder FA2(a[1],b[1],w1,sum[1],w2);
fulladder FA3(a[2],b[2],w2,sum[2],w3);
fulladder FA4(a[3],b[3],w3,sum[3],cout);


endmodule

module fulladder(input a,b,cin,output sum,carry);
wire w1,w2,w3;
xor(w1,a,b);
xor(sum,w1,cin);
and(w2,a,b);
and(w3,w1,cin);
or(carry,w3,w2);
endmodule

