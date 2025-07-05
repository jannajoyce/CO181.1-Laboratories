module display (
    input [2:0] controlinput,       // 3-bit control input
    input [31:0] programcounter,
    input [31:0] instr,
    input [31:0] ALU_A,
    input [31:0] ALU_B,
    input [31:0] ALU_OUT,
    input [7:0] Serial_OUT,
    output reg [31:0] outputs     // 32-bit output for display
);

always @(*) begin
    case (controlinput)
        3'b000: outputs = 32'b0;          // Default value (if needed)
        3'b001: outputs = programcounter; // Output program counter
        3'b010: outputs = instr;          // Output instruction
        3'b011: outputs = ALU_A;          // Output ALU_A
        3'b100: outputs = ALU_B;          // Output ALU_B
        3'b101: outputs = ALU_OUT;        // Output ALU result
        3'b110: outputs = Serial_OUT;     // Output Serial data
        default: outputs = 32'b1;    // Default case for undefined control inputs
    endcase
end

endmodule
