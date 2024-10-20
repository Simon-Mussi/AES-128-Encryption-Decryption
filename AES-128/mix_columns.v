`timescale 1ns / 1ns

// MixColumns transformation module: mixes columns of the state matrix.
module MIX_COLUMNS(
    input clk,
    input [127:0] IN_DATA,
    output reg [127:0] MIXED_DATA
);

    // Galois field multiplication by 2
    function [7:0] gm2;
        input [7:0] b;
        begin
            gm2 = (b << 1);
            if (b[7]) gm2 = gm2 ^ 8'h1b; // If the most significant bit was set, reduce by 0x1b.
        end
    endfunction

    // Galois field multiplication by 3
    function [7:0] gm3;
        input [7:0] b;
        begin
            gm3 = gm2(b) ^ b;  // Multiplication by 3 is gm2(b) XOR b
        end
    endfunction

    always @(posedge clk) begin
        // First column
        MIXED_DATA[127:120] <= gm2(IN_DATA[127:120]) ^ gm3(IN_DATA[119:112]) ^ IN_DATA[111:104] ^ IN_DATA[103:96];
        MIXED_DATA[119:112] <= IN_DATA[127:120] ^ gm2(IN_DATA[119:112]) ^ gm3(IN_DATA[111:104]) ^ IN_DATA[103:96];
        MIXED_DATA[111:104] <= IN_DATA[127:120] ^ IN_DATA[119:112] ^ gm2(IN_DATA[111:104]) ^ gm3(IN_DATA[103:96]);
        MIXED_DATA[103:96]  <= gm3(IN_DATA[127:120]) ^ IN_DATA[119:112] ^ IN_DATA[111:104] ^ gm2(IN_DATA[103:96]);

        // Second column
        MIXED_DATA[95:88]   <= gm2(IN_DATA[95:88]) ^ gm3(IN_DATA[87:80]) ^ IN_DATA[79:72] ^ IN_DATA[71:64];
        MIXED_DATA[87:80]   <= IN_DATA[95:88] ^ gm2(IN_DATA[87:80]) ^ gm3(IN_DATA[79:72]) ^ IN_DATA[71:64];
        MIXED_DATA[79:72]   <= IN_DATA[95:88] ^ IN_DATA[87:80] ^ gm2(IN_DATA[79:72]) ^ gm3(IN_DATA[71:64]);
        MIXED_DATA[71:64]   <= gm3(IN_DATA[95:88]) ^ IN_DATA[87:80] ^ IN_DATA[79:72] ^ gm2(IN_DATA[71:64]);

        // Third column
        MIXED_DATA[63:56]   <= gm2(IN_DATA[63:56]) ^ gm3(IN_DATA[55:48]) ^ IN_DATA[47:40] ^ IN_DATA[39:32];
        MIXED_DATA[55:48]   <= IN_DATA[63:56] ^ gm2(IN_DATA[55:48]) ^ gm3(IN_DATA[47:40]) ^ IN_DATA[39:32];
        MIXED_DATA[47:40]   <= IN_DATA[63:56] ^ IN_DATA[55:48] ^ gm2(IN_DATA[47:40]) ^ gm3(IN_DATA[39:32]);
        MIXED_DATA[39:32]   <= gm3(IN_DATA[63:56]) ^ IN_DATA[55:48] ^ IN_DATA[47:40] ^ gm2(IN_DATA[39:32]);

        // Fourth column
        MIXED_DATA[31:24]   <= gm2(IN_DATA[31:24]) ^ gm3(IN_DATA[23:16]) ^ IN_DATA[15:8] ^ IN_DATA[7:0];
        MIXED_DATA[23:16]   <= IN_DATA[31:24] ^ gm2(IN_DATA[23:16]) ^ gm3(IN_DATA[15:8]) ^ IN_DATA[7:0];
        MIXED_DATA[15:8]    <= IN_DATA[31:24] ^ IN_DATA[23:16] ^ gm2(IN_DATA[15:8]) ^ gm3(IN_DATA[7:0]);
        MIXED_DATA[7:0]     <= gm3(IN_DATA[31:24]) ^ IN_DATA[23:16] ^ IN_DATA[15:8] ^ gm2(IN_DATA[7:0]);
    end
endmodule
