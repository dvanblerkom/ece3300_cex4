

module top (
	    input	 clk,
	    input	 reset,
	    output [7:0] count,
	    output	 ready, 
	    output	 run,
	    output	 brake,
	    output	 stop
	    );

   counter_8bit u1 (/*AUTOINST*/
		    // Outputs
		    .count		(count[7:0]),
		    // Inputs
		    .clk		(clk),
		    .reset		(reset));

   count_decode u2 (/*AUTOINST*/
		    // Outputs
		    .ready		(ready),
		    .run		(run),
		    .brake		(brake),
		    .stop		(stop),
		    // Inputs
		    .count		(count[7:0]));

endmodule
