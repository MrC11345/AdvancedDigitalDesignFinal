// ECE 6370 - ADD
// Mason Sexton - 5780
// OneSecTimer
// This module takes an input of enable and then drives an output high after a second has passed
module OneSecTimer(enable,oneSecTimerDone,clk,rst);
    input enable, clk, rst;
    output oneSecTimerDone;

    wire oneMSTo100, countTo100To10;//internal

    MSLFSR MSLFSR1(enable,oneMSTo100,clk,rst);
    CountTo100 CountTo100One(enable,oneMSTo100,countTo100To10,clk,rst);
    CountTo10 CountTo10One(enable,countTo100To10,oneSecTimerDone,clk,rst);

endmodule