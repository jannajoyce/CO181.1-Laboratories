module inst_rom_lab7test (
    input clock,
    input reset,
    input [31:0] addr_in,
    output reg [31:0] data_out
);
    parameter ADDR_WIDTH = 10;

    // Declare ROM with hardcoded instructions
    reg [31:0] rom [0:2**ADDR_WIDTH-1];
    integer i; // Declare loop variable

    // Initialize ROM with hardcoded values
    initial begin
        rom[0]  = 32'h00400a20;
        rom[1]  = 32'h20504a01;
        rom[2]  = 32'h20504a01;
        rom[3]  = 32'h20504a01;
        rom[4]  = 32'h20504a01;
        rom[5]  = 32'h20504a01;
        rom[6]  = 32'h20504a01;
        rom[7]  = 32'h20504a01;
        rom[8]  = 32'h20504a01;
        rom[9]  = 32'h20504a01;
        rom[10] = 32'h20504a01;
        rom[11] = 32'h20504a01;
        rom[12] = 32'h20504a01;
        rom[13] = 32'h20504a01;
        rom[14] = 32'h20504a01;
        rom[15] = 32'h01000b20;
        rom[16] = 32'h00004bad;
        rom[17] = 32'h20586b01;
        rom[18] = 32'h04004bad;
        rom[19] = 32'h20586b01;
        rom[20] = 32'h08004bad;
        rom[21] = 32'h20586b01;
        rom[22] = 32'h0c004bad;
        rom[23] = 32'h20586b01;
        rom[24] = 32'h10004bad;
        rom[25] = 32'h20586b01;
        rom[26] = 32'h14004bad;
        rom[27] = 32'h20586b01;
      
        // Add remaining machine codes similarly
		  for (i = 28; i < 2**ADDR_WIDTH; i = i + 1) begin
            rom[i] = 32'h00000000;
        end
    end


    // Fetch instruction with endian correction
    always @(*) begin
        if (reset) begin
            data_out <= 32'h00000000; // Reset output to zero
        end else begin
            // Correct endian swapping to match SPIM's expected order
            data_out <= {
                rom[addr_in[ADDR_WIDTH+1:2]][7:0], 
                rom[addr_in[ADDR_WIDTH+1:2]][15:8], 
                rom[addr_in[ADDR_WIDTH+1:2]][23:16], 
                rom[addr_in[ADDR_WIDTH+1:2]][31:24]
            };
        end
    end
endmodule