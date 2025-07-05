`timescale 1ns / 1ps

module control (
    input [31:0] instruction, // The full 32-bit instruction
    output reg RegDst,        // Selects destination register
    output reg ALUSrc,        // Selects ALU input source
    output reg MemToReg,      // Selects data to write back to the register
    output reg RegWrite,      // Enables writing to the register file
    output reg MemRead,       // Enables memory read
    output reg MemWrite,      // Enables memory write
    output reg [5:0] ALUOp    // ALU operation code
);

    // Extract opcode and function code
    wire [5:0] opcode = instruction[31:26];
    wire [5:0] funct = instruction[5:0];

    // Opcodes
    localparam LW   = 6'b100011;
    localparam SW   = 6'b101011;
    localparam ADDI = 6'b001000;

    // R-type instructions share the same opcode
    localparam R_TYPE = 6'b000000;

    // Function codes for R-type instructions
    localparam ADD  = 6'b100000;
    localparam SUB  = 6'b100010;
    localparam AND  = 6'b100100;
    localparam OR   = 6'b100101;
    localparam NOR  = 6'b100111;
    localparam XOR  = 6'b100110;

    // Control signal assignment
    always @(*) begin
        // Default values for control signals
        RegDst   = 0;
        ALUSrc   = 0;
        MemToReg = 0;
        RegWrite = 0;
        MemRead  = 0;
        MemWrite = 0;
        ALUOp    = 6'b000000;

        // Decode instruction based on opcode and function code
        case (opcode)
            LW: begin
                // Load Word
                RegDst   = 0;         // Destination register is rt
                ALUSrc   = 1;         // ALU takes immediate as input
                MemToReg = 1;         // Write memory data to register
                RegWrite = 1;         // Enable writing to the register file
                MemRead  = 1;         // Enable memory read
                MemWrite = 0;         // Disable memory write
                ALUOp    = 6'b100000; // ALU performs ADD
            end
            SW: begin
                // Store Word
                RegDst   = 0;         // Don't care
                ALUSrc   = 1;         // ALU takes immediate as input
                MemToReg = 0;         // Don't care
                RegWrite = 0;         // Disable writing to the register file
                MemRead  = 0;         // Disable memory read
                MemWrite = 1;         // Enable memory write
                ALUOp    = 6'b100000; // ALU performs ADD
            end
            ADDI: begin
                // Add Immediate
                RegDst   = 0;         // Destination register is rt
                ALUSrc   = 1;         // ALU takes immediate as input
                MemToReg = 0;         // Write ALU result to register
                RegWrite = 1;         // Enable writing to the register file
                MemRead  = 0;         // Disable memory read
                MemWrite = 0;         // Disable memory write
                ALUOp    = 6'b100000; // ALU performs ADD
            end
            R_TYPE: begin
                // R-Type instructions
                RegDst   = 1;         // Destination register is rd
                ALUSrc   = 0;         // ALU takes register as input
                MemToReg = 0;         // Write ALU result to register
                RegWrite = 1;         // Enable writing to the register file
                MemRead  = 0;         // Disable memory read
                MemWrite = 0;         // Disable memory write
                case (funct)
                    ADD: ALUOp = 6'b100000; // ALU performs ADD
                    SUB: ALUOp = 6'b100010; // ALU performs SUB
                    AND: ALUOp = 6'b100100; // ALU performs AND
                    OR:  ALUOp = 6'b100101; // ALU performs OR
                    NOR: ALUOp = 6'b100111; // ALU performs NOR
                    XOR: ALUOp = 6'b100110; // ALU performs XOR
                    default: ALUOp = 6'b000000; // Default no-op
                endcase
            end
            default: begin
                // Default case to avoid latches
                RegDst   = 0;
                ALUSrc   = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                ALUOp    = 6'b000000;
            end
        endcase
    end

endmodule