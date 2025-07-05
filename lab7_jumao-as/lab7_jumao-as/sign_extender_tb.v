module sign_extender_tb();
    reg [15:0] in;
    wire [31:0] out;

    sign_extender uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Test 1: Largest positive 16-bit number
        in = 16'h7FFF;
        $display("Test 1: in = 0x7FFF (positive)");
        #10;

        // Test 2: Most negative 16-bit number (sign bit = 1)
        in = 16'h8000;
        $display("Test 2: in = 0x8000 (negative)");
        #10;

        // Test 3: Small positive number
        in = 16'h1234;
        $display("Test 3: in = 0x1234 (positive)");
        #10;

        // Test 4: Small negative number (e.g., 0xFFFC = -4)
        in = 16'hFFFC;
        $display("Test 4: in = 0xFFFC (negative)");
        #10;

        $display("--- Sign Extender Testbench End ---\n");
        $finish;
    end
	 
	 initial begin
        $monitor("Time: %0t | Input: %h | Sign-Extended Output: %h", 
                  $time, in, out);
    end
	 
endmodule