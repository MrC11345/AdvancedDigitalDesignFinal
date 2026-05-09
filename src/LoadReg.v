// ECE6370
// Mason Sexton: 5780
// LoadReg
// This module takes a 4 bit input and when the load button is pressed outputs that same 
// 4 bit number until the load button is pressed again or rst is pushed
module LoadReg(LRIn,LROut,Load,clk,rst);
	input [3:0] LRIn;
	output [3:0] LROut;
	input clk,rst,Load;
	reg [3:0] LROut;

	always @(posedge clk)
		begin
		if( rst == 1'b0)
			begin
			LROut <= 4'b0000;
			end
		else
		//normal opperation after reset
			begin
			if (Load == 1'b1)
				begin	
				LROut <= LRIn;
				end
			end
		end
				
endmodule