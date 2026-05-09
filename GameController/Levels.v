module Levels(levelNum, button_inputs, rng_in, score_increase, score_decrease, mole_location, spike_location, timerEnable, timerReconfig, timerLength ,timerDone, clk, rst);
    input [1:0] levelNum; 
    input [3:0] button_inputs;
    input [15:0] rng_in;
    input timerDone, clk, rst;
    output reg score_increase, score_decrease, timerReconfig;
    output reg timerEnable;
    output reg [3:0] timerLength; // used to reconfig timer
    output reg [3:0] mole_location; 
    output reg [3:0] spike_location;

    parameter LEVEL1 = 2'b00, LEVEL2 = 2'b01, LEVEL3 = 2'b10;
    reg [1:0] state;

    //
    // wire and assign for RNG HERE 
    //

    parameter TIMER_LENGTH1 = 4'd10, TIMER_LENGTH2 = 4'd7, TIMER_LENGTH3 = 4'd5; 

    // latch locations
    reg [3:0] moleLoc_r;
    reg [3:0] spikeLoc_r;

    always @(posedge clk) begin
            score_increase <= 1'b0;
            score_decrease <= 1'b0;
            timerReconfig <= 1'b0;
        if (rst) begin
            state <= LEVEL1; 
            timerEnable <= 1'b0;
            timerReconfig <= 1'b0;
            timerLength <= TIMER_LENGTH1; 
            mole_location <= 4'b0000;
            spike_location <= 4'b0000;
            moleLoc_r <= 4'b0000;
            spikeLoc_r <= 4'b0000;

        end 
        else begin 
            case (state)
                LEVEL1: begin
                    timerLength <= TIMER_LENGTH1;
                end
                LEVEL2: begin
                    timerLength <= TIMER_LENGTH2;
                end
                LEVEL3: begin
                    timerLength <= TIMER_LENGTH3;
                end
            endcase
        end
    end 

endmodule;
