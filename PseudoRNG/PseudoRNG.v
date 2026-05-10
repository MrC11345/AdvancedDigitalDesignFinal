module LFSR8_8E(clock, rng_out);
  input clock;
  output [7:0] rng_out;

  reg [7:0] LFSR;
  wire feedback = LFSR[7];

  always @(posedge clock)
  begin
    LFSR[0] <= feedback;
    LFSR[1] <= LFSR[0];
    LFSR[2] <= LFSR[1] ^ feedback;
    LFSR[3] <= LFSR[2] ^ feedback;
    LFSR[4] <= LFSR[3] ^ feedback;
    LFSR[5] <= LFSR[4];
    LFSR[6] <= LFSR[5];
    LFSR[7] <= LFSR[6];
  end

  assign rng_out = LFSR;
endmodule