// ECE6370
// Mason Sexton: 5780
// Checker
// This module is designed for the bonus feature and only checks if a number is equal to 15
module checker(sumIN,yes,no);

	input [3:0]sumIN;
	output yes, no;
	reg yes;
	reg no;

	always @(sumIN)
	begin
		if(sumIN == 4'b1111)
			begin
				yes = 1;
				no = 0;
			end
		else
			begin
				yes = 0;
				no = 1;
			end
	end

endmodule
