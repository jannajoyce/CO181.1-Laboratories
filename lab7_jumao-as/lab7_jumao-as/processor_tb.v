`timescale 1ns / 1ps

module processor_tb;

    // Input wires
    reg clock;
    reg reset;
    reg [7:0] serial_in;
    reg serial_valid_in;
    reg serial_ready_in;

    // Output wires
    wire [7:0] serial_out;
    wire serial_rden_out;
    wire serial_wren_out;
    wire [31:0] pc_out;
    wire [31:0] instruction_out;
    wire [31:0] alu_a_out;
    wire [31:0] alu_b_out;
    wire [31:0] alu_out_output;

    // Internal wires for observation
    wire [31:0] pc_next;
    wire [31:0] alu_out;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] mem_data_out;
    wire [31:0] sign_ext_imm;
    wire [31:0] alu_b_in;
    wire [31:0] write_data;
    wire [5:0] opcode;
    wire [5:0] funct;
    wire [5:0] alu_op;
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite;

    // Instantiate the processor
    processor uut (
        .clock(clock),
        .reset(reset),
        .serial_in(serial_in),
        .serial_valid_in(serial_valid_in),
        .serial_ready_in(serial_ready_in),
        .serial_out(serial_out),
        .serial_rden_out(serial_rden_out),
        .serial_wren_out(serial_wren_out),
        .pc_out(pc_out),
        .instruction_out(instruction_out),
        .alu_a_out(alu_a_out),
        .alu_b_out(alu_b_out),
        .alu_out_output(alu_out_output)
    );

    // Clock generation
    always #5 clock = ~clock; // 10ns period (100 MHz)

    initial begin
        // Initialize inputs
        clock = 0;
        reset = 1;          // Assert reset
        serial_in = 8'h00;
        serial_valid_in = 0;
        serial_ready_in = 0;

        // Wait 20ns, then de-assert reset
        #20 reset = 0;

        // Test stimulus
        #50 serial_in = 8'hAA;  // Example serial data input
        serial_valid_in = 1;
        serial_ready_in = 1;

        #100 serial_valid_in = 0;
        serial_ready_in = 0;

        // Wait for 1us (1,000ns)
        #1000 $finish;
    end

    // Observe internal signals
    assign pc_next = uut.pc_next;
    assign alu_out = uut.alu_out;
    assign read_data1 = uut.read_data1;
    assign read_data2 = uut.read_data2;
    assign mem_data_out = uut.mem_data_out;
    assign sign_ext_imm = uut.sign_ext_imm;
    assign alu_b_in = uut.alu_b_in;
    assign write_data = uut.write_data;
    assign opcode = uut.opcode;
    assign funct = uut.funct;
    assign alu_op = uut.alu_op;
    assign RegDst = uut.RegDst;
    assign ALUSrc = uut.ALUSrc;
    assign MemToReg = uut.MemToReg;
    assign RegWrite = uut.RegWrite;
    assign MemRead = uut.MemRead;
    assign MemWrite = uut.MemWrite;

   // Display processor internal state on each clock cycle
    always @(posedge clock) begin
        if (!reset) begin
            $display("[%0t ns] PC: %h | Instruction: %h | A: %h | B: %h | ALU_OUT: %h", 
                     $time, pc_out, instruction_out, alu_a_out, alu_b_out, alu_out_output);
            if (serial_wren_out)
                $display("[%0t ns] Serial Output: %c (0x%h)", $time, serial_out, serial_out);
        end
    end

    // Stop simulation after some time (e.g., 5 us)
    initial begin
        #5000 $finish;
    end

endmodule