`timescale 1ns / 1ps

module data_memory_tb;

    // Inputs
    reg clock;
    reg reset;
    reg [31:0] addr_in;
    reg [31:0] writedata_in;
    reg re_in;
    reg we_in;
    reg [1:0] size_in;
    reg [7:0] serial_in;
    reg serial_ready_in;
    reg serial_valid_in;

    // Outputs
    wire [31:0] readdata_out;
    wire [7:0] serial_out;
    wire serial_rden_out;
    wire serial_wren_out;

    // Instantiate the data_memory module
    data_memory uut (
        .clock(clock),
        .reset(reset),
        .addr_in(addr_in),
        .writedata_in(writedata_in),
        .re_in(re_in),
        .we_in(we_in),
        .size_in(size_in),
        .readdata_out(readdata_out),
        .serial_in(serial_in),
        .serial_ready_in(serial_ready_in),
        .serial_valid_in(serial_valid_in),
        .serial_out(serial_out),
        .serial_rden_out(serial_rden_out),
        .serial_wren_out(serial_wren_out)
    );

    // Clock generation
    always #5 clock = ~clock;

    // Test procedure
    initial begin
        // Initialize inputs
        clock = 0;
        reset = 1;
        addr_in = 32'h0;
        writedata_in = 32'h0;
        re_in = 0;
        we_in = 0;
        size_in = 2'b00;
        serial_in = 8'b0;
        serial_ready_in = 1;
        serial_valid_in = 1;

        // Reset the system
        #10 reset = 0;

        // Test Data Segment
        addr_in = 32'h10000004;  // Address in the data segment
        writedata_in = 32'hDEADBEEF; // Write data
        we_in = 1;              // Enable write
        #10;
        we_in = 0;              // Disable write
        re_in = 1;              // Enable read
        #10;
        $display("Data Segment: Addr=%h, ReadData=%h", addr_in, readdata_out); // Expect DEADBEEF
        re_in = 0;

        // Test Stack Segment
        addr_in = 32'h7FFF0004;  // Address in the stack segment
        writedata_in = 32'hCAFEBABE; // Write data
        we_in = 1;              // Enable write
        #10;
        we_in = 0;              // Disable write
        re_in = 1;              // Enable read
        #10;
        $display("Stack Segment: Addr=%h, ReadData=%h", addr_in, readdata_out); // Expect CAFEBABE
        re_in = 0;

        // Test Serial Write Data Register
        addr_in = 32'hFFFF000C;  // Serial Write Data register
        writedata_in = 32'h41;   // ASCII 'A'
        we_in = 1;              // Enable write
        #10;
        $display("Serial Write: Addr=%h, SerialOut=%h, WriteEnable=%b", addr_in, serial_out, serial_wren_out); // Expect SerialOut=41, WriteEnable=1
        we_in = 0;

        // Test Serial Write Ready Register
        addr_in = 32'hFFFF0008;  // Serial Write Ready register
        re_in = 1;              // Enable read
        #10;
        $display("Serial Write Ready: Addr=%h, WriteReady=%b", addr_in, readdata_out[0]); // Expect WriteReady=1
        re_in = 0;

        // End simulation
        #50;
        $finish;
    end

endmodule