// ScoreDisplay: Convert 7-bit score (0-99) to two digit codes (tens, ones)
// Each digit code (0-9) is converted to its 7-segment display pattern
module ScoreDisplay(ScoreIn, TensDigitCode, OnesDigitCode);
    input [6:0] ScoreIn;  // 7-bit score (0-99)
    output [6:0] TensDigitCode, OnesDigitCode;
    
    wire [3:0] tens, ones;
    
    // Extract tens and ones digits
    assign tens = (ScoreIn / 10) % 10;  // tens digit
    assign ones = ScoreIn % 10;           // ones digit
    
    // Use NumberDecoder for both
    NumberDecoder TensDecoder(tens, TensDigitCode);
    NumberDecoder OnesDecoder(ones, OnesDigitCode);
    
endmodule
