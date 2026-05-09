// ECE 6370 - ADD
// Mason Sexton - 5780
// GameController
// This module manages differnt game states to run the game itself
module GameController(gameButton, loggedIn,LoadP1RegIn,RNGGenIn,LoadP1RegOut,RNGGenOut,timerDone,timerEnable,timerReconfig,clk,rst);

	input gameButton, loggedIn, clk, rst;
	input LoadP1RegIn, RNGGenIn, timerDone;
	output LoadP1RegOut, RNGGenOut, timerEnable,timerReconfig;
	reg LoadP1RegOut, RNGGenOut, timerReconfig, timerEnable;

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
		if (rst == 1'b0)
			State <= loggedOut;
	end
endmodule
