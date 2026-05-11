// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: tb_ScoreCounter
// Describe briefly what this module does: Testbench for ScoreCounter.
// Any comments and log: Standardized file header added on 2026-03-28.

`timescale 1ns/100ps
module tb_ScoreCounter();
    reg [1:0] LevelNum;
    reg ScoreUp, ScoreDown;
    reg clk, rst;
    wire [6:0] Score;

    ScoreCounter DUT_ScoreCounter(LevelNum, ScoreUp, ScoreDown, clk, rst, Score);

    always begin
        clk = 1'b1;
        #10;
        clk = 1'b0;
        #10;
    end

    initial begin
        $display("=== ScoreCounter TB Start ===");
        $monitor("T=%0t | rst=%b level=%0d up=%b down=%b score=%0d", $time, rst, LevelNum, ScoreUp, ScoreDown, Score);

        // Initial conditions + reset sequence (similar style to provided example)
        LevelNum = 2'd0;
        ScoreUp = 1'b0;
        ScoreDown = 1'b0;
        rst = 1'b1;

        @(posedge clk);
        rst = 1'b0;
        @(posedge clk);
        rst = 1'b1;
        @(posedge clk);
        rst = 1'b0;

        // Level 1 behavior: +1 on ScoreUp, ScoreDown has no effect
        LevelNum = 2'd1;
        #5 ScoreUp = 1'b1;
        @(posedge clk);
        #5 ScoreUp = 1'b0;

        #5 ScoreDown = 1'b1;
        @(posedge clk);
        #5 ScoreDown = 1'b0;

        // Level 2 behavior: +1 and -1
        LevelNum = 2'd2;
        #5 ScoreUp = 1'b1;
        @(posedge clk);
        #5 ScoreUp = 1'b0;

        #5 ScoreDown = 1'b1;
        @(posedge clk);
        #5 ScoreDown = 1'b0;

        // Level 3 behavior: +1 and -3
        LevelNum = 2'd3;
        #5 ScoreUp = 1'b1;
        @(posedge clk);
        #5 ScoreUp = 1'b0;

        #5 ScoreDown = 1'b1;
        @(posedge clk);
        #5 ScoreDown = 1'b0;

        // Drive Score toward upper bound to observe saturation behavior
        LevelNum = 2'd2;
        repeat (110) begin
            #5 ScoreUp = 1'b1;
            @(posedge clk);
            #5 ScoreUp = 1'b0;
        end

        // Give a few extra cycles
        @(posedge clk);
        @(posedge clk);

        $display("=== ScoreCounter TB End ===");
        $stop;
    end
endmodule