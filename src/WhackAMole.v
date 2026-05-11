// WhackAMole.v - Top-level wiring-only module
// No internal logic; only instantiates and wires submodules.
module WhackAMole(
    // Inputs
    input [3:0] PasswordDigits,
    input ResetSwitch,
    input Button0, Button1, Button2, Button3,
    input clk,

    // Outputs
    output [6:0] Display0, Display1, Display2, Display3, Display4, Display5,
    output LoggedIn, LoggedOut
);

    // Button shaped outputs (after debounce/pulse generation)
    wire button0_shaped, button1_shaped, button2_shaped, button3_shaped;

    // Wires
    wire isGuest;
    wire [2:0] playerID_auth;

    wire timerEnable, timerReconfig;
    wire [3:0] timerLength;
    wire timerDone;  // generated internally by TimerController
    wire [6:0] gameScore;
    wire [2:0] gameState;
    wire [5:0] displayBus2, displayBus3, displayBus4, displayBus5;
    wire [6:0] personalBest;
    wire [2:0] globalWinner;
    wire scoreValid;

    // Merged reset signal
    wire reset = ResetSwitch;

    // =====================================================================
    // Button Shapers: Debounce all buttons into clean single-cycle pulses
    // =====================================================================
    ButtonShaper bs0(.ButtonIn(Button0), .ButtonOut(button0_shaped), .clk(clk), .rst(reset));
    ButtonShaper bs1(.ButtonIn(Button1), .ButtonOut(button1_shaped), .clk(clk), .rst(reset));
    ButtonShaper bs2(.ButtonIn(Button2), .ButtonOut(button2_shaped), .clk(clk), .rst(reset));
    ButtonShaper bs3(.ButtonIn(Button3), .ButtonOut(button3_shaped), .clk(clk), .rst(reset));

    // Authentication: button0 pulses are used as PasswordDigitEnter signal
    Authentication auth_inst(
        .enter_digit_b(button0_shaped),
        .logout_start_from_GC(),
        .pw_reset_start_from_GC(ResetSwitch),
        .current_digit(PasswordDigits),
        .loggedIn_to_GC_and_LED(LoggedIn),
        .loggedOut(LoggedOut),
        .reset_done(),
        .isGuest_to_GC(isGuest),
        .playerID_to_GC(playerID_auth),
        .clk(clk),
        .rst(reset)
    );

    // =====================================================================
    // Timer Controller: generates timerDone internally from GameController signals
    // =====================================================================
    TimerController timer_inst(
        .TimerEnable(timerEnable),
        .TimerReconfig(timerReconfig),
        .timerLength(timerLength),
        .timerDone(timerDone),
        .clk(clk),
        .rst(reset)
    );

    // Game controller: shaped buttons routed directly
    // During game: buttons are gameplay inputs
    // Button remapping (PasswordReset, GameStart, LogOut) is handled by GameController FSM based on gameState
    GameController game_inst(
        .playerID(playerID_auth),
        .logIn(LoggedIn),
        .logOut(),
        .button1(button0_shaped),
        .button2(button1_shaped),
        .button3(button2_shaped),
        .button4(button3_shaped),
        .isGuest(isGuest),
        .timerEnable(timerEnable),
        .timerReconfig(timerReconfig),
        .timerLength(timerLength),
        .timerDone(timerDone),
        .score(gameScore),
        .gameState(gameState),
        .personalBest(personalBest),
        .globalWinner(globalWinner),
        .scoreValid(scoreValid),
        .displayBus2(displayBus2),
        .displayBus3(displayBus3),
        .displayBus4(displayBus4),
        .displayBus5(displayBus5),
        .clk(clk),
        .rst(reset)
    );

    // Display controller: pure wiring
    DisplayController display_inst(
        .gameState(gameState),
        .score(gameScore),
        .personalBest(personalBest),
        .globalWinner(globalWinner),
        .displayBus2(displayBus2),
        .displayBus3(displayBus3),
        .displayBus4(displayBus4),
        .displayBus5(displayBus5),
        .clk(clk),
        .rst(reset),
        .Display0(Display0),
        .Display1(Display1),
        .Display2(Display2),
        .Display3(Display3),
        .Display4(Display4),
        .Display5(Display5)
    );

endmodule
