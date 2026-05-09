// ECE 6370 - ADD
// Mason Sexton - 5780 
// CountTo10
// This module takes several inputs and drives an output high after 100 inputs
module CountTo10(enable,advanceCount10,count10Done,clk,rst);
    input enable, advanceCount10, clk, rst;
    output count10Done;
    reg count10Done;
    reg [3:0] counter10;
    initial begin
	counter10 = 4'b0000;
    end

    always @(posedge clk) begin
	if(rst == 1'b0) begin
	    count10Done <= 1'b0;
	    counter10 <= 4'b0000;
	    end
	else if(counter10 >= 4'b1010) begin
	    count10Done <= 1'b1;
	    counter10 <= 4'b0000;
	    end
	else if((enable == 1'b1)&(advanceCount10 == 1'b1)) begin
	    count10Done <= 1'b0;
	    counter10 <= counter10 + 4'b0001;
	    end
	else if(enable == 1'b1) begin
	    count10Done <= 1'b0;
	    counter10 <= counter10;
	    end
	else begin
	    count10Done <= 1'b0;
	    counter10 <= 4'b0000;
	    end
    end
endmodule