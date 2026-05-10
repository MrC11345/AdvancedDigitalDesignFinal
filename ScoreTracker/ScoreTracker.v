module ScoreTracker(PlayerID, isGuest, ScoreIn, ScoreRequest, PersonalBest, GlobalWinner, ScoreValid, clk, rst);
    input [2:0] PlayerID, isGuest;
    input [6:0] ScoreIn; // 7-bit score input
    input ScoreRequest; // signal to request score update
    output reg [6:0] PersonalBest; // 7-bit personal best score output
    output reg [2:0] GlobalWinner; // 2-bit global winner player ID output
    output reg ScoreValid; // signal to indicate score is valid
    input clk, rst;

    // Connected to ScoreRAM
    reg [2:0] RAMAddress; // Address for ScoreRAM (PlayerID)
    reg [6:0] RAMDataIn; // Data input for ScoreRAM (ScoreIn)
    wire [6:0] RAMDataOut; // Data output from ScoreRAM (current personal best)
    reg RAMWriteEnable; // Write enable for ScoreRAM

    // States
    reg [3:0] State; // 4-bit state variable to track score update process
    parameter RAM_INIT = 0, WAIT_FOR_SCORE = 1, FETCH_RAM = 2, RAM_CYCLE1 = 3, RAM_CYCLE2 = 4, CATCH_RAM = 5, COMPARE_SCORES = 6, UPDATE_RAM = 7, CHECK_GLOBAL = 8, UPDATE_GLOBAL = 9, DONE = 10;

    // ScoreRAM instance
    // TODO: Implement ScoreRAM module and connect it here

    // Score tracking logic
    always @(posedge clk) begin
        if (rst) begin
            PersonalBest <= 7'd0; // Reset personal best to 0
            GlobalWinner <= 3'b000; // Reset global winner to no one
            ScoreValid <= 1'b0; // Invalidate score on reset
        end else begin
            case (State)
                RAM_INIT: begin
                    RAMAddress <= PlayerID; // Set RAM address to current player ID
                    RAMWriteEnable <= 1'b0; // Disable RAM write
                    State <= WAIT_FOR_SCORE; // Move to waiting for score state
                end
                WAIT_FOR_SCORE: begin
                    if (ScoreRequest) begin // Wait for score update request
                        State <= FETCH_RAM; // Move to fetch RAM state
                    end else begin
                        State <= WAIT_FOR_SCORE; // Stay in waiting state
                    end
                end
                FETCH_RAM: begin
                    RAMAddress <= PlayerID; // Set RAM address to current player ID
                    RAMWriteEnable <= 1'b0; // Ensure RAM write is disabled for reading
                    State <= RAM_CYCLE1; // Move to first RAM cycle state
                end
                RAM_CYCLE1: begin
                    State <= RAM_CYCLE2; // Move to second RAM cycle state (simulate read delay)
                end
                RAM_CYCLE2: begin
                    State <= CATCH_RAM; // Move to catch RAM output state
                end
                CATCH_RAM: begin
                    PersonalBest <= RAMDataOut; // Capture current personal best from RAM output
                    State <= COMPARE_SCORES; // Move to compare scores state
                end
                COMPARE_SCORES: begin
                    if (ScoreIn > PersonalBest) begin // If new score is better than personal best
                        State <= UPDATE_RAM; // Move to update RAM state to save new personal best
                    end else begin
                        State <= CHECK_GLOBAL; // Move to check global winner state without updating personal best
                    end
                end
                UPDATE_RAM: begin
                    RAMDataIn <= ScoreIn; // Set data input for RAM to new score
                    RAMWriteEnable <= 1'b1; // Enable RAM write to update personal best in memory
                    State <= CHECK_GLOBAL; // Move to check global winner state after updating personal best
                end
                CHECK_GLOBAL: begin
                    ScoreValid <= 1'b1; // Indicate that the score is valid and can be compared for global winner update
                    State <= UPDATE_GLOBAL; // Move to update global winner state
                end
                UPDATE_GLOBAL: begin
                    GlobalWinner <= PlayerID; // Update global winner to current player ID
                    State <= DONE; // Move to done state
                end
                DONE: begin
                    RAMWriteEnable <= 1'b0; // Disable RAM write after update
                    State <= WAIT_FOR_SCORE; // Return to waiting for score state for next update
                end
                default: begin
                    State <= RAM_INIT; // Default to RAM initialization state
                end
            endcase
        end
    end


endmodule