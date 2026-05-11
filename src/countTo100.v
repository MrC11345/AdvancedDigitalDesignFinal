// ECE 6370
// Author: Alex Samano, 8729 
// Count to 100
// Counts to 100 and then fires a pulse (every 1 ms)
module countTo100 (clk, rst, Enable, HundredmsTimeout);
    input clk, rst, Enable;
    output HundredmsTimeout;
    reg HundredmsTimeout;
    reg [6:0] Count;
    wire OnemsTimeout;
 
    One_ms_counter u_ms(clk, rst, Enable, OnemsTimeout);
 
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            Count <= 7'd0;
            HundredmsTimeout <= 1'b0;
        end 
	else begin
            if (OnemsTimeout == 1'b1) begin
                if (Count < 7'd100) begin
                    Count <= Count + 1;
                    HundredmsTimeout <= 1'b0;
                end 
		else begin
                    Count <= 0;
                    HundredmsTimeout <= 1'b1;
                end
            end 
		else begin
                	HundredmsTimeout <= 1'b0;
            	end
            end
        end
endmodule
