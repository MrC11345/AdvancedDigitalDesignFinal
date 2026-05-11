// DisplayManager: decode 6-bit display buses into 7-seg outputs using LetterDecoder
module DisplayManager(displayBus2, displayBus3, displayBus4, displayBus5, Display2, Display3, Display4, Display5);
    input [5:0] displayBus2, displayBus3, displayBus4, displayBus5; // [5]=enable, [4]=type(0=mole,1=spike), [3:0]=number (unused here)
    output [6:0] Display2, Display3, Display4, Display5;

    wire [4:0] code2, code3, code4, code5;

    // If not enabled -> space (5'd26), else mole (5'd13) when type==0, spike (5'd12) when type==1
    assign code2 = (displayBus2[5] == 1'b0) ? 5'd26 : (displayBus2[4] == 1'b0 ? 5'd13 : 5'd12);
    assign code3 = (displayBus3[5] == 1'b0) ? 5'd26 : (displayBus3[4] == 1'b0 ? 5'd13 : 5'd12);
    assign code4 = (displayBus4[5] == 1'b0) ? 5'd26 : (displayBus4[4] == 1'b0 ? 5'd13 : 5'd12);
    assign code5 = (displayBus5[5] == 1'b0) ? 5'd26 : (displayBus5[4] == 1'b0 ? 5'd13 : 5'd12);

    LetterDecoder LD2(code2, Display2);
    LetterDecoder LD3(code3, Display3);
    LetterDecoder LD4(code4, Display4);
    LetterDecoder LD5(code5, Display5);

endmodule
