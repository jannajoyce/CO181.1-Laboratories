module Output(
    input [2:0] controlinput,       // 3-bit control input
    input [31:0] programcounter,
    input [31:0] instr,
    input [31:0] ALU_A,
    input [31:0] ALU_B,
    input [31:0] ALU_OUT,
    input [31:0] Serial_OUT,
    output reg [31:0] display     // 32-bit output for display
);

always @(*) begin
    case (controlinput)
        3'b000: display = 32'b0;          // Default value (if needed)
        3'b001: display = programcounter; // Output program counter
        3'b010: display = instr;          // Output instruction
        3'b011: display = ALU_A;          // Output ALU_A
        3'b100: display = ALU_B;          // Output ALU_B
        3'b101: display = ALU_OUT;        // Output ALU result
        3'b110: display = Serial_OUT;     // Output Serial data
        default: display = 32'b111111;    // Default case for undefined control inputs
    endcase
end

endmodule