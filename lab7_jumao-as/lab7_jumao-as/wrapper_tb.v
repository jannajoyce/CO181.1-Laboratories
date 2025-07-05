`timescale 1ns / 1ps

module wrapper_tb;

    // Testbench signals
    reg [9:0] SW;    // Switch inputs
    reg [3:0] KEY;   // Key inputs
    wire [6:0] hex_display0, hex_display1, hex_display2, hex_display3, hex_display4, hex_display5;
 
    wire [32:0] outputmod;
    // Instantiate the wrapper module
    wrapper uut (
        .SW(SW),
        .KEY(KEY),
        .hex_display0(hex_display0),
        .hex_display1(hex_display1),
        .hex_display2(hex_display2),
        .hex_display3(hex_display3),
        .hex_display4(hex_display4),
        .hex_display5(hex_display5),
		  .modedf(outputmod)
    );

    // Clock and reset initialization
    initial begin
        KEY[0] = 0;  // Initialize clock signal
        KEY[1] = 1;  // Set reset active
        SW = 10'b0;  // Initialize switch inputs
        #10;         // Wait 10 ns
        KEY[1] = 0;  // Release reset
    end

    // Generate clock signal
    always begin
        #5 KEY[0] = ~KEY[0];  // Toggle clock every 5 ns
    end

    // Test case
    initial begin
        forever begin
            @(posedge KEY[0]);
            $monitor("Time: %0t | Clock: %b | Reset: %b | SW: %b | HEX Displays: %b %b %b %b %b %b | Final: %h", 
                     $time, KEY[0], KEY[1], SW, hex_display5, hex_display4, hex_display3, hex_display2, hex_display1, hex_display0,outputmod);
        end
    end

    // Test case setup
    initial begin
        // Test case 1: Apply inputs
        #20 SW = 10'b0000000011; // Apply some test input
        //#40 SW = 10'b0000011111; // Apply another test input
        //#40 SW = 10'b1111111111; // Apply max test input

        // Add more test cases as needed

        // End simulation
        #100 $stop;
    end

endmodule