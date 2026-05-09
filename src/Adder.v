// ECE6370
// Mason Sexton: 5780
// Adder
// This module takes to number inputs adds them togther and stores the result in output
module Adder(Input1, Input2, Output);
	input [3:0]Input1;
	input [3:0]Input2;
	output [3:0]Output;
	reg [3:0]Output;

	always @(Input1, Input2)
		begin
			Output = Input1 + Input2;
		end
endmodule
