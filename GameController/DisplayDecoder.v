module DisplayDecoder(DecoderIn, Display1, Display2, Display3, Display4, Display5, Display6, Display7);
    input [7:0] DecoderIn; // 3 bits for which display, 2 bits for whether number mole or spike, 3 bits for number or else 0
    output reg [6:0] Display1, Display2, Display3, Display4, Display5, Display6, Display7; // 7-segment display outputs

    always @(*) begin
        // Reset all displays to off
        Display1 = 7'b0000000;
        Display2 = 7'b0000000;
        Display3 = 7'b0000000;
        Display4 = 7'b0000000;
        Display5 = 7'b0000000;
        Display6 = 7'b0000000;
        Display7 = 7'b0000000;

        // Decode which display to activate
        case (DecoderIn[7:5]) // Check the first 3 bits for display selection
            3'b001: begin // Display 1
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display1 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display1 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display1 = 7'b1111101; // Example pattern for spike
            end
            3'b010: begin // Display 2
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display2 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display2 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display2 = 7'b1111101; // Example pattern for spike
            end
            3'b011: begin // Display 3
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display3 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display3 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display3 = 7'b1111101; // Example pattern for spike
            end
            3'b100: begin // Display 4
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display4 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display4 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display4 = 7'b1111101; // Example pattern for spike
            end
            3'b101: begin // Display 5
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display5 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display5 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display5 = 7'b1111101; // Example pattern for spike
            end
            3'b110: begin // Display 6
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display6 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display6 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display6 = 7'b1111101; // Example pattern for spike
            end
            3'b111: begin // Display 7
                if (DecoderIn[4:3] == 2'b00) // Number
                    Display7 = decodeNumber(DecoderIn[2:0]);
                else if (DecoderIn[4:3] == 2'b01) // Mole
                    Display7 = 7'b1111110; // Example pattern for mole
                else if (DecoderIn[4:3] == 2'b10) // Spike
                    Display7 = 7'b1111101; // Example pattern for spike
            end
            default: begin
                // No display selected, keep all off
            end
        endcase
    end
endmodule