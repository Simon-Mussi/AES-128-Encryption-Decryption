module Multiplier (
    input [3:0] A,  // 4-bit input A
    input [3:0] B,  // 4-bit input B
    output [7:0] Product // 8-bit product
);
    wire [7:0] P;

    assign P = A * B;

    assign Product = P;
endmodule
