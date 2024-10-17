`timescale 1ns / 1ps

module aes_128_decrypt_tb;

    reg clk;
    reg reset;
    reg [127:0] INPUT_DATA;
    reg [127:0] INPUT_KEY;
    wire [127:0] OUTPUT_DATA;

    // Instantiate the AES-128 decryption module.
    AES_128_DECRYPT uut (
        .clk(clk),
        .reset(reset),
        .INPUT_DATA(INPUT_DATA),
        .INPUT_KEY(INPUT_KEY),
        .OUTPUT_DATA(OUTPUT_DATA)
    );

    // Generate the clock signal.
    always #5 clk = ~clk;

    initial begin
        // Initialize the inputs.
        clk = 0;
        reset = 1;
        INPUT_DATA = 128'h69c4e0d86a7b0430d8cdb78070b4c55a; // Example ciphertext.
        INPUT_KEY = 128'h000102030405060708090a0b0c0d0e0f; // Example key.

        // Release reset after some time.
        #40 reset = 0;

        // Wait for the decryption process to complete.
        #1000;

        // Display all round keys.
        $display("Round keys:");
        $display("Key 9:  %h", uut.ROUND_KEYS[9]);
        $display("Key 8:  %h", uut.ROUND_KEYS[8]);
        $display("Key 7:  %h", uut.ROUND_KEYS[7]);
        $display("Key 6:  %h", uut.ROUND_KEYS[6]);
        $display("Key 5:  %h", uut.ROUND_KEYS[5]);
        $display("Key 4:  %h", uut.ROUND_KEYS[4]);
        $display("Key 3:  %h", uut.ROUND_KEYS[3]);
        $display("Key 2:  %h", uut.ROUND_KEYS[2]);
        $display("Key 1:  %h", uut.ROUND_KEYS[1]);
        $display("Key 0:  %h", uut.ROUND_KEYS[0]);

        // Display the final decrypted output.
        $display();
        $display("Input Data: %h", INPUT_DATA);
        $display("Input Key: %h", INPUT_KEY);
        $display("Decrypted output: %h", OUTPUT_DATA);

        // End simulation.
        $finish;
    end

endmodule
