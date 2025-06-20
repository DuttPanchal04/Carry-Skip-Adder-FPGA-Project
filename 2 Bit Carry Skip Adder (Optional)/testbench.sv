module top_tb;

  reg [1:0] a, b;
  reg cin;
  wire [1:0] sum;
  wire cout;

  top dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  initial begin
    
    $dumpfile("test_2bit_carry_skip_adder.vcd");
    $dumpvars(0, top_tb);

    // All input bits are zero
    
    if($test$plusargs("ALL_ZERO")) begin
      a = 2'b00; b = 2'b00; cin = 0;
      #5;
      $display("ALL_ZERO: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // All input bits are one
    if($test$plusargs("ALL_ONES")) begin
      
      a = 2'b11; b = 2'b11; cin = 1;
      #5;
      $display("ALL_ONES: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // One operand zero
    if($test$plusargs("ONE_OPER_ZERO")) begin
      a = 2'b00; b = 2'b10; cin = 0;
      
      #5;
      $display("ONE_OPER_ZERO: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // One operand zero + cin
    if($test$plusargs("ONE_OPER_ZERO_CIN")) begin
      
      a = 2'b00; b = 2'b10; cin = 1;
      #5;
      $display("ONE_OPER_ZERO_CIN: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // Only cin high
    if($test$plusargs("CIN_ONLY")) begin
      
      a = 2'b00; b = 2'b00; cin = 1;
      #5;
      $display("CIN_ONLY: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // Maximum sum without cout
    if($test$plusargs("MAX_SUM")) begin
      
      a = 2'b11; b = 2'b00; cin = 1;
      #5;
      $display("MAX_SUM: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // All propagation bits high (a XOR b = 1 for all bits)
    if($test$plusargs("ALL_PROP_HIGH")) begin
      
      a = 2'b11; b = 2'b00; cin = 1;
      #5;
      $display("ALL_PROP_HIGH: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // No propagation bits enabled
    
    if($test$plusargs("NO_PROP")) begin
      
      a = 2'b10; b = 2'b01; cin = 0;
      #5;
      $display("NO_PROP: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // Random input
    if($test$plusargs("RANDOM")) begin
      
      a = $random; b = $random; cin = $random;
      #5;
      $display("RANDOM: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // Alternating bits
    if($test$plusargs("ALTER")) begin
      
      a = 2'b10; b = 2'b01; cin = 0;
      
      #5;
      $display("ALTER: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

    // Reversed pattern
    
    if($test$plusargs("REV_BITS")) begin
      
      a = 2'b01; b = 2'b10; cin = 0;
      #5;
      $display("REV_BITS: a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
      
    end

  end

endmodule
