module mux2 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0,    // First input
    input [WIDTH-1:0] in1,    // Second input
    input select,                 // Select signal
    output [WIDTH-1:0] out     // MUX output
);

    assign out = (select) ? in1 : in0;  // Select the output based on sel
endmodule
