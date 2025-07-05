module register_file_tb();

    // Inputs
    reg clock;
    reg reset;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    reg write_enable;

    // Outputs
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Instantiate the register file
    reg_file UUT (
        .clock(clock),
        .reset(reset),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clock = ~clock;

    initial begin
        // Initialize signals
        clock = 0;
        reset = 1;
        write_enable = 0;
        write_reg = 5'b0;
        write_data = 32'b0;
        read_reg1 = 5'b0;
        read_reg2 = 5'b0;

        // Apply reset
        #10 reset = 0;

        // Test 1: Write to register 1
        write_enable = 1;
        write_reg = 5'b00001; // Write to register 1
        write_data = 32'hAABBCCDD;
        #10 write_enable = 0; // Disable write

        // Read from register 1
        read_reg1 = 5'b00001; // Read from register 1
        #10;
        $display("Register 1: %h (expected AABBCCDD)", read_data1);

        // Test 2: Write to register 2
        write_enable = 1;
        write_reg = 5'b00010; // Write to register 2
        write_data = 32'h12345678;
        #10 write_enable = 0; // Disable write

        // Read from register 2
        read_reg2 = 5'b00010; // Read from register 2
        #10;
        $display("Register 2: %h (expected 12345678)", read_data2);

        // Test 3: Attempt to write to register zero
        write_enable = 1;
        write_reg = 5'b00000; // Attempt to write to register 0
        write_data = 32'hDEADBEEF;
        #10 write_enable = 0;

        // Read from register zero
        read_reg1 = 5'b00000; // Read from register 0
        #10;
        $display("Register zero: %h (expected 0)", read_data1);

        // Test 4: Verify independent reads
        write_enable = 1;
        write_reg = 5'b00011; // Write to register 3
        write_data = 32'hFACEBEEF;
        #10 write_enable = 0;

        // Simultaneous read of register 1 and 3
        read_reg1 = 5'b00001; // Read from register 1
        read_reg2 = 5'b00011; // Read from register 3
        #10;
        $display("Register 1: %h (expected AABBCCDD)", read_data1);
        $display("Register 3: %h (expected FACEBEEF)", read_data2);

        // End simulation
        $finish;
    end

endmodule