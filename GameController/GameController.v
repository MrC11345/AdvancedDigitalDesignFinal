// ECE 6370 - ADD
// GameController
// This module manages differnt game states to run the game itself
module GameController(playerID, logIn, logOut, isGuest, button1, button2, button3, button4, moleOrSpikeLocation, moleOrSpike, timerEnable, timerReconfig, timerLength, clk, rst);

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
	reg timerEnable, timerReconfig, startRound, logOut;

	// internal signals
	reg [3:0] buttonReg; //used to determine what button was pressed or no button
	reg [3:0] gameLevel; //used to determine what game level should be selected
	reg scoreUp,scoreDown;

	parameter loggedOut = 0, preGame = 1, gameRun = 2, gameOver = 3;
	reg [2:0] State;

	Levels Levels1(gameLevel,buttonReg,rngOut,scoreUp,scoreDown,moleOrSpike,moleOrSpikeLocation,startRound,clk,rst);

	always @(posedge clk) begin
		if(button1==1'b1) begin
			buttonReg <= 3'b001;
			end
		else if(button2==1'b1) begin
			buttonReg <= 3'b010;
			end
		else if(button3==1'b1) begin
			buttonReg <= 3'b011;
			end
		else if(button4==1'b1) begin
			buttonReg <= 3'b100;
			end
		else begin
			buttonReg <= 3'b000;
			end
		case (State)
	            loggedOut : begin
				//RNGGenOut <= 1'b1;//not sure how our rng gen will work yet
				timerReconfig <= 1'b0;
				timerEnable <= 1'b0;
				timerLength <= 3'b000;
				startRound <= 1'b0;
				if(logIn == 1'b1) begin // if authentication is logged in then activate game
					State <= preGame;
					timerReconfig <= 1'b1;
					end
				else 
					State <= loggedOut;
        	    end
			preGame : begin
				//RNGGenOut <= 1'b1;
				timerReconfig <= 1'b0;
				timerEnable <= 1'b0;
				startRound <= 1'b0;
				case(buttonReg)
					3'b001 : begin
						timerLength <= 3'b011;//will set level 1 timer length to 33 seconds
						gameLevel <= 3'b001; //sets game level to 1
					end
					3'b010 : begin
						timerLength <= 3'b010; //set timel length to 22 seconds
						gameLevel <= 3'b010; //sets game level to 2
					end
					3'b100 : begin
						timerLength <= 3'b001;//set timer length to 11 seconds
						gameLevel <= 3'b011; //sets game level to 3
					end
					default : begin
						timerLength <= timerLength;
						gameLevel <= gameLevel;
					end
				endcase
				if(buttonReg == 3'b100) // if pushing the load button will start the game 
					State <= gameRun;
				else 
					State <= preGame;
			end
			gameRun : begin
				timerEnable <= 1'b1;
				timerReconfig <= 1'b0;
				//LoadP1RegOut <= LoadP1RegIn;
				//RNGGenOut <= RNGGenIn;
				startRound <= 1'b1;
				if (timerDone == 1'b1)
					State <= gameOver; //the next state for stoping the game
				else
					State <= gameRun; //the current state to keep clk from reseting it
			end
			gameOver : begin
				timerEnable <= 1'b0;
				timerReconfig <= 1'b0;
				//LoadP1RegOut <= 1'b0;
				//RNGGenOut <= 1'b1; //this one is active low so change it
				startRound <= 1'b0;
				if (buttonReg == 3'b100) begin
					State <= preGame; //the next state for reseting the game
					timerReconfig <= 1'b1;
				end
				else
					State <= gameOver; //the current state to keep clk from reseting it
			end
			default : begin
				//LoadP1RegOut <= 1'b0;
				//RNGGenOut <= 1'b1;
				timerReconfig <= 1'b0;
				startRound <= 1'b0;
				State <= loggedOut;
			end
		endcase
		if (rst == 1'b1) begin
			State <= loggedOut;
		end
	end
endmodule
