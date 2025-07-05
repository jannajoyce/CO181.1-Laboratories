module program_counter_tb();
    // Inputs
    reg clock, reset;
    reg [31:0] pc_in;
    
    // Output
    wire [31:0] pc_out;

    // Instantiate the program_counter module
    program_counter uut (
        .clock(clock),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Clock generation (5 ns period)
    always #5 clock = ~clock;

    // Test scenarios
    initial begin
        // Initialize inputs
        clock = 0; reset = 1; pc_in = 32'h00000000;
        
        // Test 1: Reset operation
        #10 reset = 0; // Release reset, expect the output to start from the default reset value
        #10 pc_in = 32'h00400004; // Update PC input
        #10;
        
        // Test 2: Normal operation
        pc_in = 32'h00400008; // Set a new PC value
        #10;
        pc_in = 32'h0040000C; // Another update
        #10;
        
        // Test 3: Rapid changes to pc_in
        pc_in = 32'h12345678; // Test arbitrary value
        #5;
        pc_in = 32'h87654321; // Test another arbitrary value
        #5;
        pc_in = 32'hABCDEF01; // Test with yet another value
        #10;
        
        // Test 4: Reset during operation
        reset = 1; // Assert reset
        #10;
        reset = 0; // Release reset
        pc_in = 32'h00400010; // After reset, provide a new value
        #10;

        // Test 5: Edge case (maximum value)
        pc_in = 32'hFFFFFFFF; // Set PC to max value
        #10;

        // Test 6: Edge case (minimum value)
        pc_in = 32'h00000000; // Set PC to min value
        #10;

        $finish; // End simulation
    end
endmodule