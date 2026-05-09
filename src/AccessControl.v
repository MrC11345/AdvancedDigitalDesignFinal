// ECE 6370 - ADD
// Mason Sexton - 5780
// AccessControl
// This module manages differnt users access to the program by creating a login and logout functions
module AccessControl(Password,Load,Login,Logout,LoadP1RegIn,RNGGenIn,LoadP1RegOut,RNGGenOut,timerDone,timerEnable,timerReconfig,clk,rst);
	input [3:0] Password;
	input Load, clk, rst;
	input LoadP1RegIn, RNGGenIn, timerDone;
	output LoadP1RegOut, RNGGenOut, timerEnable,timerReconfig;
	output Login, Logout;
	reg Login, Logout, authenticated1;
	wire authenticated, LoadP1RegOut, RNGGenOut, timerEnable, timerReconfig;

	Authentication Authentication1(Password, Load, authenticated, clk,rst);
	GameController GameController1(Load, authenticated, LoadP1RegIn, RNGGenIn, LoadP1RegOut, 
	RNGGenOut,timerDone,timerEnable,timerReconfig,clk,rst);

	always @(posedge clk) begin
		authenticated1 <= authenticated;
		if(authenticated1==1'b1) begin
			Login <= 1'b1;
			Logout <= 1'b0;
		end
		else begin
			Login <= 1'b0;
			Logout <= 1'b1;
		end
		if (rst == 1'b0) begin
			authenticated1 <= 1'b0;
			Login <= 1'b0;
			Logout <= 1'b1;
		end
	end
endmodule