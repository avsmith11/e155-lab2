// testbench for time_mux module. 
// Avery Smith, 9/9/24, avsmith@hmc.edu
// modified from Harris & Harris, Digital Design and Computer Architecture: ARM edition
module time_mux_tb();
  logic clk, reset;
  logic [3:0] s1, s2;
  logic en1, en2;
  logic [3:0] s;
  logic [31:0] vectornum;
  logic [7:0] testvectors[10000:0];
  // instantiate device under test
  time_mux dut(clk, s1, s2, s, en1, en2);

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

  logic [12:0] counter;
  logic enable;
  initial begin
    counter = 0;
    enable = 0;
  end
  //generate low-freq enable signal
  always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == 13'b1000000000000) begin
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