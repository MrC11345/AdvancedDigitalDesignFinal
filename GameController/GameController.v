// ECE 6370 - ADD
// GameController
// This module manages differnt game states to run the game itself
module GameController(PlayerID, LogIn, LogOut, isGuest, Button0, Button1, Button2, Button3, Start_Round, Mol_Spi, Timer_Enable, Timer_Reconfig, clk, rst);

	input LogIn, Button0, Button1, Button2, Button3;
    input [2:0] PlayerID, isGuest;
    input [3:0] Mol_Spi; // bus to indicate whether moles or spike
    output Timer_Enable, Timer_Reconfig, Start_Round, LogOut;
    reg Timer_Enable, Timer_Reconfig, Start_Round, LogOut;

    // internal signals
    reg [3:0] Hit; // bus to indicate which button was hit

    // Z: UPDATE FROM HERE ON OUT...
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
// ECE 6370 - ADD
// GameController
// This module manages differnt game states to run the game itself
module GameController(PlayerID, LogIn, LogOut, isGuest, Button0, Button1, Button2, Button3, Start_Round, Mol_Spi, Timer_Enable, Timer_Reconfig, clk, rst);

	input LogIn, Button0, Button1, Button2, Button3;
    input [2:0] PlayerID, isGuest;
    input [3:0] Mol_Spi; // bus to indicate whether moles or spike
    output Timer_Enable, Timer_Reconfig, Start_Round, LogOut;
    reg Timer_Enable, Timer_Reconfig, Start_Round, LogOut;

    // internal signals
    reg [3:0] Hit; // bus to indicate which button was hit

    // Z: UPDATE FROM HERE ON OUT...
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
