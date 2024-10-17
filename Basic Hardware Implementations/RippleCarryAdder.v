module RippleCarryAdder (
    input [3:0] A,  // 4-bit input A
    input [3:0] B,  // 4-bit input B
    input Cin,      // Carry-in
    output [3:0] Sum, // 4-bit sum
    output Cout     // Carry-out
);
    wire C1, C2, C3; // Intermediate carry wires

    // Instantiate full adders
    FullAdder FA0 (.a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(C1));
    FullAdder FA1 (.a(A[1]), .b(B[1]), .cin(C1), .sum(Sum[1]), .cout(C2));
    FullAdder FA2 (.a(A[2]), .b(B[2]), .cin(C2), .sum(Sum[2]), .cout(C3));
    FullAdder FA3 (.a(A[3]), .b(B[3]), .cin(C3), .sum(Sum[3]), .cout(Cout));

endmodule
