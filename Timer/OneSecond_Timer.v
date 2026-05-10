// ECE 6370
// Author: Alex Samano, 8729 
// One Second Timer
// The top module to start the counter and sends a pulse every second
module OneSecond_Timer(clk, rst, Enable, Timeout);
    input clk, rst;
    input Enable;
    output Timeout;
 
    countTo10 u_10 (clk, rst, Enable, Timeout);
endmodule
