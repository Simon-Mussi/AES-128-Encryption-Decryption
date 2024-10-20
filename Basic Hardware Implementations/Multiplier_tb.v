`timescale 1ns / 1ns

module Multiplier_tb;

    // Declare inputs as reg type
    reg [3:0] A;
    reg [3:0] B;

    // Declare output as wire type
    wire [7:0] Product;

    // Instantiate the Multiplier module
    Multiplier uut (
        .A(A),
        .B(B),
        .Product(Product)
    );

    initial begin
        // Set up the VCD (Value Change Dump) file for waveform viewing
        $dumpfile("multiplier_tb_output.vcd");
        $dumpvars(0, Multiplier_tb);

        // Test cases
        A = 4'b0000; B = 4'b0000; #10; // 0 * 0 = 0
        A = 4'b0001; B = 4'b0010; #10; // 1 * 2 = 2
        A = 4'b0011; B = 4'b0101; #10; // 3 * 5 = 15
        A = 4'b0111; B = 4'b0011; #10; // 7 * 3 = 21
        A = 4'b1111; B = 4'b1111; #10; // 15 * 15 = 225
        A = 4'b1001; B = 4'b0110; #10; // 9 * 6 = 54

        // End the simulation
        $finish;
    end

endmodule
