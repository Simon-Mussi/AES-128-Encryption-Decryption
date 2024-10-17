// Module for a single iteration of an AES decryption round (excluding the first round).
module AES_DECRYPTION_ROUND(
    input clk, 
    input [127:0] IN_DATA,       // Data block input
    input [127:0] IN_KEY,        // Key input for this round
    output reg [127:0] OUT_DATA  // Data block output after round operations
);

// Wires for intermediate results of the AES decryption round.
wire [127:0] IN_DATA_KEY, INV_SB_DATA, INV_SHIFT_DATA, INV_MIXED_DATA;

// Combine the mixed data with the round key to produce the final output.

assign IN_DATA_KEY = IN_KEY ^ IN_DATA;

// Apply the InvSubBytes, InvShiftRows, and InvMixColumns transformations.
INV_MIX_COLUMNS INV_MC(.clk(clk), .IN_DATA(IN_DATA_KEY), .INV_MIXED_DATA(INV_MIXED_DATA));
INV_SHIFT_ROWS INV_SR(.clk(clk), .IN_DATA(INV_MIXED_DATA), .INV_SHIFT_DATA(INV_SHIFT_DATA));
INV_SUB_BYTES INV_SB(.clk(clk), .IN_DATA(INV_SHIFT_DATA), .INV_SB_DATA_OUT(INV_SB_DATA));

always @(posedge clk) begin
    OUT_DATA <= INV_SB_DATA;
    /*$display("Input Data: %h", IN_DATA);
    $display("Input Key: %h", IN_KEY);
    $display("Input Data Key: %h", IN_KEY);
    $display("After InvShiftRows: %h", INV_SHIFT_DATA);
    $display("After InvSubBytes: %h", INV_SB_DATA);
    $display("Final Output: %h", OUT_DATA);*/
end

endmodule