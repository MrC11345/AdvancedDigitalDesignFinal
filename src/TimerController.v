// TimerController: configurable countdown in seconds using OneSecTimer
// timerLength is a 4-bit multiplier of 11 seconds (as used by GameController)
module TimerController(
    input TimerEnable,
    input TimerReconfig,
    input [3:0] timerLength, // multiplier of 11 seconds
    output reg timerDone,
    input clk, rst
);
    // One-second pulse generator (uses existing OneSecTimer/CountTo10 chain)
    wire oneSecPulse;
    OneSecTimer ost(.Enable(TimerEnable), .OneSecTimeOut(oneSecPulse), .clk(clk), .rst(rst));

    reg [11:0] secondsRemaining; // enough to hold up to 11*15=165 seconds
    reg [11:0] secondsLoad;

    // Load seconds when reconfig asserted
    always @(posedge clk) begin
        if (rst) begin
            secondsRemaining <= 12'd0;
            secondsLoad <= 12'd0;
            timerDone <= 1'b0;
        end else begin
            if (TimerReconfig) begin
                secondsLoad <= timerLength * 12'd11; // multiplier
                secondsRemaining <= timerLength * 12'd11;
                timerDone <= 1'b0;
            end else if (TimerEnable) begin
                if (oneSecPulse) begin
                    if (secondsRemaining == 0) begin
                        // already at zero -> assert sticky timeout
                        timerDone <= 1'b1;
                    end else begin
                        // decrement; if this decrement reaches zero, assert timeout
                        if (secondsRemaining == 12'd1) begin
                            secondsRemaining <= 12'd0;
                            timerDone <= 1'b1;
                        end else begin
                            secondsRemaining <= secondsRemaining - 1;
                            // keep timerDone low while counting
                            timerDone <= 1'b0;
                        end
                    end
                end
                // when not on a oneSecPulse clock, preserve timerDone (sticky)
            end else begin
                // not enabled: preserve timerDone until reconfig clears it
                timerDone <= timerDone;
            end
        end
    end
endmodule
