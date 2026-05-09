// ECE 6370 - ADD
// Mason Sexton - 5780
// authentication
// This module manages differnt users access to the program by creating a login and logout functions using ROM
module Authentication(password, load, authenticated, clk, rst);
    input [3:0] password;
    input load, clk, rst;
    output authenticated;
    reg authenticated;

    reg correct;
    reg [3:0] State;
    reg [1:0] counter;
    reg [4:0] addr;
    wire [3:0] q;

    parameter FirstStart = 0, Waiting = 1, GetFromROM1 = 2, GetFromROM2 = 3, GetFromROM3 = 4, Verify = 5, LoggedIn = 6;

    ROM_PSWD ROM_PSWD1(addr, clk, q);

    always @ (posedge clk) begin
        if (rst == 1'b0) begin
            authenticated <= 1'b0;
            correct <= 1'b1;
            addr <= 5'b00000;
            counter <= 2'b00;
            State <= Waiting;
        end
        else begin
            case(State)
                FirstStart: begin
                    authenticated <= 1'b0;
                    correct <= 1'b1;
                    addr <= 5'b00000;
                    counter <= 2'b00;
                    State <= Waiting;
                end
                Waiting: begin
                    if (load==1'b1)
                        State <= GetFromROM1;   
                    else 
                        State <= Waiting;
                end

                GetFromROM1: begin
                    addr <= {3'b000, counter};
                    State <= GetFromROM2;
                end

                GetFromROM2: begin
                    State <= GetFromROM3;
                end

                GetFromROM3: begin
                    State <= Verify;
                end

                Verify: begin
                    if (password != q) 
                        correct <= 1'b0;
                    if (counter < 2'b11) begin
                        counter <= counter + 1;
                        State <= Waiting;
                    end
                    else 
                        State <= LoggedIn;
                end

                LoggedIn: begin
                    if (correct == 1'b1)
                        authenticated <= 1'b1;
                    else
                        State <= FirstStart;   
                end

                default: begin
                    authenticated <= 1'b0;
                    correct <= 1'b1;
                    State <= FirstStart;
                end
            endcase
        end
    end
endmodule