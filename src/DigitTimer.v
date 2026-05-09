// ECE 6370 - ADD
// Mason Sexton - 5780
// DigitTimer
// This module counts dowwn every time it recives a pulse and then borrows from the module before it
module DigitTimer(BorrowUP,BorrowDN,NoBorrowUP,NoBorrowDN,num,reconfig,clk,rst);
    input BorrowDN, NoBorrowUP, reconfig, clk, rst;
    output BorrowUP, NoBorrowDN;
    output [3:0] num;
    reg BorrowUP, NoBorrowDN;
    reg [3:0] num;

    initial begin
        BorrowUP = 1'b0;
        NoBorrowDN = 1'b0;
        num = 4'b1001;
    end

    always @(posedge clk) begin
        if((rst==1'b0)) begin
            BorrowUP <= 1'b0;
            NoBorrowDN <= 1'b1;
            num <= 4'b0000;
        end
        else if(reconfig==1'b1) begin
            BorrowUP <= 1'b0;
            NoBorrowDN <= 1'b0;
            num <= 4'b1001;
        end
        else if(BorrowDN==1'b1) begin
            if(num>=4'b0001) begin
                num <= num - 4'b0001;
                BorrowUP <= 1'b0;
                NoBorrowDN <= 1'b0;
            end
            else if(NoBorrowUP==1'b0) begin
                num <= 4'b1001;
                BorrowUP <= 1'b1;
                NoBorrowDN <= 1'b0;
            end
            else begin
                BorrowUP <= 1'b0;
                NoBorrowDN <= 1'b1;
                num <= 4'b0000;
            end
        end
        else begin
            BorrowUP <= 1'b0;
            NoBorrowDN <= NoBorrowDN;
            num <= num;
        end
    end
endmodule
