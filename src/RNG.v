// ECE 6370 - ADD
// Mason Sexton - 5780
// RNG
// This module generates a random number by using a random length of button press by the player
module RNG(gen,num,clk,rst);
    input gen, clk, rst;
    output [3:0] num;
    reg [3:0] num;

    initial begin
	num = 4'b0000;
	end

    always @(posedge clk) begin
	if(rst==1'b0)
	    num <= 4'b0000;
	else if((gen==1'b0)&(num<4'b1111))
	    num <= num + 4'b0001;
	else if((gen==1'b0)&(num>=4'b1111))
	    num <= 4'b0000;
	else
	    num <= num;
    end
endmodule