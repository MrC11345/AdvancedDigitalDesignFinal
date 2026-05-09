// ECE 6370 - ADD
// Mason Sexton - 5780
// CountTo100
// This module takes several inputs and drives an output high after 100 inputs
module CountTo100(enable,advanceCount100,count100Done,clk,rst);
    input enable, advanceCount100, clk, rst;
    output count100Done;
    reg count100Done;
    reg [6:0] counter100;
    initial begin
	counter100 = 7'b0000000;
    end

    always @(posedge clk) begin
	if(rst == 1'b0) begin
	    count100Done <= 1'b0;
	    counter100 <= 7'b0000000;
	    end
	else if(counter100 >= 7'b1100100) begin
	    count100Done <= 1'b1;
	    counter100 <= 7'b0000000;
	    end
	else if((enable == 1'b1)&(advanceCount100 == 1'b1)) begin
	    count100Done <= 1'b0;
	    counter100 <= counter100 + 7'b0000001;
	    end
	else if(enable == 1'b1) begin
	    count100Done <= 1'b0;
	    counter100 <= counter100;
	    end
	else begin
	    count100Done <= 1'b0;
	    counter100 <= 7'b0000000;
	    end
    end
endmodule