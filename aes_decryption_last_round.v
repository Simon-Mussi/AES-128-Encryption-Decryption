// Module for the first AES decryption round, which omits the InvMixColumns step.
module AES_DECRYPTION_LAST_ROUND(
    input clk, 
    input [127:0] IN_DATA, 
    input [127:0] IN_KEY, 
    output reg [127:0] OUT_DATA
);

wire [127:0] INV_SB_DATA, INV_SHIFT_DATA;

// Apply InvSubBytes and InvShiftRows transformations.
INV_SHIFT_ROWS INV_SR(.clk(clk), .IN_DATA(IN_DATA), .INV_SHIFT_DATA(INV_SHIFT_DATA));
INV_SUB_BYTES INV_SB(.clk(clk), .IN_DATA(INV_SHIFT_DATA), .INV_SB_DATA_OUT(INV_SB_DATA));

// Combine the shifted data with the round key to generate the final round output.
always @(posedge clk) begin
    OUT_DATA <= INV_SB_DATA;
    /*$display("Input Data: %h", IN_DATA);
    $display("Input Key: %h", IN_KEY);
    $display("After InvShiftRows: %h", INV_SHIFT_DATA);
    $display("After InvSubBytes: %h", INV_SB_DATA);
    $display("Final Output: %h", OUT_DATA);*/
end

endmodule