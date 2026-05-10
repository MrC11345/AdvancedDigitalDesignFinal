module ScoreTracker(PlayerID, isGuest, ScoreIn, ScoreRequest, PersonalBest, GlobalWinner, ScoreValid, clk, rst);
    input [2:0] PlayerID, isGuest;
    input [6:0] ScoreIn; // 7-bit score input
    input ScoreRequest; // signal to request score update
    output reg [6:0] PersonalBest; // 7-bit personal best score output
    output reg [2:0] GlobalWinner; // 2-bit global winner player ID output
    output reg ScoreValid; // signal to indicate score is valid
    input clk, rst;


endmodule