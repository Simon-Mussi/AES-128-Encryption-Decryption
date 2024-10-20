`timescale 1ns / 1ns

module FullAdder_tb;

    // Declare inputs as reg type
    reg a;
    reg b;
    reg cin;

    // Declare outputs as wire type
    wire sum;
    wire cout;

    // Instantiate the FullAdder module
    FullAdder uut (
        .a(a), 
        .b(b), 
        .cin(cin), 
        .sum(sum), 
        .cout(cout)
    );

    initial begin
        // Set up the VCD (Value Change Dump) file for waveform viewing
        $dumpfile("fulladder_tb_output.vcd");
        $dumpvars(0, FullAdder_tb);
        
        // Initialize inputs
        a = 0; b = 0; cin = 0;
        #10; // Wait for 10 time units

        a = 0; b = 0; cin = 1;
        #10;

        a = 0; b = 1; cin = 0;
        #10;

        a = 0; b = 1; cin = 1;
        #10;

        a = 1; b = 0; cin = 0;
        #10;

        a = 1; b = 0; cin = 1;
        #10;

        a = 1; b = 1; cin = 0;
        #10;

        a = 1; b = 1; cin = 1;
        #10;

        // End the simulation
        $finish;
    end

endmodule
