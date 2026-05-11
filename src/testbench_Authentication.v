

`timescale 1 ns/100 ps
module testbench_Authentication( );
  reg enter_digit_b_s, logout_start_from_GC_s, pswd_reset_start_from_GC_s, clk, rst;
  reg [3:0] current_digit_s;
  wire loggedIn_s, loggedOut_s, reset_done_s, isGuest_to_GC_s;
  wire [2:0] playerID_to_GC_s; 
  
  always
    begin
      clk = 1'b0;
      #10;
      clk = 1'b1;
      #10;
    end
  
  Authentication DUT_Auth(enter_digit_b_s, logout_start_from_GC_s, pswd_reset_start_from_GC_s, current_digit_s, loggedIn_s, loggedOut_s, reset_done_s, isGuest_to_GC_s, playerID_to_GC_s, clk, rst);
  
  initial
    begin
	  pswd_reset_start_from_GC_s = 1'b0;
	  logout_start_from_GC_s = 1'b0;
	  enter_digit_b_s = 1'b0;
	  rst = 1'b0;
	  
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 rst = 1'b1;
	  
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 rst = 1'b0;

	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0101; //id enter try 1 start incorrect: 5098
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0000;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b1000;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0101; //id enter try 2 start correct: 5099
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0000;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0000; //pw enter try 1 start incorrect: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0010; //pw enter try 1 start incorrect: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk); 

	  #5 current_digit_s = 4'b0000; //pw enter try 2 start incorrect: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0010; //pw enter try 2 start incorrect: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk); //end try 2

	  #5 current_digit_s = 4'b0000; //pw enter try 3 start incorrect: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0010; //pw enter try 3 start incorrect: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk); //end try 3, enter id again

//try id again

	  #5 current_digit_s = 4'b0101; //id enter try start correct: 5099
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0000;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk); 
//end id enter

	  #5 current_digit_s = 4'b0000; //pw enter try 3 start incorrect: 012526
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0010; //pw enter try correct: 012526
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0110;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
          @(posedge clk);



//below new tests

      #5 pswd_reset_start_from_GC_s = 1'b1;
	  @(posedge clk);
	  #5 pswd_reset_start_from_GC_s = 1'b0;
	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0000; //pswd rst start
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);

	  #5 current_digit_s = 4'b0001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0101; //new pswd = 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0101; //new pswd = 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

//end pw rst
	  
	  #5 logout_start_from_GC_s = 1'b1; //logout
  	  @(posedge clk);
	  #5 logout_start_from_GC_s = 1'b0;
  	  @(posedge clk);

  	  @(posedge clk);
  	  @(posedge clk);

  	  @(posedge clk);

  	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0101; //login 1 start: id 5099
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0000;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b1001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

//correct id, now test reset password

	  #5 current_digit_s = 4'b0000; //pw enter try after reset: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0001;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0010;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0010; //pw enter try: 012525
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0101;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk); //end try 

//test guest login
	  #5 logout_start_from_GC_s = 1'b1; //logout
  	  @(posedge clk);
	  #5 logout_start_from_GC_s = 1'b0;
  	  @(posedge clk);

  	  @(posedge clk);
  	  @(posedge clk);

  	  @(posedge clk);

  	  @(posedge clk);
  	  @(posedge clk);

//guest login: id = 4444

	  #5 current_digit_s = 4'b0100; //login guest start: id 4444
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

	  #5 current_digit_s = 4'b0100;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  
	  #5 current_digit_s = 4'b0100;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
	  
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);  
	  
	  #5 current_digit_s = 4'b0100;
	  
  	  @(posedge clk);
	  
	  #5 enter_digit_b_s = 1'b1;
  	  @(posedge clk);
	  #5 enter_digit_b_s = 1'b0;
  	  @(posedge clk);
	  
  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);

//guest logout
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);
	  @(posedge clk);
  	  @(posedge clk);


  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);

	  #5 pswd_reset_start_from_GC_s = 1'b1; //logout if guest tries to reset password
  	  @(posedge clk);
	  #5 pswd_reset_start_from_GC_s = 1'b0;
  	  @(posedge clk);

  	  @(posedge clk);
  	  @(posedge clk);

	  @(posedge clk);
  	  @(posedge clk);

	  
	end
	
endmodule
