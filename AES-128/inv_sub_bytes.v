`timescale 1ns / 1ns

// Module to perform the inverse SubBytes operation on a 128-bit input.
module INV_SUB_BYTES(
    input clk,
    input [127:0] IN_DATA,
    output [127:0] INV_SB_DATA_OUT  
);

    reg [127:0] INV_SB_DATA_REG;  
    wire [127:0] INV_SB_DATA_WORD;

    // Apply InvSBox transformation on each byte of the input data.
    INV_SBOX INV_SBOX_INST0(.clk(clk), .IN_DATA(IN_DATA[127:120]), .OUT_DATA(INV_SB_DATA_WORD[127:120]));
    INV_SBOX INV_SBOX_INST1(.clk(clk), .IN_DATA(IN_DATA[119:112]), .OUT_DATA(INV_SB_DATA_WORD[119:112]));
    INV_SBOX INV_SBOX_INST2(.clk(clk), .IN_DATA(IN_DATA[111:104]), .OUT_DATA(INV_SB_DATA_WORD[111:104]));
    INV_SBOX INV_SBOX_INST3(.clk(clk), .IN_DATA(IN_DATA[103:96]), .OUT_DATA(INV_SB_DATA_WORD[103:96]));

    INV_SBOX INV_SBOX_INST4(.clk(clk), .IN_DATA(IN_DATA[95:88]), .OUT_DATA(INV_SB_DATA_WORD[95:88]));
    INV_SBOX INV_SBOX_INST5(.clk(clk), .IN_DATA(IN_DATA[87:80]), .OUT_DATA(INV_SB_DATA_WORD[87:80]));
    INV_SBOX INV_SBOX_INST6(.clk(clk), .IN_DATA(IN_DATA[79:72]), .OUT_DATA(INV_SB_DATA_WORD[79:72]));
    INV_SBOX INV_SBOX_INST7(.clk(clk), .IN_DATA(IN_DATA[71:64]), .OUT_DATA(INV_SB_DATA_WORD[71:64]));

    INV_SBOX INV_SBOX_INST8(.clk(clk), .IN_DATA(IN_DATA[63:56]), .OUT_DATA(INV_SB_DATA_WORD[63:56]));
    INV_SBOX INV_SBOX_INST9(.clk(clk), .IN_DATA(IN_DATA[55:48]), .OUT_DATA(INV_SB_DATA_WORD[55:48]));
    INV_SBOX INV_SBOX_INST10(.clk(clk), .IN_DATA(IN_DATA[47:40]), .OUT_DATA(INV_SB_DATA_WORD[47:40]));
    INV_SBOX INV_SBOX_INST11(.clk(clk), .IN_DATA(IN_DATA[39:32]), .OUT_DATA(INV_SB_DATA_WORD[39:32]));

    INV_SBOX INV_SBOX_INST12(.clk(clk), .IN_DATA(IN_DATA[31:24]), .OUT_DATA(INV_SB_DATA_WORD[31:24]));
    INV_SBOX INV_SBOX_INST13(.clk(clk), .IN_DATA(IN_DATA[23:16]), .OUT_DATA(INV_SB_DATA_WORD[23:16]));
    INV_SBOX INV_SBOX_INST14(.clk(clk), .IN_DATA(IN_DATA[15:8]), .OUT_DATA(INV_SB_DATA_WORD[15:8]));
    INV_SBOX INV_SBOX_INST15(.clk(clk), .IN_DATA(IN_DATA[7:0]), .OUT_DATA(INV_SB_DATA_WORD[7:0]));

    // Register the transformed output for stable output data.
    always @(*) begin
        INV_SB_DATA_REG <= INV_SB_DATA_WORD;  
    end

    // Assign registered output.
    assign INV_SB_DATA_OUT = INV_SB_DATA_REG;  

endmodule
