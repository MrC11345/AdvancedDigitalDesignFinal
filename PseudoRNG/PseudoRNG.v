module PseudoRNG(clock, rng_out);
  input clock;
  output [3:0] rng_out;

  reg [3:0] LFSR;
  wire feedback = LFSR[3];

  always @(posedge clock)
  begin
    LFSR[0] <= feedback;
    LFSR[1] <= LFSR[0] ^ feedback;
    LFSR[2] <= LFSR[1];
    LFSR[3] <= LFSR[2];
  end

  assign q = LFSR;
endmodule
