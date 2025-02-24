//
// Complete this module to decode the 8-bit input count as follows:
//
//   ready should go high when 0 <= count <= 25
//
//   run should go high when 25 <= count <= 100, and also when 125 <= count <= 200
//
//   brake should go high when 100 <= count <= 125, and also when 200 <= count <= 210
//
//   stop should go high when 0 <= count <= 10, and also when 210 <= count <= 225

module count_decode (
    input [7:0]	count,
    output	ready, 
    output	run,
    output	brake,
    output	stop
);

endmodule
