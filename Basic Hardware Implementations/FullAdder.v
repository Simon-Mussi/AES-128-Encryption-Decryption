module FullAdder (
    input a,     // Input bit a
    input b,     // Input bit b
    input cin,   // Carry-in
    output sum,  // Sum output
    output cout  // Carry-out
);
    // The sum and carry-out logic
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin)  | (cin & a) ;
endmodule
