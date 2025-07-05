/*module reg_file (
    input clk,                    // Clock signal
    input reset,                  // Reset signal
    input reg_write,              // Write enable signal
    input [4:0] reg_write_addr,   // Address of the register to write
    input [31:0] reg_data_in,     // Data to write to the register
    input [4:0] reg_read_addr1,   // Address of the first register to read
    input [4:0] reg_read_addr2,   // Address of the second register to read
    output reg [31:0] reg_data_out1, // Data output from the first register
    output reg [31:0] reg_data_out2  // Data output from the second register
);

    // 32 32-bit registers (initialized to 0 by default)
    reg [31:0] registers [31:0];

    // Read operation: Asynchronous (no clock)
    always @(*) begin
        if (reg_read_addr1 == 5'b00000) begin
            reg_data_out1 = 32'b0;  // Register 0 is always zero
        end else begin
            reg_data_out1 = registers[reg_read_addr1];
        end
        
        if (reg_read_addr2 == 5'b00000) begin
            reg_data_out2 = 32'b0;  // Register 0 is always zero
        end else begin
            reg_data_out2 = registers[reg_read_addr2];
        end
    end

    // Write operation: Synchronous, occurs only on positive clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to zero
            registers[0] <= 32'b0;  // Register 0 is fixed at 0
            registers[1] <= 32'b0;
            registers[2] <= 32'b0;
            registers[3] <= 32'b0;
            registers[4] <= 32'b0;
            registers[5] <= 32'b0;
            registers[6] <= 32'b0;
            registers[7] <= 32'b0;
            registers[8] <= 32'b0;
            registers[9] <= 32'b0;
            registers[10] <= 32'b0;
            registers[11] <= 32'b0;
            registers[12] <= 32'b0;
            registers[13] <= 32'b0;
            registers[14] <= 32'b0;
            registers[15] <= 32'b0;
            registers[16] <= 32'b0;
            registers[17] <= 32'b0;
            registers[18] <= 32'b0;
            registers[19] <= 32'b0;
            registers[20] <= 32'b0;
            registers[21] <= 32'b0;
            registers[22] <= 32'b0;
            registers[23] <= 32'b0;
            registers[24] <= 32'b0;
            registers[25] <= 32'b0;
            registers[26] <= 32'b0;
            registers[27] <= 32'b0;
            registers[28] <= 32'b0;
            registers[29] <= 32'b0;
            registers[30] <= 32'b0;
            registers[31] <= 32'b0; // Reset all registers
        end
        else if (reg_write && reg_write_addr != 5'b00000) begin
            // Write to the register file, except for register 0 (which is fixed at 0)
            registers[reg_write_addr] <= reg_data_in;
        end
    end
endmodule*/

`timescale 1ns / 1ps

module reg_file (
    input clock,
    input reset,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input write_enable,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    // 32 registers of 32-bit width
    reg [31:0] registers [31:0];
    integer i;

    // Reset and write logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (write_enable && write_reg != 0) begin
            // Write to the register only if write_enable is high and write_reg is non-zero
            registers[write_reg] <= write_data;
        end
    end

    // Continuous assignment for asynchronous reads
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

endmodule