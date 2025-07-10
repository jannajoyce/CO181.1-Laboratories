`timescale 1ns / 1ps

module reg_file_tb();

  // Inputs
    reg clock;
    reg reset;
    reg [4:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    reg write_enable;
    
    // Outputs
    wire [31:0] read_data1, read_data2;
    
    // Instantiate register file
    reg_file dut (
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
        // Initialize
        clock = 0; reset = 1; write_enable = 0;
        #10 reset = 0;
        
        // Test 1: Basic write/read
        write_enable = 1; write_reg = 5'd1; write_data = 32'hA1B2C3D4;
        #10 write_enable = 0; read_reg1 = 5'd1;
        #10 $display("Reg1: %h (expected A1B2C3D4)", read_data1);
        
        // Test 2: Register zero behavior (MIPS ISA)
        write_enable = 1; write_reg = 5'd0; write_data = 32'hFEDCBA98;
        #10 write_enable = 0; read_reg1 = 5'd0;
        #10 $display("Reg0: %h (expected 00000000)", read_data1);
        
        // Test 3: Simultaneous reads
        write_enable = 1; write_reg = 5'd2; write_data = 32'h87654321;
        #10 write_enable = 0; read_reg1 = 5'd1; read_reg2 = 5'd2;
        #10 $display("Reg1: %h, Reg2: %h", read_data1, read_data2);
        
        // Test 4: Write enable control
        write_enable = 0; write_reg = 5'd3; write_data = 32'hFFFFFFFF;
        #10 read_reg1 = 5'd3;
        #10 $display("Reg3 (no write): %h (expected 00000000)", read_data1);
        
        $finish;
    end
endmodule