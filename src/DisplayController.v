// DisplayController: State machine managing all 6 seven-segment displays
// Controls display content based on game state, with flashing and multiple display modes
module DisplayController(
    input [2:0] gameState,          // from GameController: 0=loggedOut, 1=preGame, 2=gameRun, 3=gameOver
    input [6:0] score,              // current score (0-99)
    input [3:0] timerTensDigit,     // timer tens digit from digitTimer
    input [3:0] timerOnesDigit,     // timer ones digit from digitTimer
    input [6:0] personalBest,       // personal best score (0-99)
    input [2:0] globalWinner,       // player ID of global winner (0-7)
    input [5:0] displayBus2, displayBus3, displayBus4, displayBus5,  // mole/spike from GameController
    input clk, rst,
    output reg [6:0] Display0, Display1, Display2, Display3, Display4, Display5
);

    // Display content codes
    wire [6:0] scoreOnesCode, scoreTensCode;
    wire [6:0] timerOnesCode, timerTensCode;
    wire [6:0] bestOnesCode, bestTensCode;
    wire [6:0] playP, playL, playA, playY;
    wire [4:0] winnerLetterCode;
    wire [6:0] winnerDisplay;
    wire [6:0] display2_mole, display3_mole, display4_mole, display5_mole;
    
    // Display state machine
    parameter IDLE = 0, GAMING = 1, FLASH = 2, FINAL = 3;
    reg [2:0] displayState;
    
    // Flash counter (for gameOver flashing)
    reg [31:0] flashCounter;
    // Adjusted for 50 MHz FPGA clock: 0.5s => 25,000,000 cycles; 4s => 200,000,000 cycles
    parameter FLASH_INTERVAL = 25_000_000;  // ~0.5 seconds at 50 MHz
    parameter FLASH_DURATION = 200_000_000; // ~4 seconds total flash
    parameter FLASH_CYCLES = 4;
    
    // Prev game state for edge detection
    reg [2:0] prevGameState;
    
    // Helper modules: Score display
    ScoreDisplay scoreDisplay(.ScoreIn(score), .TensDigitCode(scoreTensCode), .OnesDigitCode(scoreOnesCode));
    NumberDecoder timerTensDecoder(.DecoderIn(timerTensDigit), .DecoderOut(timerTensCode));
    NumberDecoder timerOnesDecoder(.DecoderIn(timerOnesDigit), .DecoderOut(timerOnesCode));
    ScoreDisplay bestDisplay(.ScoreIn(personalBest), .TensDigitCode(bestTensCode), .OnesDigitCode(bestOnesCode));
    
    // Helper modules: Player display (winner)
    PlayerDisplay playerDisplay(.PlayerID(globalWinner), .LetterCode(winnerLetterCode));
    
    // Decode winner letter to 7-seg
    LetterDecoder winnerDecoder(.DecoderIn(winnerLetterCode), .DecoderOut(winnerDisplay));
    
    // Helper: Mole/spike display conversion
    DisplayManager dm(
        .displayBus2(displayBus2), .displayBus3(displayBus3), 
        .displayBus4(displayBus4), .displayBus5(displayBus5),
        .Display2(display2_mole), .Display3(display3_mole), 
        .Display4(display4_mole), .Display5(display5_mole)
    );
    
    // PLAY letters (P, L, A, Y)
    LetterDecoder playP_dec(.DecoderIn(5'd15), .DecoderOut(playP));  // P
    LetterDecoder playL_dec(.DecoderIn(5'd11), .DecoderOut(playL));  // L
    LetterDecoder playA_dec(.DecoderIn(5'd0), .DecoderOut(playA));   // A
    LetterDecoder playY_dec(.DecoderIn(5'd24), .DecoderOut(playY));  // Y
    
    // Combinational: blank display
    wire [6:0] blankDisplay = 7'b1111111;
    
    // State machine
    always @(posedge clk) begin
        if (rst) begin
            displayState <= IDLE;
            flashCounter <= 0;
            prevGameState <= 0;
        end else begin
            prevGameState <= gameState;
            
            case (gameState)
                0, 1: begin  // loggedOut or preGame
                    displayState <= IDLE;
                    flashCounter <= 0;
                end
                
                2: begin  // gameRun
                    displayState <= GAMING;
                    flashCounter <= 0;
                end
                
                3: begin  // gameOver
                    // Check if we just entered gameOver
                    if (prevGameState != 3) begin
                        flashCounter <= 0;
                    end else begin
                        flashCounter <= flashCounter + 1;
                    end
                    
                    // Transition from FLASH to FINAL after ~4 seconds
                    if (flashCounter < FLASH_DURATION) begin
                        displayState <= FLASH;
                    end else begin
                        displayState <= FINAL;
                    end
                end
                
                default: begin
                    displayState <= IDLE;
                    flashCounter <= 0;
                end
            endcase
        end
    end
    
    // Flashing logic for FLASH state
    wire doFlash = (flashCounter / FLASH_INTERVAL) % 2;  // toggle every FLASH_INTERVAL
    
    // Combinational output logic
    always @(*) begin
        case (displayState)
            IDLE: begin
                // All displays off
                Display0 = 7'b1111111;
                Display1 = 7'b1111111;
                Display2 = 7'b1111111;
                Display3 = 7'b1111111;
                Display4 = 7'b1111111;
                Display5 = 7'b1111111;
            end
            
            GAMING: begin
                // Display timer digits on the first two displays; mole/spike stays on the rest.
                Display0 = timerTensCode;
                Display1 = timerOnesCode;
                Display2 = display2_mole;
                Display3 = display3_mole;
                Display4 = display4_mole;
                Display5 = display5_mole;
            end
            
            FLASH: begin
                // Flashing: score (tens/ones) + blank + personal best (tens/ones)
                if (doFlash) begin
                    Display0 = scoreTensCode;    // score tens
                    Display1 = scoreOnesCode;    // score ones
                    Display2 = blankDisplay;     // blank
                    Display3 = blankDisplay;     // blank
                    Display4 = bestTensCode;     // personal best tens
                    Display5 = bestOnesCode;     // personal best ones
                end else begin
                    // All off during flash off phase
                    Display0 = 7'b1111111;
                    Display1 = 7'b1111111;
                    Display2 = 7'b1111111;
                    Display3 = 7'b1111111;
                    Display4 = 7'b1111111;
                    Display5 = 7'b1111111;
                end
            end
            
            FINAL: begin
                // Display "PLAY" + global winner
                Display0 = playP;           // P
                Display1 = playL;           // L
                Display2 = playA;           // A
                Display3 = playY;           // Y
                Display4 = winnerDisplay;   // global winner letter (A-H)
                Display5 = 7'b1111111;      // off
            end
            
            default: begin
                Display0 = 7'b1111111;
                Display1 = 7'b1111111;
                Display2 = 7'b1111111;
                Display3 = 7'b1111111;
                Display4 = 7'b1111111;
                Display5 = 7'b1111111;
            end
        endcase
    end

endmodule
