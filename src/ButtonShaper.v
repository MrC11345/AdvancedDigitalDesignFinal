// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: ButtonShaper
// Describe briefly what this module does: Debounces/shapes a button input into
// a single-cycle pulse for clean state-machine triggering.
// Any comments and log: Standardized file header added on 2026-03-28.

module ButtonShaper(ButtonIn, ButtonOut, clk, rst);
	input ButtonIn;
	output ButtonOut;
	input clk, rst;
	reg ButtonOut;
	parameter INIT = 0, PULSE = 1, WAIT = 2;
	reg [2:0] State, StateNext;

	// Combination Logic
	always @ (State, ButtonIn) begin
		case (State)
			INIT:
				begin
					ButtonOut = 1'b0;
					if (ButtonIn == 1'b0)
						StateNext = PULSE;
					else
						StateNext = INIT;
				end
			PULSE:
				begin
					ButtonOut = 1'b1;
					StateNext = WAIT;
				end
			WAIT:
				begin
					ButtonOut = 1'b0;
					if (ButtonIn == 1'b1)
					 	StateNext = INIT;
					else
						StateNext = WAIT;
				end
			default:
				begin
					ButtonOut = 1'b0;
					StateNext = INIT;
				end
		endcase
	end

	// State reg - non-blocking assignment
	always @ (posedge clk) begin
		if (rst == 1'b0)
			State <= INIT;
		else
			State <= StateNext;
	end
endmodule
