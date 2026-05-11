module LetterDecoder(DecoderIn, DecoderOut);

	input [4:0] DecoderIn; // enter a number d'0 to d'26 to represent A-Z and space
	output [6:0] DecoderOut; // output a 7-bit code to represent the letter in 7-segment display format
	reg [6:0] DecoderOut;

	always@(DecoderIn)
		begin
			case(DecoderIn)
				5'd0: begin DecoderOut = 7'b0001000; end // A
				5'd1: begin DecoderOut = 7'b1100000; end // B
				5'd2: begin DecoderOut = 7'b0110001; end // C
				5'd3: begin DecoderOut = 7'b1000010; end // D
				5'd4: begin DecoderOut = 7'b0110000; end // E
				5'd5: begin DecoderOut = 7'b0111000; end // F
				5'd6: begin DecoderOut = 7'b0000100; end // G
				5'd7: begin DecoderOut = 7'b1001000; end // H
				5'd8: begin DecoderOut = 7'b1001111; end // I
				5'd9: begin DecoderOut = 7'b1000111; end // J
				5'd10: begin DecoderOut = 7'b1111000; end // K
				5'd11: begin DecoderOut = 7'b1110001; end // L
				5'd12: begin DecoderOut = 7'b0101011; end // M
				5'd13: begin DecoderOut = 7'b0001001; end // N
				5'd14: begin DecoderOut = 7'b1111110; end // O
				5'd15: begin DecoderOut = 7'b0011000; end // P
				5'd16: begin DecoderOut = 7'b0001100; end // Q
				5'd17: begin DecoderOut = 7'b0111001; end // R
				5'd18: begin DecoderOut = 7'b0100100; end // S
				5'd19: begin DecoderOut = 7'b1110000; end // T
				5'd20: begin DecoderOut = 7'b1000001; end // U
				5'd21: begin DecoderOut = 7'b1100011; end // V
				5'd22: begin DecoderOut = 7'b1010101; end // W
				5'd23: begin DecoderOut = 7'b1001110; end // X
				5'd24: begin DecoderOut = 7'b1000100; end // Y
				5'd25: begin DecoderOut = 7'b0010010; end // Z
				5'd26: begin DecoderOut = 7'b1111111; end // space
				default: begin DecoderOut = 7'b1111111; end // space
			endcase
		end

endmodule