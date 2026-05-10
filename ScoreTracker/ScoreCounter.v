module ScoreCounter(LevelNum, ScoreUp, ScoreDown, clk, rst, Score);
    input [1:0] LevelNum;
    input ScoreUp, ScoreDown;
    output reg [6:0] Score; // 7-bit score output
    input clk, rst;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Score <= 7'd0; // reset score to 0
        end else begin
            case (LevelNum)
                2'd1: begin // Level 1
                    if (ScoreUp) Score <= Score + 1; // Increment score by 1
                    if (ScoreDown) Score <= Score - 0; // Decrement score by 0 (no change)
                end
                2'd2: begin // Level 2
                    if (ScoreUp) Score <= Score + 1; // Increment score by 1
                    if (ScoreDown) Score <= Score - 1; // Decrement score by 1
                end
                2'd3: begin // Level 3
                    if (ScoreUp) Score <= Score + 1; // Increment score by 1
                    if (ScoreDown) Score <= Score - 3; // Decrement score by 3
                end
                default: begin // Default case for safety
                    Score <= Score; // No change to score
                end
            endcase
            
            // Ensure score does not go below 0 or above 99 (7-bit limit)
            if (Score < 0) Score <= 0;
            if (Score > 99) Score <= 99; // Needs to stop at 99 for display purposes
        end
    end

endmodule