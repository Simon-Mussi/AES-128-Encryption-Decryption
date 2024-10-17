`timescale 1ns / 1ps
module INV_SHIFT_ROWS(
    input clk,
    input [127:0] IN_DATA,
    output [127:0] INV_SHIFT_DATA
);
    // Extract bytes from the input state.
    wire [7:0] b0 = IN_DATA[127:120];
    wire [7:0] b1 = IN_DATA[119:112];
    wire [7:0] b2 = IN_DATA[111:104];
    wire [7:0] b3 = IN_DATA[103:96];
    wire [7:0] b4 = IN_DATA[95:88];
    wire [7:0] b5 = IN_DATA[87:80];
    wire [7:0] b6 = IN_DATA[79:72];
    wire [7:0] b7 = IN_DATA[71:64];
    wire [7:0] b8 = IN_DATA[63:56];
    wire [7:0] b9 = IN_DATA[55:48];
    wire [7:0] b10 = IN_DATA[47:40];
    wire [7:0] b11 = IN_DATA[39:32];
    wire [7:0] b12 = IN_DATA[31:24];
    wire [7:0] b13 = IN_DATA[23:16];
    wire [7:0] b14 = IN_DATA[15:8];
    wire [7:0] b15 = IN_DATA[7:0];

    // Perform the inverse shift rows operation.
    assign INV_SHIFT_DATA[127:120] = b0;
    assign INV_SHIFT_DATA[119:112] = b13;
    assign INV_SHIFT_DATA[111:104] = b10;
    assign INV_SHIFT_DATA[103:96]  = b7;

    assign INV_SHIFT_DATA[95:88]   = b4;
    assign INV_SHIFT_DATA[87:80]   = b1;
    assign INV_SHIFT_DATA[79:72]   = b14;
    assign INV_SHIFT_DATA[71:64]   = b11;

    assign INV_SHIFT_DATA[63:56]   = b8;
    assign INV_SHIFT_DATA[55:48]   = b5;
    assign INV_SHIFT_DATA[47:40]   = b2;
    assign INV_SHIFT_DATA[39:32]   = b15;

    assign INV_SHIFT_DATA[31:24]   = b12;
    assign INV_SHIFT_DATA[23:16]   = b9;
    assign INV_SHIFT_DATA[15:8]    = b6;
    assign INV_SHIFT_DATA[7:0]     = b3;

endmodule
