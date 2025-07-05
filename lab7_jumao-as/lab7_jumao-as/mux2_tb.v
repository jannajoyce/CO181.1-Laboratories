module mux2_tb();
    reg [31:0] in0, in1;
    reg sel;
    wire [31:0] out;

    mux2 uut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Initialize inputs
        in0 = 32'h12345678; 
        in1 = 32'h87654321;

        // Select in0
        sel = 0;
        #10 $display("Selected in0 (sel=0): Output = %h", out);

        // Select in1
        sel = 1;
        #10 $display("Selected in1 (sel=1): Output = %h", out);

        // Select in0 again
        sel = 0;
        #10 $display("Back to in0 (sel=0): Output = %h", out);

        $finish;
    end
	 
	 initial begin
        $monitor("Time: %0t | sel = %b | in0 = %h | in1 = %h | out = %h", 
                  $time, sel, in0, in1, out);
    end
	 
endmodule