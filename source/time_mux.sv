// Avery Smith, 9/8/24, avsmith@hmc.edu
// output s alternates between s1 and s2. en1 and en2 go low to depending on which signal is selected
module time_mux(input logic clk,
				 input logic [3:0] s1, s2,
				 output logic [3:0] s, 
				 output logic en1, en2
);

	// generate 1.46kHz signal from 12MHz clk (12Mhz/2^13 = 1.46kHz)
	logic [12:0] counter; //13-bit counter to divide clock
	logic ls_osc;

	initial begin
		counter = 0;
		ls_osc = 0;
	end

	// clock divider 
	always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == 13'b1000000000000) begin
			counter <= 0;
			ls_osc <= ~ls_osc;
		end
	end
		
    // Set s, en1, and en2 signals based on ls_osc
    always_comb begin
        if (ls_osc == 0) begin
            s = s1;
            en1 = 0;
            en2 = 1;  // For active-high, en1 = 1, en2 = 0
        end if (ls_osc == 1) begin
            s = s2;
            en1 = 1;
            en2 = 0;  // For active-high, en1 = 0, en2 = 1
        end
    end
endmodule