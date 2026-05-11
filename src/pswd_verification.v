// ECE 6370
// Author: Ethan Chung 2265099
// pswd_verification.v
// This module serves as a player password verification module for the FPGA "Whack A Mole" game. It takes as input a 24-bit player ID (4-bits at a time, one digit at a time) and compares it to
// The password stored in memory for the current player's ID. Otherwise, it sends the player back to enter the ID again. 
// Everything is working well!

module pswd_verification(isGuest, idVerified, idInternal, logout_start_from_GC, pw_reset_start_from_GC, pw_enter_b, pswd_sw, pswd_from_RAM, pswd_from_ROM, //inputs
  loggedIn, loggedOut, logout_start_to_ID, reset_done, isGuest_to_GC, playerID_to_GC, addr_to_mem, RW, pswd_to_RAM, clk, rst); //outputs except for clk, rst
  
  input isGuest, idVerified, logout_start_from_GC, pw_reset_start_from_GC, pw_enter_b, clk, rst;
  
  input [2:0] idInternal;
  //reg [2:0] player_ID;
  input [3:0] pswd_sw;
  input [23:0] pswd_from_RAM, pswd_from_ROM;
  
  reg [23:0] pswd_entered, pswd_from_mem;
  
  reg [4:0] pswd_reset_status; //pswd_reset_status register, idx corresponds to the same spot in memory as the stored passwords
  
  output loggedIn, loggedOut, logout_start_to_ID, reset_done, isGuest_to_GC, RW;
  reg loggedIn, loggedOut, logout_start_to_ID, reset_done, isGuest_to_GC, RW;
  
  output [2:0] playerID_to_GC;
  reg [2:0] playerID_to_GC;
  
  output [4:0] addr_to_mem;
  reg [4:0] addr_to_mem;
  
  output [23:0] pswd_to_RAM;
  reg [23:0] pswd_to_RAM;
  
  reg [1:0] loginAttempt;
  
  reg [4:0] State;
  
  parameter WAIT_4_ID=0, DIGIT1=1, DIGIT2=2, DIGIT3=3, DIGIT4=4, DIGIT5=5, DIGIT6=6, FETCH_PW=7, WAIT1=8, WAIT2=9, CATCH_PW=10, CMP_PWS=11, LOGOUT_WAIT=12,
  PASSED=13, RESET_D1=14, RESET_D2=15, RESET_D3=16, RESET_D4=17, RESET_D5=18, RESET_D6=19, SEND_PW=20, RELEASE_PW=21;
  
  always@(posedge clk)
    begin
	  logout_start_to_ID <= 1'b0; //end logout_start_to_ID pulse
	  reset_done <= 1'b0; //end reset done pulse
	  if(rst == 1'b1)
	    begin
		  pswd_entered <= 24'b000000000000000000000000;
		  pswd_from_mem <= 24'b000000000000000000000000;
		  pswd_reset_status <= 5'b00000;
		  loggedIn <= 1'b0;
		  loggedOut <= 1'b1;
		  logout_start_to_ID <= 1'b0;
		  reset_done <= 1'b0;
		  isGuest_to_GC <= 1'b0;
		  playerID_to_GC = 3'b000;
		  RW <= 1'b0;
		  pswd_to_RAM <= 24'b000000000000000000000000;
		  loginAttempt <= 2'b01;
		  State <= WAIT_4_ID;
		end
	  else
	    begin
		  case(State)
		    WAIT_4_ID: begin
			  if(idVerified == 1'b1)
			    begin
				  if(isGuest == 1'b1)
				    begin
					  isGuest_to_GC <= 1'b1;
					  State <= PASSED;
					end
				  else
				    begin
					  State <= DIGIT1;
					end
				end
		      else
			    begin
				  State <= WAIT_4_ID;
				end
		    end
			DIGIT1: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered [23:20] <= pswd_sw;
				State <= DIGIT2;
			  end
			  else begin
			    State <= DIGIT1;
			  end
			end
			DIGIT2: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered [19:16] <= pswd_sw;
				State <= DIGIT3;
			  end
			  else begin
			    State <= DIGIT2;
			  end
			end
			DIGIT3: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered [15:12] <= pswd_sw;
				State <= DIGIT4;
			  end
			  else begin
			    State <= DIGIT3;
			  end
			end
			DIGIT4: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered [11:8] <= pswd_sw;
				State <= DIGIT5;
			  end
			  else begin
			    State <= DIGIT4;
			  end
			end
			DIGIT5: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered [7:4] <= pswd_sw;
				State <= DIGIT6;
			  end
			  else begin
			    State <= DIGIT5;
			  end
			end
			DIGIT6: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered [3:0] <= pswd_sw;
				State <= FETCH_PW;
			  end
			  else begin
			    State <= DIGIT6;
			  end
			end
			FETCH_PW: begin
			  addr_to_mem = {2'b00, idInternal};
			  State <= WAIT1;
			end
			WAIT1: begin
			  State <= WAIT2;
			end
			WAIT2: begin
			  State <= CATCH_PW;
			end
			CATCH_PW: begin
			  if(pswd_reset_status[idInternal] == 1) begin
			    pswd_from_mem <= pswd_from_RAM;
			  end
			  else begin
			    pswd_from_mem <= pswd_from_ROM;
			  end
			  State <= CMP_PWS;
			end
			CMP_PWS: begin
			  if(pswd_entered == pswd_from_mem) begin
			    State <= PASSED;
			    loginAttempt <= 2'b01;
			  end
			  else begin
			    if(loginAttempt == 2'b11) begin
				  loginAttempt <= 2'b01;
				  logout_start_to_ID <= 1'b1; //have player enter id again after 3 attempts
				  State <= LOGOUT_WAIT;
				end
				else begin
				  loginAttempt <= loginAttempt + 1'b1;
				  State <= DIGIT1;
				end
			  end
			end
			LOGOUT_WAIT: begin
			  State <= WAIT_4_ID;
			end
			PASSED: begin
			  if(logout_start_from_GC == 1'b1) begin
		        logout_start_to_ID <= 1'b1;
				loggedIn <= 1'b0;
				loggedOut <= 1'b1;
		        isGuest_to_GC <= 1'b0;
		        playerID_to_GC <= 3'b000;
				State <= LOGOUT_WAIT;
			  end
			  else if(pw_reset_start_from_GC == 1'b1) begin
				if(isGuest == 1'b1) begin //if guest tries to reset password they are logged out
				  logout_start_to_ID <= 1'b1;
			      loggedIn <= 1'b0;
				  loggedOut <= 1'b1;
				  isGuest_to_GC <= 1'b0;
				  playerID_to_GC <= 3'b000;
				  State <= LOGOUT_WAIT;
				end
				else begin
				  loggedIn <= 1'b0; //block game control inputs
				  State <= RESET_D1;
			    end
		      end
			  else begin
				loggedIn <= 1'b1;
				loggedOut <= 1'b0;
				isGuest_to_GC <= isGuest;
				playerID_to_GC <= idInternal;
				State <= PASSED;
			  end
			end
			RESET_D1: begin
			  if(pw_enter_b == 1'b1) begin
				pswd_entered[23:20] <= pswd_sw;
			    State <= RESET_D2;
		      end
			  else begin
				State <= RESET_D1;
			  end
		    end
			RESET_D2: begin
			  if(pw_enter_b == 1'b1) begin
				pswd_entered[19:16] <= pswd_sw;
				State <= RESET_D3;
		      end
			  else begin
				State <= RESET_D2;
		      end
		    end
			RESET_D3: begin
			  if(pw_enter_b == 1'b1) begin
				pswd_entered[15:12] <= pswd_sw;
				State <= RESET_D4;
			  end
			  else begin
				State <= RESET_D3;
			  end
		    end
			RESET_D4: begin
			  if(pw_enter_b == 1'b1) begin
				pswd_entered[11:8] <= pswd_sw;
				State <= RESET_D5;
			  end
			  else begin
				State <= RESET_D4;
			  end
		    end
			RESET_D5: begin
			  if(pw_enter_b == 1'b1) begin
			    pswd_entered[7:4] <= pswd_sw;
				State <= RESET_D6;
			  end
		      else begin
				State <= RESET_D5;
			  end
		    end
			RESET_D6: begin
			  if(pw_enter_b == 1'b1) begin
				pswd_entered[3:0] <= pswd_sw;
				State <= SEND_PW;
			  end
		      else begin
				State <= RESET_D6;
			  end
		    end
			SEND_PW: begin 
			  RW = 1'b1;
		      addr_to_mem = {2'b00, idInternal};
		      pswd_to_RAM <= pswd_entered;
			  State <= RELEASE_PW;
		    end
			RELEASE_PW: begin
			  RW = 1'b0;
		      reset_done <= 1'b1;
			  pswd_reset_status[idInternal] <= 1'b1;
			  State <= PASSED;
			end
			default: begin
		      pswd_entered <= 24'b000000000000000000000000;
		      pswd_from_mem <= 24'b000000000000000000000000;
		      pswd_reset_status <= 5'b00000;
		      loggedIn <= 1'b0;
		      loggedOut <= 1'b1;
		      logout_start_to_ID <= 1'b0;
		      reset_done <= 1'b0;
		      isGuest_to_GC <= 1'b0;
		      playerID_to_GC = 3'b000;
		      RW <= 1'b0;
		      pswd_to_RAM <= 24'b000000000000000000000000;
		      loginAttempt <= 2'b01;
		      State <= WAIT_4_ID;
			end
			  
		  endcase
		  
		end //else (reset)
			  
				  
	end //always@
	
endmodule
  
  
  
  
  