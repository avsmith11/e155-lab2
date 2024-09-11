// testbench for time_mux module. 
// Avery Smith, 9/10/24, avsmith@hmc.edu
// modified from Harris & Harris, Digital Design and Computer Architecture: ARM edition
`timescale 1ns/1ns
module testbench();
  logic clk, reset;
  logic [3:0] s1, s2;
  logic [4:0] sum;
  logic [6:0] seg;
  logic en1, en2;
  logic [31:0] vectornum;
  logic [7:0] testvectors[10000:0];
  // instantiate device under test
  top dut(reset, s1, s2, sum, seg, en1, en2);

  // generate clock
  always begin
      clk = 1; #5;
      clk = 0; #5;
  end
  // at start of test, load vectors
  // and pulse reset
  initial
    begin
      $readmemb("time_mux_tb.tv", testvectors);
      vectornum = 0;
      reset = 1; #27; reset = 0;
  end

  logic [11:0] counter;
  logic enable;
  initial begin
    counter = 0;
    enable = 0;
  end
  //generate low-freq enable signal
  always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == 12'b100000000000) begin
			counter <= 0;
			enable <= ~enable;
		end
	end

  // apply test vectors on rising edge of clk
  always @(posedge enable) begin
      #1; {s1, s2} = testvectors[vectornum];
  end

  // check results on falling edge of clk
  always @(negedge enable) begin
      vectornum = vectornum + 1;
      if (testvectors[vectornum] === 8'bx) begin
        $display("%d tests completed", vectornum);
      end
  end
endmodule