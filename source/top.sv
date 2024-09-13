// Avery Smith, 9/8/24, avsmith@hmc.edu
// takes in two 4-bit signals and outputs time-multiplexed signals for two 7-segment displays using ONE instance of segment_driver
module top( input nreset,
			input logic [3:0] s1, s2,
			output logic [4:0] sum,
			output logic [6:0] seg,
			output logic en1, en2
);

	// not s2, s1 for hardware consideratoins
	logic [3:0] ns1, ns2;
	assign ns1 = ~s1;
	assign ns2 = ~s2;
	// generate int_osc signal at 12MHz
	logic int_osc;
	HSOSC #(.CLKHF_DIV(2'b10)) 
		 hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// calculate sum to send to LEDs
	adder adder(ns1, ns2, sum);
	
	// generate time multiplexed signal
	logic [3:0] s;
	time_mux time_mux(nreset, int_osc, ns1, ns2, s, en1, en2);
	
	// send multiplexed signal to 7_seg encoder
	seg_encoder ONLY_ONE_SEGMENT_ENCODER(s, seg);
	
endmodule