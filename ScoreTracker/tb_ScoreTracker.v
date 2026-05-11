// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: tb_ScoreTracker
// Describe briefly what this module does: Testbench for ScoreTracker.
// Any comments and log: Standardized file header added on 2026-03-28.

`timescale 1ns/100ps
module tb_ScoreTracker();
	reg [2:0] PlayerID, isGuest;
	reg [6:0] ScoreIn;
	reg ScoreRequest;
	reg clk, rst;

	wire [6:0] PersonalBest;
	wire [2:0] GlobalWinner;
	wire ScoreValid;

	ScoreTracker DUT_ScoreTracker(
		PlayerID,
		isGuest,
		ScoreIn,
		ScoreRequest,
		PersonalBest,
		GlobalWinner,
		ScoreValid,
		clk,
		rst
	);

	always begin
		clk = 1'b1;
		#10;
		clk = 1'b0;
		#10;
	end

	initial begin
		$display("=== ScoreTracker TB Start ===");
		$monitor("T=%0t | rst=%b req=%b player=%0d guest=%0d scoreIn=%0d pBest=%0d winner=%0d valid=%b",
				 $time, rst, ScoreRequest, PlayerID, isGuest, ScoreIn, PersonalBest, GlobalWinner, ScoreValid);

		// Initial conditions + reset sequence (similar style to provided example)
		PlayerID = 3'd0;
		isGuest = 3'd0;
		ScoreIn = 7'd0;
		ScoreRequest = 1'b0;
		rst = 1'b1;

		@(posedge clk);
		rst = 1'b0;
		@(posedge clk);
		rst = 1'b1;
		@(posedge clk);
		rst = 1'b0;

		// Transaction 1: Player 1 submits score 12
		PlayerID = 3'd1;
		isGuest = 3'd0;
		ScoreIn = 7'd12;
		#5 ScoreRequest = 1'b1;
		@(posedge clk);
		#5 ScoreRequest = 1'b0;
		repeat (9) @(posedge clk);

		// Transaction 2: Player 2 submits score 40
		PlayerID = 3'd2;
		isGuest = 3'd1;
		ScoreIn = 7'd40;
		#5 ScoreRequest = 1'b1;
		@(posedge clk);
		#5 ScoreRequest = 1'b0;
		repeat (9) @(posedge clk);

		// Transaction 3: Player 1 submits a higher score
		PlayerID = 3'd1;
		isGuest = 3'd0;
		ScoreIn = 7'd55;
		#5 ScoreRequest = 1'b1;
		@(posedge clk);
		#5 ScoreRequest = 1'b0;
		repeat (9) @(posedge clk);

		// Transaction 4: Player 3 submits score 99
		PlayerID = 3'd3;
		isGuest = 3'd0;
		ScoreIn = 7'd99;
		#5 ScoreRequest = 1'b1;
		@(posedge clk);
		#5 ScoreRequest = 1'b0;
		repeat (9) @(posedge clk);

		@(posedge clk);
		@(posedge clk);

		$display("=== ScoreTracker TB End ===");
		$stop;
	end
endmodule