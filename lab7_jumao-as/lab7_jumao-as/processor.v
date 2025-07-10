`timescale 1ns / 1ps

module processor (
    input clock,
    input reset,
    input [7:0] serial_in,          // Serial input
    input serial_valid_in,          // Serial valid flag
    input serial_ready_in,          // Serial ready flag
    output [7:0] serial_out,        // Serial output
    output serial_rden_out,         // Serial read enable
    output serial_wren_out,         // Serial write enable
    output [31:0] pc_out,           // Program Counter output
    output [31:0] instruction_out,  // Fetched instruction
    output [31:0] alu_a_out,        // ALU input A
    output [31:0] alu_b_out,        // ALU input B
    output [31:0] alu_out_output  // ALU result
);
	
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

    // Serial wires
    wire [7:0] serial_out_wire;
    wire serial_wren_out_wire;
    wire serial_rden_out_wire;

	     // Adder for PC + 4
    adder PCAdder (
        .a(pc_out),
        .b(32'd4),
        .sum(pc_next)
    );
	 
    // Program Counter
    program_counter PC (
        .clock(clock),
        .reset(reset),
        .pc_in(pc_next),
        .pc_out(pc_out)
    );

     //Instruction Memory
    inst_rom InstructionMemory (
        .clock(clock),
        .reset(reset),
        .addr_in(pc_out),
        .data_out(instruction_out)
    );
	 
	 
	 wire [4:0] write_reg_mux_out;
	 
	 mux2 #(5) RegDst_Mux (
    .in0(instruction_out[20:16]), // rt
    .in1(instruction_out[15:11]), // rd
    .select(RegDst),
    .out(write_reg_mux_out)
);

	 

    // Control Unit
    control Control (
        .instruction(instruction_out),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUOp(alu_op)
    );

    // Register File
    reg_file RegFile (
        .clock(clock),
        .reset(reset),
        .read_reg1(instruction_out[25:21]),  // rs
        .read_reg2(instruction_out[20:16]),  // rt
        //.write_reg(RegDst ? instruction_out[15:11] : instruction_out[20:16]), // rd or rt
        .write_reg(write_reg_mux_out),
		  .write_data(write_data),
        .write_enable(RegWrite),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Sign Extender
    sign_extender SignExt (
        .in(instruction_out[15:0]),
        .out(sign_ext_imm)
    );
	 
	 wire [31:0] alu_b_mux_out;
	 
	 mux2 #(32) ALUSrc_Mux (
    .in0(read_data2),
    .in1(sign_ext_imm),
    .select(ALUSrc),
    .out(alu_b_mux_out)
	 );

    // ALU
    alu ALU (
        .Func_in(alu_op),
        .A_in(read_data1),
        //.B_in(ALUSrc ? sign_ext_imm : read_data2),
        .B_in(alu_b_mux_out),
		  .O_out(alu_out),
        .Branch_out(),
        .Jump_out()
    );

    // Data Memory
    data_memory DataMem (
        .clock(clock),
        .reset(reset),
        .addr_in(alu_out),
        .writedata_in(read_data2),
        .re_in(MemRead),
        .we_in(MemWrite),
        .size_in(2'b11),
        .readdata_out(mem_data_out),
        .serial_in(serial_in),
        .serial_ready_in(serial_ready_in),
        .serial_valid_in(serial_valid_in),
        .serial_out(serial_out_wire),
        .serial_rden_out(serial_rden_out_wire),
        .serial_wren_out(serial_wren_out_wire)
    );
	 
	 wire [31:0] write_data_mux_out;
	 
	 mux2 #(32) MemToReg_Mux (
    .in0(alu_out),
    .in1(mem_data_out),
    .select(MemToReg),
    .out(write_data_mux_out)
	 );

    // Connect outputs
    assign serial_out = serial_out_wire;
    assign serial_rden_out = serial_rden_out_wire;
    assign serial_wren_out = serial_wren_out_wire;
    assign alu_a_out = read_data1;
    //assign alu_b_out = ALUSrc ? sign_ext_imm : read_data2;
    assign alu_b_out = alu_b_mux_out;
	 assign alu_out_output = alu_out;
    //assign write_data = MemToReg ? mem_data_out : alu_out;
	 assign write_data = write_data_mux_out;

endmodule