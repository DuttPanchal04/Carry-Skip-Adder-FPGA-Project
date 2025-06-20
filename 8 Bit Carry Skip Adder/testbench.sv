// main testbench for top module
module top_tb;

  reg [7:0] a, b;
  reg cin;
  wire [7:0] sum;
  wire cout;

  top dut(

    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)

  );

  initial begin

    $dumpfile("test_carry_skip_adder.vcd");
    $dumpvars(0, top_tb);

    //$monitor("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    a = 8'b0; b = 8'b0; cin = 0;

    // All input bits are zero
    if($test$plusargs("ALL_ZERO")) begin

      a = 8'b0; b = 8'b0; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // All input bits are one
    if($test$plusargs("ALL_ONES")) begin

      a = 8'b11111111; b = 8'b11111111; cin = 1;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // when one operand input is zero
    if($test$plusargs("ONE_OPER_ZERO")) begin

      a = 8'b0; b = 8'b10010100; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // when one operand input is zero + cin is high
    if($test$plusargs("ONE_OPER_ZERO_CIN")) begin

      a = 8'b0; b = 8'b11000101; cin = 1;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // when only cin is high, other inputs are 0
    if($test$plusargs("CIN_ONLY")) begin

      a = 8'b0; b = 8'b0; cin = 1;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // maximum sum without cout
    if($test$plusargs("MAX_SUM")) begin

      a = 8'b11111110; b = 8'b00000001; cin = 1;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // when carry generated in lower bits, skip should enabled
    if($test$plusargs("CIN_LOWER")) begin

      a = 8'b00001111; b = 8'b00000000; cin = 1;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // all propagation bits are high
    if($test$plusargs("ALL_PROP_HIGH")) begin

      a = 8'b11111111; b = 8'b0; cin = 1;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // No propagation bits are enables
    if($test$plusargs("NO_PROP")) begin

      a = 8'b10101010; b = 8'b01010101; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // checking overflow behavioral 
    if($test$plusargs("OVRFLW1")) begin

      a = 8'b00000001; b = 8'b01111111; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    if($test$plusargs("OVRFLW2")) begin

      a = 8'b10000000; b = 8'b10000000; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    if($test$plusargs("OVRFLW3")) begin

      a = 8'b00000001; b = 8'b00000001; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // with random inputs
    if($test$plusargs("RANDOM")) begin

      a = $random; b = $random; cin = $random;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // alternating bits
    if($test$plusargs("ALTER")) begin

      a = 8'b10101010; b = 8'b01010101; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end

    // reversed bit pattern
    if($test$plusargs("REV_BITS")) begin

      a = 8'b00001111; b = 8'b11110000; cin = 0;
      #5;
      $display("time = %t | a = %b | b = %b | cin = %b | w9 = %b | sum = %b | cout = %b", $time, a, b, cin, dut.w9, sum, cout);

    end


  end

endmodule