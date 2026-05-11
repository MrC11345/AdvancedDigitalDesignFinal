// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: digitTimer
// Describe briefly what this module does: Implements one decimal countdown digit
// with borrow signaling and reconfiguration support.
// Any comments and log: Standardized file header added on 2026-03-28.

module digitTimer(BorrowUp, BorrowDown, NoBorrowUp, NoBorrowDown, Num, ReConfig, clk, rst);
	input BorrowDown, NoBorrowUp, ReConfig, clk, rst;
	output BorrowUp, NoBorrowDown;
	output [3:0] Num;
	reg [3:0] Num;
	reg BorrowUp, NoBorrowDown;

	always @(posedge clk) begin
		if (rst == 1'b0) begin
			Num <= 4'd0;
			BorrowUp <= 1'b0;
			NoBorrowDown <= 1'b0;
		end else begin
			BorrowUp <= 1'b0;
			NoBorrowDown <= 1'b0;
			if (ReConfig == 1'b1) begin
				Num <= 4'd9;
			end else if (BorrowDown == 1'b1) begin
				if (Num != 4'd0) begin
					Num <= Num - 1'b1;
				end else begin
					if (NoBorrowUp == 1'b0) begin
						Num <= 4'd9;
						BorrowUp <= 1'b1;
					end else begin
						Num <= 4'b0;
						NoBorrowDown <= 1'b1;
					end
				end		
			end
		end
	end

endmodule