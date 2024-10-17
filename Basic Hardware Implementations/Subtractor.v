module Subtractor (
    input [3:0] A,    // 4-bit input A
    input [3:0] B,    // 4-bit input B
    output [3:0] Diff, // Difference
    output Cout       // Borrow-out
);
    // Negate B by taking two's complement (invert and add 1)
    wire [3:0] B_neg = ~B + 1;

    // Instantiate adder to perform A + (-B)
    RippleCarryAdder RCA (.A(A), .B(B_neg), .Cin(1'b0), .Sum(Diff), .Cout(Cout));

endmodule
