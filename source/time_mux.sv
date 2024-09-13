// Avery Smith, 9/8/24, avsmith@hmc.edu
// output s alternates between s1 and s2. en1 and en2 go low to depending on which signal is selected
module time_mux( input logic nreset, clk,
				 input logic [3:0] s1, s2,
				 output logic [3:0] s, 
				 output logic en1, en2
);

	// generate 1.46kHz signal from 12MHz clk (12Mhz/2^14 = 730Hz)
	logic [13:0] counter; //14-bit counter to divide clock
	logic ls_osc;
	//negate input for hardware considerations


	// clock divider 
	always_ff @(posedge clk) begin
		if (nreset  == 0) begin counter <= 0; ls_osc <= 0; end
		else begin
			counter <= counter + 1;
			if (counter == 14'b10000000000000) begin
				counter <= 0;
				ls_osc <= ~ls_osc;
			end
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