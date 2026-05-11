// PlayerDisplay: Convert player ID (0-7) to letter code (A-H)
// Player 0 -> A, Player 1 -> B, etc.
module PlayerDisplay(PlayerID, LetterCode);
    input [2:0] PlayerID;      // 3-bit player ID (0-7)
    output reg [4:0] LetterCode;  // 5-bit letter code for LetterDecoder (0-25 for A-Z)
    
    always @(*) begin
        case (PlayerID)
            3'd0: LetterCode = 5'd0;   // A
            3'd1: LetterCode = 5'd1;   // B
            3'd2: LetterCode = 5'd2;   // C
            3'd3: LetterCode = 5'd3;   // D
            3'd4: LetterCode = 5'd4;   // E
            3'd5: LetterCode = 5'd5;   // F
            3'd6: LetterCode = 5'd6;   // G
            3'd7: LetterCode = 5'd7;   // H
            default: LetterCode = 5'd26;  // space
        endcase
    end
    
endmodule
