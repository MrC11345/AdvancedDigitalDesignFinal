// ECE 6370 - ADD
// Mason Sexton - 5780
// ButtonShaper
// This module prevents multiple different signals from a button and "debounces" it
module ButtonShaper(ButtonIn,ButtonOut,clk,rst);
	input ButtonIn, clk, rst;
	output ButtonOut;
	reg ButtonOut;

	parameter Init = 0, Pulse = 1, Wait = 2;
	reg [2:0] State, StateNext;

	always @(State,ButtonIn) begin
		case (State)

			Init : begin
				ButtonOut = 1'b0;
				if (ButtonIn == 1'b0)
					StateNext = Pulse;
				else
					StateNext = Init;
			end
			Pulse : begin
				ButtonOut = 1'b1;
				StateNext = Wait;
			end
			Wait : begin
				ButtonOut = 1'b0;
				if (ButtonIn == 1'b1)
					StateNext = Init;
				else
					StateNext = Wait;
			end
			default : begin
				ButtonOut = 1'b0;
				StateNext = Init;
			end
		endcase
	end


	always @(posedge clk) begin
		if (rst == 1'b0)
			State <= Init;
		else
			State <= StateNext;
		end
endmodule