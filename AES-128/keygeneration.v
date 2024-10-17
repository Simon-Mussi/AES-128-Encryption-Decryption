// Module for AES key expansion, managing key transformation for each round.
module KEYGENERATION(
    input clk, 
    input [3:0] ROUND_KEY,         // Current round number (0-9 for AES-128)
    input [127:0] IN_KEY,          // Input key for the round
    output [127:0] OUT_KEY,        // Output generated key for the next round
    output reg [127:0] OUT_KEY_R   // Registered output for synchronization
);

    // Internal signals for the four 32-bit words of the input key.
    wire [31:0] KEY0, KEY1, KEY2, KEY3;
    wire [31:0] SUBWORD_OUT;                 // SubWord output after S-Box transformation

    // Split the input 128-bit key into four 32-bit segments.
    assign KEY3 = IN_KEY[127:96];
    assign KEY2 = IN_KEY[95:64];
    assign KEY1 = IN_KEY[63:32];
    assign KEY0 = IN_KEY[31:0];

    // Generate the new 128-bit key by XORing the transformed words and round constants.
    assign OUT_KEY[127:96] = KEY3 ^ SUBWORD_OUT ^ RCON(ROUND_KEY);
    assign OUT_KEY[95:64] = OUT_KEY[127:96] ^ KEY2;
    assign OUT_KEY[63:32] = OUT_KEY[95:64] ^ KEY1;
    assign OUT_KEY[31:0] = OUT_KEY[63:32] ^ KEY0;

    // SBox instances for SubWord transformation
    SBOX SBOX_INST0(.clk(clk), .IN_DATA(KEY0[23:16]), .OUT_DATA(SUBWORD_OUT[31:24]));
    SBOX SBOX_INST1(.clk(clk), .IN_DATA(KEY0[15:8]), .OUT_DATA(SUBWORD_OUT[23:16]));
    SBOX SBOX_INST2(.clk(clk), .IN_DATA(KEY0[7:0]), .OUT_DATA(SUBWORD_OUT[15:8]));
    SBOX SBOX_INST3(.clk(clk), .IN_DATA(KEY0[31:24]), .OUT_DATA(SUBWORD_OUT[7:0]));
    
    // Store the output key in a register for timing control
    always @ (posedge clk) 
        OUT_KEY_R <= OUT_KEY;

    // Function to provide the round constants (RCON) for each round.
    function [31:0] RCON;
        input [3:0] ROUND_KEY;
        begin
            case (ROUND_KEY)
                4'h0: RCON = 32'h01_00_00_00;
                4'h1: RCON = 32'h02_00_00_00;
                4'h2: RCON = 32'h04_00_00_00;
                4'h3: RCON = 32'h08_00_00_00;
                4'h4: RCON = 32'h10_00_00_00;
                4'h5: RCON = 32'h20_00_00_00;
                4'h6: RCON = 32'h40_00_00_00;
                4'h7: RCON = 32'h80_00_00_00;
                4'h8: RCON = 32'h1b_00_00_00;
                4'h9: RCON = 32'h36_00_00_00;
                default: RCON = 32'h00_00_00_00;
            endcase
        end
    endfunction
endmodule