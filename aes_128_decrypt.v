// Top-level AES module for decryption using AES-128.
module AES_128_DECRYPT(
    input clk,
    input reset,
    input [127:0] INPUT_DATA, 
    input [127:0] INPUT_KEY,     
    output [127:0] OUTPUT_DATA  
);

// Combine the input data and key into 128-bit buses.
wire [127:0] IN_DATA = INPUT_DATA;
wire [127:0] IN_KEY = INPUT_KEY;
wire [127:0] OUT_DATA;
assign OUTPUT_DATA = OUT_DATA ^ IN_KEY;

reg [127:0] INITIAL_ROUND_DATA, KEY;
wire [127:0] ROUND_DATA [1:9];   // Data outputs for rounds 1 to 9.
wire [127:0] ROUND_KEYS [0:9];   // Round keys for all 10 rounds, derived from encryption.

// Generate round keys for encryption (these will be used in reverse for decryption).
KEYGENERATION K0(.clk(clk), .ROUND_KEY(4'd0), .IN_KEY(IN_KEY),       .OUT_KEY(ROUND_KEYS[0]));
KEYGENERATION K1(.clk(clk), .ROUND_KEY(4'd1), .IN_KEY(ROUND_KEYS[0]), .OUT_KEY(ROUND_KEYS[1]));
KEYGENERATION K2(.clk(clk), .ROUND_KEY(4'd2), .IN_KEY(ROUND_KEYS[1]), .OUT_KEY(ROUND_KEYS[2]));
KEYGENERATION K3(.clk(clk), .ROUND_KEY(4'd3), .IN_KEY(ROUND_KEYS[2]), .OUT_KEY(ROUND_KEYS[3]));
KEYGENERATION K4(.clk(clk), .ROUND_KEY(4'd4), .IN_KEY(ROUND_KEYS[3]), .OUT_KEY(ROUND_KEYS[4]));
KEYGENERATION K5(.clk(clk), .ROUND_KEY(4'd5), .IN_KEY(ROUND_KEYS[4]), .OUT_KEY(ROUND_KEYS[5]));
KEYGENERATION K6(.clk(clk), .ROUND_KEY(4'd6), .IN_KEY(ROUND_KEYS[5]), .OUT_KEY(ROUND_KEYS[6]));
KEYGENERATION K7(.clk(clk), .ROUND_KEY(4'd7), .IN_KEY(ROUND_KEYS[6]), .OUT_KEY(ROUND_KEYS[7]));
KEYGENERATION K8(.clk(clk), .ROUND_KEY(4'd8), .IN_KEY(ROUND_KEYS[7]), .OUT_KEY(ROUND_KEYS[8]));
KEYGENERATION K9(.clk(clk), .ROUND_KEY(4'd9), .IN_KEY(ROUND_KEYS[8]), .OUT_KEY(ROUND_KEYS[9]));

// Initial round key addition: XOR with the last encryption round key.
always @(posedge clk or posedge reset) begin
    if (reset) begin
        INITIAL_ROUND_DATA <= 0;
    end else begin
        INITIAL_ROUND_DATA <= IN_DATA ^ ROUND_KEYS[9];  // XOR input with the last round key.
    end
end

// Last round for decryption (no MixColumns).
AES_DECRYPTION_LAST_ROUND R10(.clk(clk), .IN_DATA(INITIAL_ROUND_DATA), .IN_KEY(ROUND_KEYS[9]), .OUT_DATA(ROUND_DATA[9]));

// Remaining decryption rounds, applying the round keys in reverse order.
AES_DECRYPTION_ROUND R9(.clk(clk), .IN_DATA(ROUND_DATA[9]), .IN_KEY(ROUND_KEYS[8]), .OUT_DATA(ROUND_DATA[8]));
AES_DECRYPTION_ROUND R8(.clk(clk), .IN_DATA(ROUND_DATA[8]), .IN_KEY(ROUND_KEYS[7]), .OUT_DATA(ROUND_DATA[7]));
AES_DECRYPTION_ROUND R7(.clk(clk), .IN_DATA(ROUND_DATA[7]), .IN_KEY(ROUND_KEYS[6]), .OUT_DATA(ROUND_DATA[6]));
AES_DECRYPTION_ROUND R6(.clk(clk), .IN_DATA(ROUND_DATA[6]), .IN_KEY(ROUND_KEYS[5]), .OUT_DATA(ROUND_DATA[5]));
AES_DECRYPTION_ROUND R5(.clk(clk), .IN_DATA(ROUND_DATA[5]), .IN_KEY(ROUND_KEYS[4]), .OUT_DATA(ROUND_DATA[4]));
AES_DECRYPTION_ROUND R4(.clk(clk), .IN_DATA(ROUND_DATA[4]), .IN_KEY(ROUND_KEYS[3]), .OUT_DATA(ROUND_DATA[3]));
AES_DECRYPTION_ROUND R3(.clk(clk), .IN_DATA(ROUND_DATA[3]), .IN_KEY(ROUND_KEYS[2]), .OUT_DATA(ROUND_DATA[2]));
AES_DECRYPTION_ROUND R2(.clk(clk), .IN_DATA(ROUND_DATA[2]), .IN_KEY(ROUND_KEYS[1]), .OUT_DATA(ROUND_DATA[1]));
AES_DECRYPTION_ROUND R1(.clk(clk), .IN_DATA(ROUND_DATA[1]), .IN_KEY(ROUND_KEYS[0]), .OUT_DATA(OUT_DATA));

endmodule
