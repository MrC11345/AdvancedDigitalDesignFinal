// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: Decoder7Seg
// Describe briefly what this module does: Maps a 4-bit hexadecimal input to the
// corresponding 7-segment display output pattern.
// Any comments and log: Standardized file header added on 2026-03-28.

module NumberDecoder(DecoderIn, DecoderOut);

	input [3:0] DecoderIn;
	output [6:0] DecoderOut;
	reg [6:0] DecoderOut;

	always@(DecoderIn)
		begin
			case(DecoderIn)
				4'b0000: begin DecoderOut = 7'b0000001; end
				4'b0001: begin DecoderOut = 7'b1001111; end
				4'b0010: begin DecoderOut = 7'b0010010; end
				4'b0011: begin DecoderOut = 7'b0000110; end
				4'b0100: begin DecoderOut = 7'b1001100; end
				4'b0101: begin DecoderOut = 7'b0100100; end
				4'b0110: begin DecoderOut = 7'b0100000; end
				4'b0111: begin DecoderOut = 7'b0001111; end
				4'b1000: begin DecoderOut = 7'b0000000; end
				4'b1001: begin DecoderOut = 7'b0000100; end
				4'b1010: begin DecoderOut = 7'b0001000; end
				4'b1011: begin DecoderOut = 7'b1100000; end
				4'b1100: begin DecoderOut = 7'b0110001; end
				4'b1101: begin DecoderOut = 7'b1000010; end
				4'b1110: begin DecoderOut = 7'b0110000; end
				4'b1111: begin DecoderOut = 7'b0111000; end
				default: begin DecoderOut = 7'b1111110; end
			endcase
 		end
endmodule