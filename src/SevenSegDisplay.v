// ECE6370 
// Mason Sexton: 5780
// SevenSegDisplay
// This module takes a 4 bit input and creates a 7 bit output to go to a seven segment display
module SevenSegDisplay(FourIN,SevenOUT);
	input [3:0]FourIN;
	output [6:0]SevenOUT;
	reg [6:0]SevenOUT;
	
	always @(FourIN)
		begin
			case(FourIN)
				4'b0000: begin SevenOUT = 7'b000_0001; end
				4'b0001: begin SevenOUT = 7'b100_1111; end
				4'b0010: begin SevenOUT = 7'b001_0010; end
				4'b0011: begin SevenOUT = 7'b000_0110; end
				4'b0100: begin SevenOUT = 7'b100_1100; end
				4'b0101: begin SevenOUT = 7'b010_0100; end
				4'b0110: begin SevenOUT = 7'b010_0000; end
				4'b0111: begin SevenOUT = 7'b000_1111; end
				4'b1000: begin SevenOUT = 7'b000_0000; end
				4'b1001: begin SevenOUT = 7'b000_0100; end
				4'b1010: begin SevenOUT = 7'b000_1000; end
				4'b1011: begin SevenOUT = 7'b110_0000; end
				4'b1100: begin SevenOUT = 7'b011_0001; end
				4'b1101: begin SevenOUT = 7'b100_0010; end
				4'b1110: begin SevenOUT = 7'b011_0000; end
				4'b1111: begin SevenOUT = 7'b011_1000; end
				default: begin SevenOUT = 7'b000_0000; end
			endcase
		end
endmodule