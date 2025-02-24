`timescale 1ns / 1ps

module tb_count_decode;

  // Testbench signals
  reg         clk;
  reg         reset;
   wire [7:0] count_out;
   wire	      ready;
   wire	      run;
   wire	      brake;
   wire	      stop;
   reg	      test_fail;
   
  // ========================================
  // Instantiate the DUT (Device Under Test)
  // ========================================
  // 

  top dut (
    .clk      (clk),
    .reset    (reset),
    .count  (count_out),
    .ready (ready),
    .run (run),
    .brake (brake),
    .stop (stop)	   
  );

  // Clock generation: 10ns period => 100MHz
  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  // Apply reset and then release it
  initial begin
    reset = 1;
    #20;          // Hold reset for 20ns
    reset = 0;
  end

  // ========================================
  // Monitor and Check Decoder Output
  // ========================================
  //

  // Helper function to compute expected decoder output for a 3-bit value
  function [3:0] decode_output;
    input [7:0] in3;
    begin
       decode_output = { (in3 >= 0) && (in3 <= 25), 
			 ( (in3 >= 25) && (in3 <= 100) ) || ( (in3 >= 125) && (in3 <= 200) ) ,
			 ( (in3 >= 100) && (in3 <= 125) ) || ( (in3 >= 200) && (in3 <= 210) ),
			 ( (in3 >= 0) && (in3 <= 10) ) || ( (in3 >= 210) && (in3 <= 225) ) };
    end
  endfunction

   reg [8:0] cycle_count;
  reg [3:0] expected_value;

  // We'll run for a certain number of clock cycles and compare
  initial begin
     test_fail = 0;
    // Wait until reset is deasserted
    @(negedge reset);

    // Now check outputs for 32 clock cycles (for example)
    for (cycle_count = 0; cycle_count < 256; cycle_count = cycle_count + 1) begin
      // Wait for rising edge of clock
      @ (posedge clk);

      expected_value = decode_output(cycle_count[7:0]); 

      // Compare
      if ({ready, run, brake, stop} === expected_value) begin
        $display("Time %0dns, Cycle %0d -> PASS: ready=%b run=%b brake=%b stop=%b (expected=%b)", 
                 $time, cycle_count, ready, run, brake, stop, expected_value);
      end else begin
        $display("Time %0dns, Cycle %0d -> FAIL: ready=%b run=%b brake=%b stop=%b (expected=%b)", 
                 $time, cycle_count, ready, run, brake, stop, expected_value);
	 test_fail = 1;
      end
    end

    // After 32 cycles, finish simulation
    $finish_and_return(test_fail);
  end

endmodule
