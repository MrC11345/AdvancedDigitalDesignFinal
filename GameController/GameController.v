// ECE 6370 - ADD
// GameController
// This module manages differnt game states to run the game itself
module GameController(playerID, logIn, logOut, isGuest, button1, button2, button3, button4, moleOrSpikeLocation, moleOrSpike, timerEnable, timerReconfig, timerLength clk, rst);

	input logIn, isGuest, button1, button2, button3, button4;
	input [3:0] playerID;
	input clk, rst;
	output logOut;
	output [3:0] moleOrSpikeLocation;
	output [3:0] moleOrSpike;
	reg [3:0] moleOrSpikeLocation;
	reg [3:0] moleOrSpike;
	output timerEnable, timerReconfig;
	output [3:0] timerLength;
	reg [3:0] timerLength;
	reg timerEnable, timerReconfig, timerLength, startRound, logOut;

	// internal signals
	reg [3:0] Hit; //used to determine what button was pressed or no button

	parameter loggedOut = 0, preGame = 1, gameRun = 2, gameOver = 3;
	reg [2:0] State;

	always @(posedge clk) begin
		case (State)
	            loggedOut : begin
				LoadP1RegOut <= 1'b0;
				RNGGenOut <= 1'b1;
				timerReconfig <= 1'b0;
				timerEnable <= 1'b0;
				if(loggedIn == 1'b1) begin // if authentication is logged in then activate game
					State <= preGame;
					timerReconfig <= 1'b1;
					end
				else 
					State <= loggedOut;
        	    end
			preGame : begin
				LoadP1RegOut <= 1'b0;
				RNGGenOut <= 1'b1;
				timerReconfig <= 1'b0;
				timerEnable <= 1'b0;
				if(gameButton == 1'b1) // if pushing the load button will start the game 
					State <= gameRun;
				else 
					State <= preGame;
			end
			gameRun : begin
				timerEnable <= 1'b1;
				timerReconfig <= 1'b0;
				LoadP1RegOut <= LoadP1RegIn;
				RNGGenOut <= RNGGenIn;
				if (timerDone == 1'b1)
					State <= gameOver; //the next state for stoping the game
				else
					State <= gameRun; //the current state to keep clk from reseting it
			end
			gameOver : begin
				timerEnable <= 1'b0;
				timerReconfig <= 1'b0;
				LoadP1RegOut <= 1'b0;
				RNGGenOut <= 1'b1; //this one is active low so change it
				if (gameButton == 1'b1) begin
					State <= preGame; //the next state for reseting the game
					timerReconfig <= 1'b1;
				end
				else
					State <= gameOver; //the current state to keep clk from reseting it
			end
			default : begin
				LoadP1RegOut <= 1'b0;
				RNGGenOut <= 1'b1;
				timerReconfig <= 1'b0;
				State <= loggedOut;
			end
		endcase
		if (rst == 1'b1) begin
			State <= loggedOut;
		end
		else begin
			if (
		end
	end
endmodule
