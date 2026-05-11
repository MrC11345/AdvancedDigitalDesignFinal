`timescale 1ns/100ps
module TestBenchGameController();

	//defining simulation variables that GameController expects
	reg logInS, button1S, button2S, button3S, button4S, timerDoneS;
	reg [3:0] playerIDS;
	reg clkS, rstS;
	wire logOutS;
	wire timerEnableS, timerReconfigS;
	wire [3:0] timerLengthS;
	wire [6:0] scoreS;
	wire [5:0] displayBus2S, displayBus3S, displayBus4S, displayBus5S;

	//calling the module
	GameController DUTGameController(playerIDS, logInS, logOutS, button1S, button2S, button3S, button4S, timerEnableS, timerReconfigS, timerLengthS, timerDoneS, scoreS, displayBus2S, displayBus3S, displayBus4S, displayBus5S, clkS, rstS);

	//OneSecond_Timer OneSecond_Timer1(clkS, rstS, timerEnableS, timerDoneS);

	//creating the clock
	always begin
	    clkS = 1'b1;
	    #10;
	    clkS = 1'b0;
	    #10;
	end

	//starting simulation
	initial begin
		//defing inital varibales
		playerIDS = 4'b0000; logInS = 1'b1; button1S = 1'b0; button2S = 1'b0; timerDoneS = 1'b0; button3S = 1'b0; button4S = 1'b0; rstS = 1'b0;
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		//setting level to level 1
		button1S = 1'b1;
		@(posedge clkS);  @(posedge clkS);
		button1S = 1'b0;
		@(posedge clkS);  @(posedge clkS);
		//starting the game
		button4S = 1'b1;
		@(posedge clkS);  @(posedge clkS);
		button4S = 1'b0;
		//waiting for the game to finish
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
		timerDoneS = 1'b1;
		@(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);  @(posedge clkS);
	end
endmodule