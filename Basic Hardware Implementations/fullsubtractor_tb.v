`timescale 1ns / 1ns

module FullSubtractor_tb;

    // Declare inputs as reg type
    reg A;
    reg B;
    reg Bin;

    // Declare outputs as wire type
    wire D;
    wire Bout;

    // Instantiate the FullSubtractor module
    FullSubtractor uut (
        .A(A), 
        .B(B), 
        .Bin(Bin), 
        .D(D), 
        .Bout(Bout)
    );

    initial begin
        // Set up the VCD (Value Change Dump) file for waveform viewing
        $dumpfile("fullsubtractor_tb_output.vcd");
        $dumpvars(0, FullSubtractor_tb);
        
        // Initialize inputs
        A = 0; B = 0; Bin = 0;
        #10; // Wait for 10 time units

        A = 0; B = 0; Bin = 1;
        #10;

        A = 0; B = 1; Bin = 0;
        #10;

        A = 0; B = 1; Bin = 1;
        #10;

        A = 1; B = 0; Bin = 0;
        #10;

        A = 1; B = 0; Bin = 1;
        #10;

        A = 1; B = 1; Bin = 0;
        #10;

        A = 1; B = 1; Bin = 1;
        #10;

        // End the simulation
        $finish;
    end

endmodule
