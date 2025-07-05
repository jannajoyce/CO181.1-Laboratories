`timescale 1ns / 1ps

module wrapper(
    input [9:0] SW,             // Switch inputs
    input [3:0] KEY,            // KEY[0] = clock, KEY[1] = reset

    output [6:0] hex_display0,  // 7-segment display digit 0 (LSB)
    output [6:0] hex_display1,  // 7-segment display digit 1
    output [6:0] hex_display2,  // 7-segment display digit 2
    output [6:0] hex_display3,  // 7-segment display digit 3
    output [6:0] hex_display4,  // 7-segment display digit 4
    output [6:0] hex_display5,  // 7-segment display digit 5

    output reg [3:0] led1,      // LED group 1
    output reg [3:0] led2       // LED group 2
);

reg clock;
reg reset;

    // Wires to capture processor output
    wire [31:0] pc_out;
    wire [31:0] instruction_out;
    wire [31:0] alu_a_out;
    wire [31:0] alu_b_out;
    wire [31:0] alu_out_output;
    wire [7:0] serial_out;
    wire serial_wren_out;

    // Instantiate the processor
    processor uut (
        .clock(KEY[0]),
        .reset(KEY[1]),
        .serial_in(8'b0),
        .serial_valid_in(1'b0),
        .serial_ready_in(1'b1),
        .serial_out(serial_out),
        .serial_rden_out(), // not used
        .serial_wren_out(serial_wren_out),
        .pc_out(pc_out),
        .instruction_out(instruction_out),
        .alu_a_out(alu_a_out),
        .alu_b_out(alu_b_out),
        .alu_out_output(alu_out_output)
    );

    // Combined output result based on SW[2:0] selector
    wire [31:0] result;

    display show (
    .controlinput(SW[2:0]),
    .programcounter(pc_out),
    .instr(instruction_out),
    .ALU_A(alu_a_out),
    .ALU_B(alu_b_out),
    .ALU_OUT(alu_out_output),
    .Serial_OUT(serial_out),
    .outputs(result)
);


    // 7-Segment Displays
    hexTo7seg hex_display_inst0 (.x(result[3:0]),   .z(hex_display0));
    hexTo7seg hex_display_inst1 (.x(result[7:4]),   .z(hex_display1));
    hexTo7seg hex_display_inst2 (.x(result[11:8]),  .z(hex_display2));
    hexTo7seg hex_display_inst3 (.x(result[15:12]), .z(hex_display3));
    hexTo7seg hex_display_inst4 (.x(result[19:16]), .z(hex_display4));
    hexTo7seg hex_display_inst5 (.x(result[23:20]), .z(hex_display5));

    // LEDs display upper bits of result
    always @* begin
        led1 = result[27:24];
        led2 = result[31:28];
    end

endmodule
