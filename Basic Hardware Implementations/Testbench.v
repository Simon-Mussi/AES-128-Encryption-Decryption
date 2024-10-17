`timescale 1ns/1ns

module Testbench;
    reg [3:0] A, B;
    reg Cin;
    wire [3:0] Sum, Diff;
    wire [7:0] Product;
    wire Cout;

    // Instantiate components
    RippleCarryAdder adder(.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));
    Subtractor subtractor(.A(A), .B(B), .Diff(Diff), .Cout(Cout));
    Multiplier multiplier(.A(A), .B(B), .Product(Product));

    initial begin
        // Initialize inputs
        $dumpfile("tb_out.vcd");
        $dumpvars(0, Testbench);
        
        // Example 1: A = 1010, B = 0101, Cin = 0
        A = 4'b1010; B = 4'b0101; Cin = 1'b0;
        #10;  // Wait for 10 time units

        // Example 2: A = 1101, B = 0011, Cin = 1
        A = 4'b1101; B = 4'b0011; Cin = 1'b1;
        #10;  // Wait for 10 time units
        
        // Example 3: A = 1111, B = 0001, Cin = 0
        A = 4'b1111; B = 4'b0001; Cin = 1'b0;
        #10;  // Wait for 10 time units
        
        // Example 4: A = 0011, B = 1010, Cin = 1
        A = 4'b0011; B = 4'b1010; Cin = 1'b1;
        #10;  // Wait for 10 time units

        // Example 5: A = 0110, B = 1001, Cin = 0
        A = 4'b0110; B = 4'b1001; Cin = 1'b0;
        #10;  // Wait for 10 time units
        
        // Monitor changes
        $monitor("Time = %d : A = %b, B = %b, Sum = %b, Diff = %b, Product = %b", $time, A, B, Sum, Diff, Product);
        
        // Finish the simulation
        #10 $finish;
    end
endmodule
