// Course Number: ECE 5440/6370
// Author: Zoey Ballard, 0323
// Name of your module: OneSecTimer
// Describe briefly what this module does: Wraps lower-level counters to generate
// a one-second timeout pulse when enabled.
// Any comments and log: Standardized file header added on 2026-03-28.

module OneSecTimer(Enable, OneSecTimeOut, clk, rst);
	input Enable;
	input clk, rst;
	output OneSecTimeOut;

	countTo10 CountTo10_1 (Enable, OneSecTimeOut, clk, rst);

endmodule
