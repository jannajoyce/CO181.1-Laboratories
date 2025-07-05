//module inst_rom_helloworld (
//    input clock,
//    input reset,
//    input [31:0] addr_in,
//    output reg [31:0] data_out
//);
//    parameter ADDR_WIDTH = 5;
//
//    // Declare ROM with hardcoded instructions
//    reg [31:0] rom [0:2**ADDR_WIDTH-1];
//    integer i; // Declare loop variable
//
//    // Initialize ROM with hardcoded values
//    initial begin
//        rom[0]  = 32'h00400a20;
//        rom[1]  = 32'h22a00a00;
//        rom[2]  = 32'h22a08a02;
//        rom[3]  = 32'h22a08a02;
//        rom[4]  = 32'h22a08a02;
//        rom[5]  = 32'h48000a20;
//        rom[6]  = 32'h0c008aae;
//        rom[7]  = 32'h65000a20;
//        rom[8]  = 32'h0c008aae;
//        rom[9]  = 32'h6c000a20;
//        rom[10] = 32'h0c008aae;
//        rom[11] = 32'h6c000a20;
//        rom[12] = 32'h0c008aae;
//        rom[13] = 32'h6f000a20;
//        rom[14] = 32'h0c008aae;
//        rom[15] = 32'h20000a20;
//        rom[16] = 32'h0c008aae;
//        rom[17] = 32'h57000a20;
//        rom[18] = 32'h0c008aae;
//        rom[19] = 32'h6f000a20;
//        rom[20] = 32'h0c008aae;
//        rom[21] = 32'h72000a20;
//        rom[22] = 32'h0c008aae;
//        rom[23] = 32'h6c000a20;
//        rom[24] = 32'h0c008aae;
//        rom[25] = 32'h64000a20;
//        rom[26] = 32'h0c008aae;
//        rom[27] = 32'h00000000;
//
//
//        // Initialize remaining memory with zeros
//        for (i = 28; i < 2**ADDR_WIDTH; i = i + 1) begin
//            rom[i] = 32'h00000000;
//        end
//    end
//
//    // Fetch instruction with endian correction
//    always @(*) begin
//        if (reset) begin
//            data_out <= 32'h00000000; // Reset output to zero
//        end else begin
//            // Correct endian swapping to match SPIM's expected order
//            data_out <= {
//                rom[addr_in[ADDR_WIDTH+1:2]][7:0], 
//                rom[addr_in[ADDR_WIDTH+1:2]][15:8], 
//                rom[addr_in[ADDR_WIDTH+1:2]][23:16], 
//                rom[addr_in[ADDR_WIDTH+1:2]][31:24]
//            };
//        end
//    end
//endmodule

//module inst_rom_helloworld (
//    input clock,
//    input reset,
//    input [31:0] addr_in,
//    output reg [31:0] data_out
//);
//    parameter ADDR_WIDTH = 5;
//
//    // Declare ROM with parameterized size
//    reg [31:0] rom [0:2**ADDR_WIDTH-1];
//
//    // Load ROM content from external memory file
//    initial begin
//        $readmemh("nbhelloworld.inst_rom.memh", rom);
//    end
//
//    // Fetch instruction with endian correction
//    always @(*) begin
//        if (reset) begin
//            data_out <= 32'h00000000; // Reset output to zero
//        end else begin
//            // Swap endianess
//            data_out <= {
//                rom[addr_in[ADDR_WIDTH+1:2]][7:0],
//                rom[addr_in[ADDR_WIDTH+1:2]][15:8],
//                rom[addr_in[ADDR_WIDTH+1:2]][23:16],
//                rom[addr_in[ADDR_WIDTH+1:2]][31:24]
//            };
//        end
//    end
//endmodule

module inst_rom_helloworld(

	input clock,
    input reset,
    input [31:0] addr_in,
    output reg [31:0] data_out 

);
   
	 parameter ADDR_WIDTH = 5;
    parameter MEMORY_FILE = "nbhelloworld.inst_rom.memh";
    parameter DEFAULT_VALUE = 32'h00000000;
	 
    // ROM memory declaration
    reg [31:0] rom [0:2**ADDR_WIDTH-1];
    integer i;
    
    // Initialize ROM from file or with default values
    initial begin
        // First, initialize all locations with default value
        for (i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
            rom[i] = DEFAULT_VALUE;
        end
        
        // Then try to load from memory file
        if (MEMORY_FILE != "") begin
            $readmemh(MEMORY_FILE, rom);
            $display("ROM initialized from file: %s", MEMORY_FILE);
        end else begin
            $display("ROM initialized with default values");
        end
    end
    
    // Fetch instruction with endian correction
    always @(*) begin
        if (reset) begin
            data_out <= 32'h00000000;
        end else begin
            // Endian swapping for SPIM compatibility
            data_out <= {
                rom[addr_in[ADDR_WIDTH+1:2]][7:0], 
                rom[addr_in[ADDR_WIDTH+1:2]][15:8], 
                rom[addr_in[ADDR_WIDTH+1:2]][23:16], 
                rom[addr_in[ADDR_WIDTH+1:2]][31:24]
            };
        end
    end
    
endmodule
