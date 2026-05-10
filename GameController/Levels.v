module Levels(levelNum, button_inputs, rng_in, score_increase, score_decrease, mole_location, spike_location, timerEnable, timerReconfig, timerLength ,timerDone, clk, rst);
    input [1:0] levelNum; 
    input [3:0] button_inputs;
    input [8:0] rng_in;
    input timerDone, clk, rst;
    output reg score_increase, score_decrease, timerReconfig;
    output reg timerEnable;
    output reg [3:0] timerLength; // used to reconfig timer
    output reg [3:0] mole_location; 
    output reg [3:0] spike_location;

    parameter LEVEL1 = 2'b00, LEVEL2 = 2'b01, LEVEL3 = 2'b10;
    reg [1:0] state;

    // rng assign
    wire [3:0] obj_present;
    wire [3:0] obj_type;

    assign obj_present[0] = rng_in[0]; 
    assign obj_type[0] = rng_in[1]; 
    assign obj_present[1] = rng_in[2];
    assign obj_type[1] = rng_in[3]; 
    assign obj_present[2] = rng_in[4];
    assign obj_type[2] = rng_in[5];
    assign obj_present[3] = rng_in[6];
    assign obj_type[3] = rng_in[7];


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
                    timerEnable <= 1'b1;
                    timerLength <= TIMER_LENGTH1;
                    // moles only 
                    moleLoc_r[0] <= (obj_present[0] & ~obj_type[0]); // if present and type is 0 then mole
                    moleLoc_r[1] <= (obj_present[1] & ~obj_type[1]);
                    moleLoc_r[2] <= (obj_present[2] & ~obj_type[2]);
                    moleLoc_r[3] <= (obj_present[3] & ~obj_type[3]);
                    spikeLoc_r <= 4'b0000; // no spikes in level 1
                    mole_location <= moleLoc_r;
                    spike_location <= 4'b0000;

                    // score logic
                    if ((button_inputs[0] & moleLoc_r[0]) | (button_inputs[1] & moleLoc_r[1]) | (button_inputs[2] & moleLoc_r[2]) | (button_inputs[3] & moleLoc_r[3])) begin
                        score_increase <= 1'b1; // increase score if hit a mole
                    end

                    if (timerDone) begin
                        timerEnable <= 1'b0; // stop timer
                        timerReconfig <= 1'b1; // reconfigure timer for next level
                        state <= LEVEL2; // move to next level when timer is done    
                    end

                end
                LEVEL2: begin
                    timerEnable <= 1'b1;
                    timerLength <= TIMER_LENGTH2;

                    // moles and spikes
                    moleLoc_r[0] <= (obj_present[0] & ~obj_type[0]); // if present and type is 0 then mole
                    moleLoc_r[1] <= (obj_present[1] & ~obj_type[1]);
                    moleLoc_r[2] <= (obj_present[2] & ~obj_type[2]);
                    moleLoc_r[3] <= (obj_present[3] & ~obj_type[3]);
                    spikeLoc_r[0] <= (obj_present[0] & obj_type[0]); // if present and type is 1 then spike
                    spikeLoc_r[1] <= (obj_present[1] & obj_type[1]);
                    spikeLoc_r[2] <= (obj_present[2] & obj_type[2]);
                    spikeLoc_r[3] <= (obj_present[3] & obj_type[3]);
                    
                    mole_location <= moleLoc_r;
                    spike_location <= spikeLoc_r;

                    if ((button_inputs[0] & moleLoc_r[0]) | (button_inputs[1] & moleLoc_r[1]) | (button_inputs[2] & moleLoc_r[2]) | (button_inputs[3] & moleLoc_r[3])) begin
                        score_increase <= 1'b1; // increase score if hit a mole
                    end
                    if ((button_inputs[0] & spikeLoc_r[0]) | (button_inputs[1] & spikeLoc_r[1]) | (button_inputs[2] & spikeLoc_r[2]) | (button_inputs[3] & spikeLoc_r[3])) begin
                        score_decrease <= 1'b1; // decrease score if hit a spike
                    end

                    if (timerDone) begin
                        timerEnable <= 1'b0; // stop timer
                        timerReconfig <= 1'b1; // reconfigure timer for next level
                        state <= LEVEL3; // move to next level when timer is done    
                    end
                end
                LEVEL3: begin
                    timerEnable <= 1'b1;
                    timerLength <= TIMER_LENGTH3;

                    moleLoc_r[0] <= (obj_present[0] & ~obj_type[0]); // if present and type is 0 then mole
                    moleLoc_r[1] <= (obj_present[1] & ~obj_type[1]);
                    moleLoc_r[2] <= (obj_present[2] & ~obj_type[2]);            
                    moleLoc_r[3] <= (obj_present[3] & ~obj_type[3]);
                    spikeLoc_r[0] <= (obj_present[0] & obj_type[0]); // if present and type is 1 then spike
                    spikeLoc_r[1] <= (obj_present[1] & obj_type[1]);
                    spikeLoc_r[2] <= (obj_present[2] & obj_type[2
                    spikeLoc_r[3] <= (obj_present[3] & obj_type[3]);

                    mole_location <= moleLoc_r;
                    spike_location <= spikeLoc_r;

                    if ((button_inputs[0] & moleLoc_r[0]) | (button_inputs[1] & moleLoc_r[1]) | (button_inputs[2] & moleLoc_r[2]) | (button_inputs[3] & moleLoc_r[3])) begin
                        score_increase <= 1'b1; // increase score if hit a mole
                    end
                    if ((button_inputs[0] & spikeLoc_r[0]) | (button_inputs[1] & spikeLoc_r[1]) | (button_inputs[2] & spikeLoc_r[2]) | (button_inputs[3] & spikeLoc_r[3])) begin
                        score_decrease <= 1'b1; // decrease score if hit a spike
                    end

                    if (timerDone) begin
                        timerEnable <= 1'b0; // stop timer
                        timerReconfig <= 1'b1; // reconfigure timer for next level
                        state <= LEVEL1; // loop back to level 1 when timer is done    
                    end
                end
                default: begin
                    state <= LEVEL1;
                    timerEnable <= 1'b0;
                    timerReconfig <= 1'b0;
                    timerLength <= TIMER_LENGTH1; 
                    mole_location <= 4'b0000;
                    spike_location <= 4'b0000;
                    moleLoc_r <= 4'b0000;
                    spikeLoc_r <= 4'b0000;
                end
            endcase
        end
    end 

endmodule;
