// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: OneMillisecondTimer_LFSR
// Describe briefly what this module does: Generates an approximately 1 ms timeout
// pulse using a 16-bit LFSR-based counter when enabled.
// Any comments and log: Standardized file header added on 2026-04-13.

module OneMillisecondTimer_LFSR(enable, OnemsTimeOut, clk, rst);
  input clk, enable;
  input rst;
  output OnemsTimeOut;
  reg OnemsTimeOut;

  reg [15:0] LFSR;
  wire feedback = LFSR[15];

  always @(posedge clk)
  begin
    if (rst == 1'b0)
      begin
        LFSR <= 16'h0001;  // start at 0000
	OnemsTimeOut <= 1'b0;
      end
    else begin
         if (enable == 1'b1) begin
	   if (LFSR == 16'd19152) begin
	     LFSR <= 16'd1;
	     OnemsTimeOut <= 1'b1;
	   end
           else begin
             LFSR[0]  <= feedback;
             LFSR[1]  <= LFSR[0];
             LFSR[2]  <= LFSR[1]  ~^ feedback;  // tap 3
             LFSR[3]  <= LFSR[2]  ~^ feedback;  // tap 4
             LFSR[4]  <= LFSR[3];
             LFSR[5]  <= LFSR[4]  ~^ feedback;  // tap 6
             LFSR[6]  <= LFSR[5];
             LFSR[7]  <= LFSR[6];
             LFSR[8]  <= LFSR[7];
             LFSR[9]  <= LFSR[8];
             LFSR[10] <= LFSR[9];
             LFSR[11] <= LFSR[10];
             LFSR[12] <= LFSR[11]; // ~^ feedback;  // tap 13 (F=12 added state)
             LFSR[13] <= LFSR[12];
             LFSR[14] <= LFSR[13];
             LFSR[15] <= LFSR[14];
	     OnemsTimeOut <= 1'b0;
           end
         end
	 else begin
	   LFSR <= 16'd1;
           OnemsTimeOut <= 1'b0;
	 end
    end
  end

  //assign q = LFSR;
endmodule
