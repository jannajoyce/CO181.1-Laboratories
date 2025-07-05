module program_counter (
    input clock,
    input reset,
    input [31:0] pc_in,    // External PC input (optional)
    output reg [31:0] pc_out // Program counter output
);
		
    always @(posedge clock or posedge reset) begin
    if (reset)
        pc_out <= 32'h003FFFFC;
    else
        pc_out <= pc_out + 4;
end

endmodule