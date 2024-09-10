module adder_tb();
    logic clk, reset;
    logic [3:0] s1, s2;
    logic [4:0] sum, expected_sum;
    logic [31:0] vectornum, errors;
    logic [12:0] testvectors[10000:0];
    // instantiate device under test
    adder dut(s1, s2, sum);
    // generate clock
    always
        begin
        clk = 1; #5;
        clk = 0; #5;
    end
    initial
    begin
        $readmemb("adder_tb.tv", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #27; reset = 0;
    end
    // apply test vectors on rising edge of clk
    always @(posedge clk)
    begin
        #1; {s1, s2, expected_sum} = testvectors[vectornum];
    end
    initial
        begin
       // Create dumpfile for signals
       $dumpfile("adder.vcd");
       $dumpvars(0, adder_tb);
     end
    // check results on falling edge of clk
    always @(negedge clk) begin
        if (~reset) begin // skip during reset
            if (sum !== expected_sum) begin // check result
                $display("Error: inputs = %b", {s1, s2});
                $display(" outputs = %b (%b expected)", sum, expected_sum);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 4'bx) begin
                $display("%d tests completed with %d errors",
                vectornum, errors);
                $finish;
            end
		end
    end
endmodule