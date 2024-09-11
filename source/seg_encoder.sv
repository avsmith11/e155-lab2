// Avery Smith - avsmith@hmc.edu, 9/2/24
// takes in a 4-bit value and gives the seven-segment enconding for the corresponding hexadecimal
// NOTE: this is made for an active-low (common anode) display. to convert for active-high (common cathode) display, remove ~( x ) from each case
module seg_encoder (
	input logic [3:0] s,
	output logic [6:0] seg
);

	always_comb
		case (s)
			// segments g:a
			4'h0: seg = ~(7'b0111111);
			4'h1: seg = ~(7'b0000110);
			4'h2: seg = ~(7'b1011011);
			4'h3: seg = ~(7'b1001111);
			4'h4: seg = ~(7'b1100110);
			4'h5: seg = ~(7'b1101101);
			4'h6: seg = ~(7'b1111101);
			4'h7: seg = ~(7'b0000111);
			4'h8: seg = ~(7'b1111111);
			4'h9: seg = ~(7'b1101111);
			4'ha: seg = ~(7'b1110111);
			4'hb: seg = ~(7'b1111100);
			4'hc: seg = ~(7'b0111001);
			4'hd: seg = ~(7'b1011110);
			4'he: seg = ~(7'b1111011);
			4'hf: seg = ~(7'b1110001);
			default: seg = ~(7'b0000001);
		endcase
	
endmodule