// 2x1 Multiplexer Module
module mux2x1(
  
  input s0, s1,
  input sel,
  output y
  
);
  
  assign y = (sel) ? s1 : s0;
  
endmodule

// Full Adder Module
module fa(
  
  input a,
  input b,
  input cin,
  output sum,
  output cout,
  output p
  
);
  assign sum = (a ^ b) ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
  assign p = a ^ b;
  
endmodule

// Block Module for 2-bit Carry Skip
module block1(
  
  input [1:0] a,
  input [1:0] b,
  input cin,
  output [1:0] sum,
  output cout
  
);
  
  wire w1, w2;
  wire p0, p1;
  wire p_block;

  fa fa0(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(w1), .p(p0));
  
  fa fa1(.a(a[1]), .b(b[1]), .cin(w1),  .sum(sum[1]), .cout(w2), .p(p1));

  and(p_block, p0, p1);
  
  mux2x1 mux(.s0(w2), .s1(cin), .sel(p_block), .y(cout));
  
endmodule

// Top module
module top(
  
  input [1:0] a,
  input [1:0] b,
  input cin,
  output [1:0] sum,
  output cout
  
);
  
  block1 u1(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
  
endmodule
