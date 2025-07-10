`timescale 1ns/1ps

module testbench();

    reg clock;
    reg reset;

    wire [7:0] serial_out;
    wire serial_wren;

    wire [31:0] pc_out;
    wire [31:0] instruction_out;
    wire [31:0] alu_a_out;
    wire [31:0] alu_b_out;
    wire [31:0] alu_out_output;

    // Generate clock: 100MHz = 10ns period (half-period = 5ns)
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Apply reset for first 200ns
    initial begin
        reset = 1;
        #200 reset = 0;
    end

    // Instantiate the processor
    processor dut (
        .clock(clock),
        .reset(reset),
        .serial_in(8'b0),
        .serial_valid_in(1'b0),
        .serial_ready_in(1'b1),
        .serial_rden_out(),
        .serial_out(serial_out),
        .serial_wren_out(serial_wren),
        .pc_out(pc_out),
        .instruction_out(instruction_out),
        .alu_a_out(alu_a_out),
        .alu_b_out(alu_b_out),
        .alu_out_output(alu_out_output)
    );

    // Display processor internal state on each clock cycle
    always @(posedge clock) begin
        if (!reset) begin
            $display("[%0t ns] PC: %h | Instruction: %h | A: %h | B: %h | ALU_OUT: %h", 
                     $time, pc_out, instruction_out, alu_a_out, alu_b_out, alu_out_output);
            if (serial_wren)
                $display("[%0t ns] Serial Output: %c (0x%h)", $time, serial_out, serial_out);
        end
    end

    // Stop simulation after some time (e.g., 5 us)
    initial begin
        #5000 $finish;
    end

endmodule