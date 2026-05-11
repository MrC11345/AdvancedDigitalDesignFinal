// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: LoadRegister
// Describe briefly what this module does: Loads and stores a 4-bit input value
// into a register when the load signal is asserted.
// Any comments and log: Standardized file header added on 2026-03-28.

module LoadRegister(NumberIn, NumberOut, clk, rst, Load);
	input [3:0] NumberIn;
	output [3:0] NumberOut;
	input clk, rst;
	input Load;
	reg [3:0] NumberOut;

	always @ (posedge clk)
		begin
			if (rst == 1'b0)
				begin
					NumberOut <= 4'b0000;
				end
			else
				begin
					if (Load == 1'b1)
						begin
							NumberOut <= NumberIn;
						end
				end
	end
endmodule