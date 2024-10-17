// Module for the inverse MixColumns operation on a 128-bit input.
`timescale 1ns / 1ps
module INV_MIX_COLUMNS(
    input clk,
    input [127:0] IN_DATA,
    output reg [127:0] INV_MIXED_DATA
);

    function [7:0] gm2;
        input [7:0] b;
        begin
            gm2 = (b << 1);
            if (b[7]) gm2 = gm2 ^ 8'h1b; // If the most significant bit was set, reduce by 0x1b.
        end
    endfunction

    function [7:0] gm3;
        input [7:0] b;
        begin
            gm3 = gm2(b) ^ b; // Multiplication by 3 is the same as multiplying by 2 and then adding b.
        end
    endfunction

    function [7:0] gm4;
        input [7:0] b;
        begin
            gm4 = gm2(gm2(b)); // Multiply by 4 by multiplying by 2 twice.
        end
    endfunction

    function [7:0] gm8;
        input [7:0] b;
        begin
            gm8 = gm2(gm4(b)); // Multiply by 8 by multiplying by 4 and then by 2.
        end
    endfunction

    function [7:0] gm09;
        input [7:0] b;
        begin
            gm09 = gm8(b) ^ b; // Multiply by 9 by multiplying by 8 and then adding b.
        end
    endfunction

    function [7:0] gm11;
        input [7:0] b;
        begin
            gm11 = gm8(b) ^ gm2(b) ^ b; // Multiply by 11 by combining results of 8, 2, and b.
        end
    endfunction

    function [7:0] gm13;
        input [7:0] b;
        begin
            gm13 = gm8(b) ^ gm4(b) ^ b; // Multiply by 13 by combining results of 8, 4, and b.
        end
    endfunction

    function [7:0] gm14;
        input [7:0] b;
        begin
            gm14 = gm8(b) ^ gm4(b) ^ gm2(b); // Multiply by 14 by combining results of 8, 4, and 2.
        end
    endfunction


    // Perform the InvMixColumns operation for each column of the state
    always @(posedge clk) begin
        INV_MIXED_DATA[127:120] <= gm14(IN_DATA[127:120]) ^ gm11(IN_DATA[119:112]) ^ gm13(IN_DATA[111:104]) ^ gm09(IN_DATA[103:96]);
        INV_MIXED_DATA[119:112] <= gm09(IN_DATA[127:120]) ^ gm14(IN_DATA[119:112]) ^ gm11(IN_DATA[111:104]) ^ gm13(IN_DATA[103:96]);
        INV_MIXED_DATA[111:104] <= gm13(IN_DATA[127:120]) ^ gm09(IN_DATA[119:112]) ^ gm14(IN_DATA[111:104]) ^ gm11(IN_DATA[103:96]);
        INV_MIXED_DATA[103:96]  <= gm11(IN_DATA[127:120]) ^ gm13(IN_DATA[119:112]) ^ gm09(IN_DATA[111:104]) ^ gm14(IN_DATA[103:96]);
    
        INV_MIXED_DATA[95:88]  <= gm14(IN_DATA[95:88]) ^ gm11(IN_DATA[87:80]) ^ gm13(IN_DATA[79:72]) ^ gm09(IN_DATA[71:64]);
        INV_MIXED_DATA[87:80]  <= gm09(IN_DATA[95:88]) ^ gm14(IN_DATA[87:80]) ^ gm11(IN_DATA[79:72]) ^ gm13(IN_DATA[71:64]);
        INV_MIXED_DATA[79:72]  <= gm13(IN_DATA[95:88]) ^ gm09(IN_DATA[87:80]) ^ gm14(IN_DATA[79:72]) ^ gm11(IN_DATA[71:64]);
        INV_MIXED_DATA[71:64]  <= gm11(IN_DATA[95:88]) ^ gm13(IN_DATA[87:80]) ^ gm09(IN_DATA[79:72]) ^ gm14(IN_DATA[71:64]);
    
        INV_MIXED_DATA[63:56]  <= gm14(IN_DATA[63:56]) ^ gm11(IN_DATA[55:48]) ^ gm13(IN_DATA[47:40]) ^ gm09(IN_DATA[39:32]);
        INV_MIXED_DATA[55:48]  <= gm09(IN_DATA[63:56]) ^ gm14(IN_DATA[55:48]) ^ gm11(IN_DATA[47:40]) ^ gm13(IN_DATA[39:32]);
        INV_MIXED_DATA[47:40]  <= gm13(IN_DATA[63:56]) ^ gm09(IN_DATA[55:48]) ^ gm14(IN_DATA[47:40]) ^ gm11(IN_DATA[39:32]);
        INV_MIXED_DATA[39:32]  <= gm11(IN_DATA[63:56]) ^ gm13(IN_DATA[55:48]) ^ gm09(IN_DATA[47:40]) ^ gm14(IN_DATA[39:32]);
    
        INV_MIXED_DATA[31:24]  <= gm14(IN_DATA[31:24]) ^ gm11(IN_DATA[23:16]) ^ gm13(IN_DATA[15:8]) ^ gm09(IN_DATA[7:0]);
        INV_MIXED_DATA[23:16]  <= gm09(IN_DATA[31:24]) ^ gm14(IN_DATA[23:16]) ^ gm11(IN_DATA[15:8]) ^ gm13(IN_DATA[7:0]);
        INV_MIXED_DATA[15:8]   <= gm13(IN_DATA[31:24]) ^ gm09(IN_DATA[23:16]) ^ gm14(IN_DATA[15:8]) ^ gm11(IN_DATA[7:0]);
        INV_MIXED_DATA[7:0]    <= gm11(IN_DATA[31:24]) ^ gm13(IN_DATA[23:16]) ^ gm09(IN_DATA[15:8]) ^ gm14(IN_DATA[7:0]);
    end    
endmodule
