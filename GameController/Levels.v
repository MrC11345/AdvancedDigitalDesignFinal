module Levels(levelNum, button_inputs, rng_in, score_increase, score_decrease, obj_type_out, obj_location, roundActive, clk, rst);
    input [1:0] levelNum; 
    input [3:0] button_inputs;
    input [7:0] rng_in;
    input roundActive, clk, rst;
    output reg score_increase, score_decrease;
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


    // latch locations and type
    reg [3:0] objLoc_r;
    reg [3:0] objType_r;

    // timer for object spawn duration
    wire tick;
    OneSecond_Timer timer(clk, rst, roundActive, tick);

    reg [2:0] seconds_counter; // counts seconds for object duration
    
    // Object duration control
    reg [2:0] spawn_duration; 
    always @(*) begin
        case (state)
            LEVEL1: spawn_duration <= 3'd6; 
            LEVEL2: spawn_duration <= 3'd4; 
            LEVEL3: spawn_duration <= 3'd2; 
            default: spawn_duration <= 3'd6;
        endcase
    end


    always @(posedge clk) begin
            score_increase <= 1'b0;
            score_decrease <= 1'b0;

        if (rst) begin
            state <= IDLE; 
            obj_location <= 4'b0000;
            obj_type_out <= 4'b0000;
            objLoc_r <= 4'b0000;
            objType_r <= 4'b0000;
            seconds_counter <= 3'b000;
        end 

        else begin 
            case (state)
                IDLE: begin
                    obj_location <= 4'b0000;
                    obj_type_out <= 4'b0000;
                    objLoc_r <= 4'b0000;
                    objType_r <= 4'b0000;
                    seconds_counter <= 3'b000;
                    case (levelNum)
                        2'd1: state <= LEVEL1;
                        2'd2: state <= LEVEL2;
                        2'd3: state <= LEVEL3;
                        default: state <= IDLE;
                    endcase
                end 
                LEVEL1: begin
                    if (~roundActive) begin
                        obj_location <= 4'b0000;
                        obj_type_out <= 4'b0000;
                        objLoc_r <= 4'b0000;
                        objType_r <= 4'b0000;
                        seconds_counter <= 3'b000;
                        state <= IDLE; 
                    end
                    else begin
                        // moles only
                        if (tick) begin
                            if (seconds_counter < spawn_duration - 1) begin
                                seconds_counter <= seconds_counter + 1;
                            end
                            else begin 
                                objLoc_r[0] <= obj_present[0];
                                objType_r[0] <= 1'b0; // all moles
                                objLoc_r[1] <= obj_present[1];
                                objType_r[1] <= 1'b0;
                                objLoc_r[2] <= obj_present[2];
                                objType_r[2] <= 1'b0;
                                objLoc_r[3] <= obj_present[3];
                                objType_r[3] <= 1'b0;
                                seconds_counter <= 3'b000;
                            end 
                        end

                        obj_location <= objLoc_r;
                        obj_type_out <= objType_r;

                        // hit detection for moles
                        if (button_inputs[0] & objLoc_r[0] & ~objType_r[0]) begin
                            score_increase <= 1'b1;
                            objLoc_r[0]   <= 1'b0;
                        end
                        if (button_inputs[1] & objLoc_r[1] & ~objType_r[1]) begin
                            score_increase <= 1'b1;
                            objLoc_r[1] <= 1'b0;
                        end
                        if (button_inputs[2] & objLoc_r[2] & ~objType_r[2]) begin
                            score_increase <= 1'b1;
                            objLoc_r[2] <= 1'b0;
                        end
                        if (button_inputs[3] & objLoc_r[3] & ~objType_r[3]) begin
                            score_increase <= 1'b1;
                            objLoc_r[3] <= 1'b0;
                        end
                    end
                end 
                LEVEL2: begin
                    if (~roundActive) begin
                        obj_location <= 4'b0000;
                        obj_type_out <= 4'b0000;
                        objLoc_r <= 4'b0000;
                        objType_r <= 4'b0000;
                        seconds_counter <= 3'b000;
                        state <= IDLE; 
                    end
                    else begin
                        if (tick) begin
                            if (seconds_counter < spawn_duration - 1) begin
                                seconds_counter <= seconds_counter + 1;
                            end
                            else begin 
                                // moles and spikes (only one type per location)
                                objLoc_r[0] <= obj_present[0];
                                objType_r[0] <= obj_present[0] ? obj_type[0] : 1'b0; // type only set if present
                                objLoc_r[1] <= obj_present[1];
                                objType_r[1] <= obj_present[1] ? obj_type[1] : 1'b0; // type only set if present
                                objLoc_r[2] <= obj_present[2];
                                objType_r[2] <= obj_present[2] ? obj_type[2] : 1'b0; // type only set if present
                                objLoc_r[3] <= obj_present[3];
                                objType_r[3] <= obj_present[3] ? obj_type[3] : 1'b0; // type only set if present
                                seconds_counter <= 3'b000;
                            end
                        end
                        
                        obj_location <= objLoc_r;
                        obj_type_out <= objType_r;

                        // hit detection for moles and spikes
                        if (button_inputs[0] & objLoc_r[0]) begin
                            if (~objType_r[0]) 
                                 score_increase <= 1'b1; 
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[0] <= 1'b0;
                        end
                        if (button_inputs[1] & objLoc_r[1]) begin
                            if (~objType_r[1]) 
                                score_increase <= 1'b1; 
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[1] <= 1'b0;
                        end
                        if (button_inputs[2] & objLoc_r[2]) begin
                            if (~objType_r[2]) 
                                 score_increase <= 1'b1;
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[2] <= 1'b0;
                        end
                        if (button_inputs[3] & objLoc_r[3]) begin
                            if (~objType_r[3]) 
                                score_increase <= 1'b1; 
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[3] <= 1'b0;
                        end
                    end
                end
                LEVEL3: begin
                    if (~roundActive) begin
                        obj_location <= 4'b0000;
                        obj_type_out <= 4'b0000;
                        objLoc_r <= 4'b0000;
                        objType_r <= 4'b0000;
                        seconds_counter <= 3'b000;
                        state <= IDLE; 
                    end
                    else begin
                        if (tick) begin
                            if (seconds_counter < spawn_duration - 1) begin
                                seconds_counter <= seconds_counter + 1;
                            end
                            else begin 
                                // moles and spikes (only one type per location)
                                objLoc_r[0] <= obj_present[0];
                                objType_r[0] <= obj_present[0] ? obj_type[0] : 1'b0; // type only set if present
                                objLoc_r[1] <= obj_present[1];
                                objType_r[1] <= obj_present[1] ? obj_type[1] : 1'b0; // type only set if present
                                objLoc_r[2] <= obj_present[2];
                                objType_r[2] <= obj_present[2] ? obj_type[2] : 1'b0; // type only set if present
                                objLoc_r[3] <= obj_present[3];
                                objType_r[3] <= obj_present[3] ? obj_type[3] : 1'b0; // type only set if present
                                seconds_counter <= 3'b000;
                            end
                        end

                        obj_type_out <= objType_r;
                        obj_location <= objLoc_r;

                        // hit detection for moles and spikes
                        if (button_inputs[0] & objLoc_r[0]) begin
                            if (~objType_r[0]) 
                                 score_increase <= 1'b1; 
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[0] <= 1'b0;
                        end
                        if (button_inputs[1] & objLoc_r[1]) begin
                            if (~objType_r[1]) 
                                score_increase <= 1'b1; 
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[1] <= 1'b0;
                        end
                        if (button_inputs[2] & objLoc_r[2]) begin
                            if (~objType_r[2]) 
                                 score_increase <= 1'b1;
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[2] <= 1'b0;
                        end
                        if (button_inputs[3] & objLoc_r[3]) begin
                            if (~objType_r[3]) 
                                score_increase <= 1'b1; 
                            else               
                                score_decrease <= 1'b1;
                            objLoc_r[3] <= 1'b0;
                        end
                    end
                end
                default: begin
                    state <= IDLE;
                    obj_location <= 4'b0000;
                    obj_type_out <= 4'b0000;
                    objLoc_r <= 4'b0000;
                    objType_r <= 4'b0000;
                    seconds_counter <= 3'b000;
                end
            endcase
        end
    end 

endmodule
