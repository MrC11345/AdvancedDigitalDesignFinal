module ScoreCounter(LevelNum, ScoreUp, ScoreDown, clk, rst, Score);
    input [1:0] LevelNum;
    input ScoreUp, ScoreDown;
    output reg [6:0] Score; // 7-bit score output
    input clk, rst;

    reg signed [8:0] nextScore; // wider signed temp to avoid wrap before clamp

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Score <= 7'd0; // reset score to 0
        end else begin
            nextScore = $signed({1'b0, Score});

            case (LevelNum)
                2'd1: begin // Level 1
                    if (ScoreUp) nextScore = nextScore + 1;
                    if (ScoreDown) nextScore = nextScore - 0;
                end
                2'd2: begin // Level 2
                    if (ScoreUp) nextScore = nextScore + 1;
                    if (ScoreDown) nextScore = nextScore - 1;
                end
                2'd3: begin // Level 3
                    if (ScoreUp) nextScore = nextScore + 1;
                    if (ScoreDown) nextScore = nextScore - 3;
                end
                default: begin
                    nextScore = nextScore;
                end
            endcase

            // Clamp score to display range 0..99
            if (nextScore < 0)
                nextScore = 0;
            else if (nextScore > 99)
                nextScore = 99;

            Score <= nextScore[6:0];
        end
    end

endmodule