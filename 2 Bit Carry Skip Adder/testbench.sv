`timescale 1ns / 1ps

module tb_cska;

  parameter N = 2;
  parameter BLOCK_SIZE = 2;

  reg [N-1:0] A, B;
  reg Cin;
  wire[N-1:0] Sum;
  wire Cout;

  cska_top #(.N(N), .BLOCK_SIZE(BLOCK_SIZE)) dut (
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .Sum(Sum), 
    .Cout(Cout)
  );

  initial begin
    
    $dumpfile("cska_2bit.vcd");
    $dumpvars(0, tb_cska);
    
  end

  task show_result;
    
    begin
      
      $display("Time = %0t | A = %b | B = %b | Cin = %b => Sum = %b | Cout = %b",$time, A, B, Cin, Sum, Cout);
      
    end
    
  endtask

  initial begin

    // All zeros
    if ($test$plusargs("ALL_ZERO")) begin
      A = 2'b00; B = 2'b00; Cin = 0;
      #10; 
      show_result();
    end

    // All ones
    if ($test$plusargs("ALL_ONES")) begin
      A = 2'b11; B = 2'b11; Cin = 1;
      #10; 
      show_result();
    end

    // One operand zero
    if ($test$plusargs("ONE_OPER_ZERO")) begin
      A = 2'b00; B = 2'b10; Cin = 0;
      #10; 
      show_result();
    end

    // One operand zero with Cin = 1
    if ($test$plusargs("ONE_OPER_ZERO_CIN")) begin
      A = 2'b00; B = 2'b01; Cin = 1;
      #10; 
      show_result();
    end

    // Only Cin high
    if ($test$plusargs("CIN_ONLY")) begin
      A = 2'b00; B = 2'b00; Cin = 1;
      #10; 
      show_result();
    end

    // Max sum with carry out
    if ($test$plusargs("MAX_SUM")) begin
      A = 2'b11; B = 2'b00; Cin = 1;
      #10; 
      show_result();
    end

    // Carry skip behavior
    if ($test$plusargs("SKIP_CASE")) begin
      A = 2'b11; B = 2'b00; Cin = 1;
      #10; 
      show_result();
    end

    // No propagation
    if ($test$plusargs("NO_PROP")) begin
      A = 2'b10; B = 2'b01; Cin = 0;
      #10; 
      show_result();
    end

    // Overflow-like behavior
    if ($test$plusargs("OVRFLW")) begin
      A = 2'b10; B = 2'b10; Cin = 1;
      #10; 
      show_result();
    end

    // Random test (repeat 5 times)
    if ($test$plusargs("RANDOM")) begin
      repeat (5) begin
        A = $random; B = $random; Cin = $random;
        #10; 
        show_result();
      end
    end

    $finish;
    
  end

endmodule
