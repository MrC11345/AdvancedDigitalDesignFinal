// ECE6370
// Mason Sexton: 5780
// mslfsr
// This module is designed to impliment a one ms timer using lfsr tech
module MSLFSR(enable, timerDone, clk, rst);
  input clk, enable;
  input rst;
  output timerDone;
  reg timerDone;

  reg [15:0] LFSR;
  wire feedback = LFSR[15];

  always @(posedge clk) begin
    if (rst == 1'b0)
      begin
        LFSR <= 16'h0001;
        timerDone <= 1'b0;
      end
    else begin
         if (enable == 1'b1) begin
            if (LFSR == 16'd19152) begin
                LFSR <= 16'd1;
                timerDone <= 1'b1;
            end
            else begin
                LFSR[0]  <= feedback;
                LFSR[1]  <= LFSR[0];
                LFSR[2]  <= LFSR[1]  ~^ feedback;
                LFSR[3]  <= LFSR[2]  ~^ feedback;
                LFSR[4]  <= LFSR[3];
                LFSR[5]  <= LFSR[4]  ~^ feedback;
                LFSR[6]  <= LFSR[5];
                LFSR[7]  <= LFSR[6];
                LFSR[8]  <= LFSR[7];
                LFSR[9]  <= LFSR[8];
                LFSR[10] <= LFSR[9];
                LFSR[11] <= LFSR[10];
                LFSR[12] <= LFSR[11];
                LFSR[13] <= LFSR[12];
                LFSR[14] <= LFSR[13];
                LFSR[15] <= LFSR[14];
                timerDone <= 1'b0;
            end
        end
        else begin
            LFSR <= 16'd1;
            timerDone <= 1'b0;
        end
    end
end

endmodule