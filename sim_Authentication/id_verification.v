// ECE 6370
// Author: Ethan Chung 2265099
// id_verification.v
// This module serves as a player ID verification module for the FPGA "Whack A Mole" game. It takes as input a 16-bit player ID (4-bits at a time) and compares them to each of the
// Values in memory until it finds a valid player ID. Otherwise, it sends the player back to enter the ID again. 
// Everything is working well!

module id_verification(enter_digit_b, logout_start, current_digit, id_from_ROM, idAddr, idVerified, isGuest, idInternal, clk, rst);
  input enter_digit_b, logout_start, clk, rst;
  input [3:0] current_digit;
  input [15:0] id_from_ROM;
  
  output idVerified;
  output isGuest;
  reg isGuest;
  output [4:0] idAddr;
  output [2:0] idInternal;

  reg idVerified;
  
  reg [4:0] idAddr;
  reg [2:0] idInternal;
  
  reg [3:0] State;
  reg [15:0] candidateID, memoryID;
  
  parameter ID_DIGIT1=0, ID_DIGIT2=1, ID_DIGIT3=2, ID_DIGIT4=3, FETCH_ID=4, WAIT1=5, WAIT2=6, CATCH_ID=7, COMPARE_IDS=8, ID_VERIFIED=9;
  
  always@(posedge clk)
    begin
	  if(rst == 1'b1)
	    begin
	      idVerified <= 1'b0;
		  isGuest <= 1'b0;
		  idInternal <= 3'b000;
		  candidateID <= 16'b0000000000000000;
		  memoryID <= 16'b0000000000000000;
		  State <= ID_DIGIT1;
	    end
      else 
        begin
          case(State)
		    ID_DIGIT1: begin
			  if(enter_digit_b == 1'b1) begin
			    candidateID[15:12] <= current_digit;
				State <= ID_DIGIT2;
			  end
			  else begin
			    State <= ID_DIGIT1;
			  end
			end
			ID_DIGIT2: begin
			  if(enter_digit_b == 1'b1) begin
			    candidateID[11:8] <= current_digit;
				State <= ID_DIGIT3;
			  end
			  else begin
			    State <= ID_DIGIT2;
			  end
			end
			ID_DIGIT3: begin
			  if(enter_digit_b == 1'b1) begin
			    candidateID[7:4] <= current_digit;
				State <= ID_DIGIT4;
			  end
			  else begin
			    State <= ID_DIGIT3;
			  end
			end
			ID_DIGIT4: begin
			  if(enter_digit_b == 1'b1) begin
			    candidateID[3:0] <= current_digit;
				State <= FETCH_ID;
			  end
			  else begin
			    State <= ID_DIGIT4;
			  end
			end
			FETCH_ID: begin
			  idAddr <= {2'b00, idInternal};
			  State <= WAIT1;
			end
			WAIT1: begin
			  State <= WAIT2;
			end
			WAIT2: begin
			  State <= CATCH_ID;
			end
			CATCH_ID: begin
			  memoryID <= id_from_ROM;
			  State <= COMPARE_IDS;
			end
			COMPARE_IDS: begin
			  if(candidateID == memoryID) begin
			    if(memoryID == 16'b0100010001000100) begin
				  isGuest <= 1'b1;
				end
			    idVerified <= 1'b1;
				State <= ID_VERIFIED;
			  end
			  else begin
			    if(memoryID == 16'b1111111111111111) begin
				  idInternal <= 3'b000;
				  State <= ID_DIGIT1;
				end
				else begin
				  idInternal <= idInternal + 1'b1;
				  State <= FETCH_ID;
				end
			  end
			end
			ID_VERIFIED: begin
			  if(logout_start == 1'b1) begin
			    idVerified <= 1'b0;
				isGuest <= 1'b0;
				idInternal <= 3'b000;
			    candidateID <= 16'b0000000000000000;
		        memoryID <= 16'b0000000000000000;
		        State <= ID_DIGIT1;
		      end
			  else begin
			    State <= ID_VERIFIED;
		      end
			end
			default: begin
		      idVerified <= 1'b0;
		      isGuest <= 1'b0;
		      idInternal <= 3'b000;
		      candidateID <= 16'b0000000000000000;
		      memoryID <= 16'b0000000000000000;
		      State <= ID_DIGIT1;
			
			end
			  
		  endcase
				
        end	//end else
		
		
	end // end always
	
endmodule
