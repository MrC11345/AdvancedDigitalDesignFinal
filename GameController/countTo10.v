// ECE 6370
// Author: Alex Samano, 8729 
// Count to 10
// Counts to 10 and then sends out a pulse (every 100 ms)
module countTo10 (clk, rst, Enable, OneSecTimeOut);
    input clk, rst, Enable;
    output OneSecTimeOut;
    reg OneSecTimeOut;
    reg [3:0] Count;
    wire HundredmsTimeout;
 
    countTo100 u_100 (clk, rst, Enable, HundredmsTimeout);
 
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            Count <= 4'd0;
            OneSecTimeOut <= 1'b0;
        end 
	else begin
            if (HundredmsTimeout == 1'b1) begin
                if (Count < 4'd10) begin
                    Count <= Count + 1;
                    OneSecTimeOut <= 1'b0;
                end 
		else begin
                    Count <= 0;
                    OneSecTimeOut <= 1'b1;
                end
            end 
	    else begin
                OneSecTimeOut <= 1'b0;
            end
        end
    end
endmodule
 
