// ECE 6370
// Author: Alex Samano, 8729 
// One ms Counter
// Counts up to 50,000 then fires a pulse (every 4 clock cycles)
module One_ms_counter (clk, rst, Enable, OnemsTimeOut);
    input clk, rst, Enable;
    output OnemsTimeOut;
    reg OnemsTimeOut;
    reg [15:0] Count;
 
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            Count <= 4'd0;
            OnemsTimeOut <= 1'b0;
        end 
	else begin
            if (Enable == 1'b1) begin
                if (Count < 16'd50000) begin
                    Count <= Count + 1;
                    OnemsTimeOut <= 1'b0;
                end 
                else begin
                    OnemsTimeOut <= 1'b1;
		    Count <= 0;
                end
            end 
	else begin
                OnemsTimeOut <= 1'b0;
            end
        end
    end
endmodule
