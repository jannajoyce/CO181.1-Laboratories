module adder_tb ();
    reg [31:0] a, b;
    wire [31:0] sum;

    adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
       // Test Case 1: Small hex values
        a = 32'h00000005; b = 32'h0000000A;
        #10 $display("Add Result: %h + %h = %h", a, b, sum);

        // Test Case 2: Adding zero
        a = 32'h00000000; b = 32'h000004D2; // 0 + 1234
        #10 $display("Add Result: %h + %h = %h", a, b, sum);

        // Test Case 3: Large numbers
        a = 32'h000F4240; b = 32'h001E8480; // 1,000,000 + 2,000,000
        #10 $display("Add Result: %h + %h = %h", a, b, sum);

        // Test Case 4: Overflow case
        a = 32'hFFFFFFFF; b = 32'h00000001;
        #10 $display("Add Result: %h + %h = %h", a, b, sum);

        // Test Case 5: Negative + positive (in 2's complement)
        a = 32'hFFFFFFF1; b = 32'h00000014; // -15 + 20
        #10 $display("Add Result: %h + %h = %h", a, b, sum);

        $finish;
    end
	 
	 // Monitor values in real-time
    initial begin
        $monitor("Time: %0t | a = %h | b = %h | sum = %h", $time, a, b, sum);
    end
	 
endmodule