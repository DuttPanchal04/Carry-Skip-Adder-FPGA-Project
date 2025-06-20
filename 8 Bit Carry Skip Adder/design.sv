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

  assign sum = (a^b)^cin;
  assign cout = ( (a&b) | (b&cin) | (cin&a) );
  assign p = a^b;

endmodule


// Block-1 Module
module block1(

  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] sum,
  output cout

);

  wire w1, w2, w3, w4;
  wire p0, p1, p2, p3;
  wire p_b1;

  fa m1( .a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(w1), .p(p0) );
  fa m2( .a(a[1]), .b(b[1]), .cin(w1), .sum(sum[1]), .cout(w2), .p(p1) );
  fa m3( .a(a[2]), .b(b[2]), .cin(w2), .sum(sum[2]), .cout(w3), .p(p2) );
  fa m4( .a(a[3]), .b(b[3]), .cin(w3), .sum(sum[3]), .cout(w4), .p(p3) );

  and(p_b1, p0, p1, p2, p3);

  mux2x1 m5( .s0(w4), .s1(cin), .sel(p_b1), .y(cout) );

endmodule



// Block-2 Module
module block2(

  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] sum,
  output cout

);

  wire w5, w6, w7, w8;
  wire p4, p5, p6, p7;
  wire p_b2;

  fa m6( .a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(w5), .p(p4) );
  fa m7( .a(a[1]), .b(b[1]), .cin(w5), .sum(sum[1]), .cout(w6), .p(p5) );
  fa m8( .a(a[2]), .b(b[2]), .cin(w6), .sum(sum[2]), .cout(w7), .p(p6) );
  fa m9( .a(a[3]), .b(b[3]), .cin(w7), .sum(sum[3]), .cout(w8), .p(p7) );

  and(p_b2, p4, p5, p6, p7);

  mux2x1 m10( .s0(w8), .s1(cin), .sel(p_b2), .y(cout) );

endmodule

// Top module
module top(

  input [7:0] a, 
  input [7:0] b,
  input cin,
  output [7:0] sum,
  output cout

);

  wire w9;

  block1 b1( .a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(w9) );
  block2 b2( .a(a[7:4]), .b(b[7:4]), .cin(w9), .sum(sum[7:4]), .cout(cout) );

endmodule