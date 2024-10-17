`timescale 1ns / 1ns

// Module to perform the SubBytes operation on a 128-bit input.
module SUB_BYTES(
    input clk,
    input [127:0] IN_DATA,
    output [127:0] SB_DATA_OUT  
);

    reg [127:0] SB_DATA_REG;  
    wire [127:0] SB_DATA_WORD;

    // Apply SBox transformation on each byte of the input data.
    SBOX SBOX_INST0(.clk(clk), .IN_DATA(IN_DATA[127:120]), .OUT_DATA(SB_DATA_WORD[127:120]));
    SBOX SBOX_INST1(.clk(clk), .IN_DATA(IN_DATA[119:112]), .OUT_DATA(SB_DATA_WORD[119:112]));
    SBOX SBOX_INST2(.clk(clk), .IN_DATA(IN_DATA[111:104]), .OUT_DATA(SB_DATA_WORD[111:104]));
    SBOX SBOX_INST3(.clk(clk), .IN_DATA(IN_DATA[103:96]), .OUT_DATA(SB_DATA_WORD[103:96]));

    SBOX SBOX_INST4(.clk(clk), .IN_DATA(IN_DATA[95:88]), .OUT_DATA(SB_DATA_WORD[95:88]));
    SBOX SBOX_INST5(.clk(clk), .IN_DATA(IN_DATA[87:80]), .OUT_DATA(SB_DATA_WORD[87:80]));
    SBOX SBOX_INST6(.clk(clk), .IN_DATA(IN_DATA[79:72]), .OUT_DATA(SB_DATA_WORD[79:72]));
    SBOX SBOX_INST7(.clk(clk), .IN_DATA(IN_DATA[71:64]), .OUT_DATA(SB_DATA_WORD[71:64]));

    SBOX SBOX_INST8(.clk(clk), .IN_DATA(IN_DATA[63:56]), .OUT_DATA(SB_DATA_WORD[63:56]));
    SBOX SBOX_INST9(.clk(clk), .IN_DATA(IN_DATA[55:48]), .OUT_DATA(SB_DATA_WORD[55:48]));
    SBOX SBOX_INST10(.clk(clk), .IN_DATA(IN_DATA[47:40]), .OUT_DATA(SB_DATA_WORD[47:40]));
    SBOX SBOX_INST11(.clk(clk), .IN_DATA(IN_DATA[39:32]), .OUT_DATA(SB_DATA_WORD[39:32]));

    SBOX SBOX_INST12(.clk(clk), .IN_DATA(IN_DATA[31:24]), .OUT_DATA(SB_DATA_WORD[31:24]));
    SBOX SBOX_INST13(.clk(clk), .IN_DATA(IN_DATA[23:16]), .OUT_DATA(SB_DATA_WORD[23:16]));
    SBOX SBOX_INST14(.clk(clk), .IN_DATA(IN_DATA[15:8]), .OUT_DATA(SB_DATA_WORD[15:8]));
    SBOX SBOX_INST15(.clk(clk), .IN_DATA(IN_DATA[7:0]), .OUT_DATA(SB_DATA_WORD[7:0]));

    // Register the transformed output for stable output data.
    always @(*) begin
        SB_DATA_REG <= SB_DATA_WORD;  
    end

    // Assign registered output.
    assign SB_DATA_OUT = SB_DATA_REG;  

endmodule