module sign_extender (
    input [15:0] in,         // 16-bit input
    output [31:0] out        // 32-bit output
);

    assign out = {{16{in[15]}}, in};  // Replicate the sign bit to extend
endmodule
