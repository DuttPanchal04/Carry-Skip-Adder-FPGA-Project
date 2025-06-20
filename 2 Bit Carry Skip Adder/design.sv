// carry look ahead adder
module cla_block #(parameter WIDTH = 2)(
  input [WIDTH-1:0] A, B,
  input Cin,
  output [WIDTH-1:0] Sum,
  output Cout,
  output P_block   // Propagate block signal
);
  wire [WIDTH-1:0] P, G, C;

  assign P = A ^ B;
  assign G = A & B;

  assign C[0] = Cin;

  genvar i;
  generate
    for (i = 1; i < WIDTH; i = i + 1) begin
      assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
    end
  endgenerate

  assign Sum = P ^ C;
  assign Cout = G[WIDTH-1] | (P[WIDTH-1] & C[WIDTH-1-1]);
  assign P_block = &P;  

endmodule

// carry skip addder
module cska_top #(parameter N = 2, BLOCK_SIZE = 2)(
  input [N-1:0] A, B,
  input Cin,
  output [N-1:0] Sum,
  output Cout
);
  localparam BLOCKS = N / BLOCK_SIZE;

  wire [BLOCKS:0] carry;
  wire [BLOCKS-1:0] propagate;
  assign carry[0] = Cin;

  genvar i;
  
  generate
    
    for (i = 0; i < BLOCKS; i = i + 1) begin : cska_block
      
      wire [BLOCK_SIZE-1:0] sum_temp;
      wire block_carry, block_p;

      cla_block #(.WIDTH(BLOCK_SIZE)) cla_inst (
        
        .A(A[i*BLOCK_SIZE +: BLOCK_SIZE]),
        .B(B[i*BLOCK_SIZE +: BLOCK_SIZE]),
        .Cin(carry[i]),
        .Sum(sum_temp),
        .Cout(block_carry),
        .P_block (block_p)
        
      );

      assign Sum[i*BLOCK_SIZE +: BLOCK_SIZE] = sum_temp;
      assign propagate[i] = block_p;

      assign carry[i+1] = block_p ? carry[i] : block_carry;
      
    end
    
  endgenerate

  assign Cout = carry[BLOCKS];
  
endmodule
