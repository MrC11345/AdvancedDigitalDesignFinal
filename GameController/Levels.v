module Levels(levelNum, button_inputs, rng_in, score_increase, score_decrease, mole_location, spike_location, timerEnable, timerReconfig, timerLength ,timerDone, clk, rst);
    input [1:0] levelNum; 
    input [3:0] button_inputs;
    input [7:0] rng_in;
    input timerDone, clk, rst;
    output reg score_increase, score_decrease, timerReconfig;
    output reg timerEnable;
    output reg [3:0] timerLength; // used to reconfig timer
    output reg [3:0] obj_location; 
    output reg [3:0] obj_type_out;

    parameter IDLE = 2'b00, LEVEL1 = 2'b01, LEVEL2 = 2'b10, LEVEL3 = 2'b11;
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

    // latch locations and type
    reg [3:0] objLoc_r;
    reg [3:0] objType_r;

    always @(posedge clk) begin
            score_increase <= 1'b0;
            score_decrease <= 1'b0;
            timerReconfig <= 1'b0;

        if (rst) begin
            state <= LEVEL1; 
            timerEnable <= 1'b0;
            timerReconfig <= 1'b0;
            timerLength <= TIMER_LENGTH1; 
            obj_location <= 4'b0000;
            obj_type_out <= 4'b0000;
            objLoc_r <= 4'b0000;
            objType_r <= 4'b0000;
        end 

        else begin 
            case (state)
                IDLE: begin
                    timerEnable <= 1'b0;
                    obj_location <= 4'b0000;
                    obj_type_out <= 4'b0000;
                    objLoc_r <= 4'b0000;
                    objType_r <= 4'b0000;
                    case (levelNum)
                        2'd1:begin timerLength <= TIMER_LENGTH1; state <= LEVEL1; timerReconfig <= 1'b1; end
                        2'd2:begin timerLength <= TIMER_LENGTH2; state <= LEVEL2; timerReconfig <= 1'b1; end
                        2'd3:begin timerLength <= TIMER_LENGTH3; state <= LEVEL3; timerReconfig <= 1'b1; end
                        default: state <= IDLE;
                    endcase
                end 
                LEVEL1: begin
                    timerEnable <= 1'b1;
                    timerLength <= TIMER_LENGTH1;

                    // moles only 
                    objLoc_r[0] <= object_present[0];
                    objLoc_r[1] <= object_present[1];
                    objLoc_r[2] <= object_present[2];
                    objLoc_r[3] <= object_present[3];
                    objType_r[0] <= 1'b0; // all moles
                    objType_r[1] <= 1'b0;
                    objType_r[2] <= 1'b0;
                    objType_r[3] <= 1'b0;

                    obj_location <= objLoc_r;
                    obj_type_out <= objType_r;

                    // hit detection for moles
                    if (button_inputs[0] & objLoc_r[0] & ~objType_r[0]) begin
                        score_increase <= 1'b1;
                        objLoc_r[0]   <= 1'b0;
                    end
                    if (button_inputs[1] & objLoc_r[1] & ~objType_r[1]) begin
                        score_increase <= 1'b1;
                        objLoc_r[1]   <= 1'b0;
                    end
                    if (button_inputs[2] & objLoc_r[2] & ~objType_r[2]) begin
                        score_increase <= 1'b1;
                        objLoc_r[2]   <= 1'b0;
                    end
                    if (button_inputs[3] & objLoc_r[3] & ~objType_r[3]) begin
                        score_increase <= 1'b1;
                        objLoc_r[3]   <= 1'b0;
                    end
                    
                    if (timerDone) begin
                        timerEnable <= 1'b0; // stop timer
                        timerReconfig <= 1'b1; // reconfigure timer for next level
                        state <= IDLE; 
                    end

                end
                LEVEL2: begin
                    timerEnable <= 1'b1;
                    timerLength <= TIMER_LENGTH2;

                    // moles and spikes (only one type per location)
                    objLoc_r[0] <= obj_present[0];
                    objLoc_r[1] <= obj_present[1];
                    objLoc_r[2] <= obj_present[2];
                    objLoc_r[3] <= obj_present[3];
                    objType_r[0] <= obj_present[0] ? obj_type[0] : 1'b0; // type only set if present
                    objType_r[1] <= obj_present[1] ? obj_type[1] : 1'b0;
                    objType_r[2] <= obj_present[2] ? obj_type[2] : 1'b0;
                    objType_r[3] <= obj_present[3] ? obj_type[3] : 1'b0;
                    
                    obj_location <= objLoc_r;
                    obj_type_out <= objType_r;

                    // hit detection for moles and spikes
                    if (button_inputs[0] & objLoc_r[0]) begin
                        if (~objType_r[0]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[0] <= 1'b0;
                    end
                    if (button_inputs[1] & objLoc_r[1]) begin
                        if (~objType_r[1]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[1] <= 1'b0;
                    end
                    if (button_inputs[2] & objLoc_r[2]) begin
                        if (~objType_r[2]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[2] <= 1'b0;
                    end
                    if (button_inputs[3] & objLoc_r[3]) begin
                        if (~objType_r[3]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[3] <= 1'b0;
                    end

                    if (timerDone) begin
                        timerEnable <= 1'b0; // stop timer
                        timerReconfig <= 1'b1; // reconfigure timer for next level
                        state <= IDLE;
                    end
                end
                LEVEL3: begin
                    timerEnable <= 1'b1;
                    timerLength <= TIMER_LENGTH3;

                    objLoc_r[0] <= obj_present[0];
                    objLoc_r[1] <= obj_present[1];
                    objLoc_r[2] <= obj_present[2];
                    objLoc_r[3] <= obj_present[3];
                    objType_r[0] <= obj_present[0] ? obj_type[0] : 1'b0; // type only set if present
                    objType_r[1] <= obj_present[1] ? obj_type[1] : 1'b0;
                    objType_r[2] <= obj_present[2] ? obj_type[2] : 1'b0;
                    objType_r[3] <= obj_present[3] ? obj_type[3] : 1'b0;

                    obj_type_out <= objType_r;
                    obj_location <= objLoc_r;

                    // hit detection for moles and spikes
                    if (button_inputs[0] & objLoc_r[0]) begin
                        if (~objType_r[0]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[0] <= 1'b0;
                    end
                    if (button_inputs[1] & objLoc_r[1]) begin
                        if (~objType_r[1]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[1] <= 1'b0;
                    end
                    if (button_inputs[2] & objLoc_r[2]) begin
                        if (~objType_r[2]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[2] <= 1'b0;
                    end
                    if (button_inputs[3] & objLoc_r[3]) begin
                        if (~objType_r[3]) begin score_increase <= 1'b1; end
                        else               begin score_decrease <= 1'b1; end
                        objLoc_r[3] <= 1'b0;
                    end

                    if (timerDone) begin
                        timerEnable <= 1'b0; // stop timer
                        timerReconfig <= 1'b1; // reconfigure timer for next level
                        state <= IDLE;
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
