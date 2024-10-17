// Module for the last AES round, which omits the MixColumns step.
module AES_LAST_ROUND(
    input clk, 
    input [127:0] IN_DATA, 
    input [127:0] IN_KEY, 
    output reg [127:0] OUT_DATA
);

wire [127:0] SB_DATA, SHIFT_DATA;

// Apply SubBytes and ShiftRows transformations.
SUB_BYTES SB(.clk(clk), .IN_DATA(IN_DATA), .SB_DATA_OUT(SB_DATA));
SHIFT_ROWS SR(.clk(clk), .IN_DATA(SB_DATA), .SHIFT_DATA(SHIFT_DATA));

// Combine the shifted data with the round key to generate the final round output.
always @(posedge clk) begin
    OUT_DATA <= IN_KEY ^ SHIFT_DATA;
end

endmodule