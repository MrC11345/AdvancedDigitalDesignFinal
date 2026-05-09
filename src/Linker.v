// ECE6370
// Mason Sexton: 5780
// Linker
// This is the top level module that links all other modules and pins together
module Linker(p1Switches,passwordSwitches,p1LoadRaw,computerLoadRaw,passwordLoadRaw,p1Display,computerDisplay,sumDisplay,matchingLED,nonMatchingLED,loginLED,logoutLED,timerNum1,timerNum2,timerDisplay1,timerDisplay2,sumNumber,clk,rst);

	//the clk input signal and rst signal
	input clk, rst;
	//the load buttons for each player and password
	input p1LoadRaw, computerLoadRaw, passwordLoadRaw;
	//raw input switches
	input [3:0] p1Switches;
	input [3:0] passwordSwitches;
	//the 7 seg display outputs
	output [6:0] p1Display;
	output [6:0] computerDisplay;
	output [6:0] sumDisplay;
	output [3:0] timerNum1;
	output [3:0] timerNum2;
	output [6:0] timerDisplay1;
	output [6:0] timerDisplay2;

	//the led outputs
	output matchingLED, nonMatchingLED, loginLED, logoutLED;
	//the number from the load register
	wire [3:0] p1RegNum;
	wire [3:0] computerNum;
	//the sum of both numbers together
	output [3:0] sumNumber;
	//the shaped load buttons for each player and password load
	wire p1LoadShaped, passwordLoadShaped;
	//the access controlled buttons
	wire p1LoadControlled, computerLoadControlled;
	wire BorrowUP1, BorrowUP2, oneSecTimerDone, NoBorrowDN2, timerDone, timerReconfig, timerEnable;
	
	//from lab 2
	//proccess buttons to make them not bounce
	ButtonShaper ButtonShaperP1Load(p1LoadRaw,p1LoadShaped,clk,rst);
	ButtonShaper ButtonShaperPasswordLoad(passwordLoadRaw,passwordLoadShaped,clk,rst);
	//prevents unathorized access
	AccessControl AccessControl1(passwordSwitches,passwordLoadShaped,loginLED,logoutLED,p1LoadShaped,computerLoadRaw,p1LoadControlled,computerLoadControlled,timerDone,timerEnable,timerReconfig,clk,rst);
	//loads the switches into the registers
	LoadReg LoadReg1(p1Switches,p1RegNum,p1LoadControlled,clk,rst);
	
	//lab 3 stuff
	//setting the rng and timer to work
	RNG RNG1(computerLoadControlled,computerNum,clk,rst);
	OneSecTimer OneSecTimer1(timerEnable,oneSecTimerDone,clk,rst);
	//this digit is working as intended
	DigitTimer DigitTimer1(BorrowUP1,oneSecTimerDone,NoBorrowDN2,timerDone,timerNum1,timerReconfig,clk,rst);
	//this digit is seaming to have issues going from 9 strait to 0 for some reason
	DigitTimer DigitTimer2(BorrowUP2,BorrowUP1,1'b1,NoBorrowDN2,timerNum2,timerReconfig,clk,rst);

	//from lab 1
	//the displays for each player and sum plus the adder and checker
	SevenSegDisplay SevenSegDisplay1(p1RegNum,p1Display);
	SevenSegDisplay SevenSegDisplay2(computerNum,computerDisplay);
	SevenSegDisplay SevenSegDisplay3(timerNum1,timerDisplay1);
	SevenSegDisplay SevenSegDisplay4(timerNum2,timerDisplay2);
	Adder Adder1(p1RegNum,computerNum,sumNumber);
	SevenSegDisplay SevenSegDisplay5(sumNumber,sumDisplay);
	checker checker1(sumNumber,matchingLED,nonMatchingLED);

endmodule
