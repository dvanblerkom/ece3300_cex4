//
//

module counter_8bit (
    input  clk,
    input  reset,
    output reg [7:0] count
);

  // On each clock's rising edge:
  //   - If reset is active, set count to 0.
  //   - Otherwise, increment the counter.
  always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 8'd0;
    else
      count <= count + 1;
  end

endmodule
