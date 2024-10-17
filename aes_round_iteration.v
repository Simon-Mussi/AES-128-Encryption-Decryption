// Module for a single iteration of an AES round (excluding the last round).
module AES_ROUND_ITERATION(
    input clk, 
    input [127:0] IN_DATA,       // Data block input
    input [127:0] IN_KEY,        // Key input for this round
    output reg [127:0] OUT_DATA  // Data block output after round operations
);

// Wires for intermediate results of the AES round transformations.
wire [127:0] SB_DATA, SHIFT_DATA, MIXED_DATA;

// Apply the SubBytes, ShiftRows, and MixColumns transformations.
SUB_BYTES SB(.clk(clk), .IN_DATA(IN_DATA), .SB_DATA_OUT(SB_DATA));
SHIFT_ROWS SR(.clk(clk), .IN_DATA(SB_DATA), .SHIFT_DATA(SHIFT_DATA));
MIX_COLUMNS MC(.clk(clk), .IN_DATA(SHIFT_DATA), .MIXED_DATA(MIXED_DATA));

// Combine the mixed data with the round key to produce the final output.
always @(posedge clk) begin
    OUT_DATA <= IN_KEY ^ MIXED_DATA;
end

endmodule