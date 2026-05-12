// ECE 6370
// Author: Ethan Chung 2265099
// Authentication.v
// Top-Level module for player authentication, includes the id_verification and pswd_verification modules. Wires them together to create the system that first checks the player's ID
// then the password for that player's ID. 
// Everything is working well!

module Authentication(enter_digit_b, logout_start_from_GC, pw_reset_start_from_GC, current_digit, //inputs
loggedIn_to_GC_and_LED, loggedOut, reset_done, isGuest_to_GC, playerID_to_GC, clk, rst); //outputs
  
  input enter_digit_b, logout_start_from_GC, pw_reset_start_from_GC, clk, rst;
  input [3:0] current_digit;
  
  output loggedIn_to_GC_and_LED, loggedOut, reset_done, isGuest_to_GC;
  //reg loggedIn_to_GC_and_LED, loggedOut, reset_done, isGuest_to_GC;
  output [2:0] playerID_to_GC;
  //reg [2:0] playerID_to_GC;
  wire [2:0] idInternal;
  
  wire [15:0] id_from_ROM;
  wire [4:0] id_addr_to_ROM, pw_addr;
  
  wire idVerified, isGuest, logout_start_from_pw, ReadWrite;
 // wire bs_out, pwrst, logout;
  
  wire [23:0] pswd_from_ROM, pswd_from_RAM, pswd_to_RAM;
  
  //ButtonShaper button_shaper(enter_digit_b, bs_out, clk, rst); //keep for testing
  //ButtonShaper button_shaperPWR(pw_reset_start_from_GC, pwrst, clk, rst);
  //ButtonShaper button_shaperLO(logout_start_from_GC, logout, clk, rst);
  
  id_verification id_verify(enter_digit_b, logout_start_from_pw, current_digit, id_from_ROM, id_addr_to_ROM, idVerified, isGuest, idInternal, clk, rst);
  
  pswd_verification pw_verify(isGuest, idVerified, idInternal, logout_start_from_GC, pw_reset_start_from_GC, enter_digit_b, current_digit, pswd_from_RAM, pswd_from_ROM, loggedIn_to_GC_and_LED,
  loggedOut, logout_start_from_pw, reset_done, isGuest_to_GC, playerID_to_GC, pw_addr, ReadWrite, pswd_to_RAM, clk, rst);
  
  PLAYER_ID_ROM pid_ROM(id_addr_to_ROM, clk, id_from_ROM);
  
  RAM_PSWD pswd_RAM(pw_addr, clk, pswd_to_RAM, ReadWrite, pswd_from_RAM);
  ROM_PSWD pswd_ROM(pw_addr, clk, pswd_from_ROM);
  
endmodule
  
  
  