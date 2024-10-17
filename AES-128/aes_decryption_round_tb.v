`timescale 1ns / 1ns

module aes_decryption_round_tb;

    // Inputs
    reg clk;
    reg [127:0] IN_DATA;
    reg [127:0] IN_KEY;

    // Output
    wire [127:0] OUT_DATA;

    // Instantiate the AES_DECRYPTION_ROUND module
    AES_DECRYPTION_ROUND uut (
        .clk(clk),
        .IN_DATA(IN_DATA),
        .IN_KEY(IN_KEY),
        .OUT_DATA(OUT_DATA)
    );

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        # 100
        // Display output header
        $display("Time\t\tIN_DATA\t\t\t\tIN_KEY\t\t\t\tOUT_DATA");

        // Initialize inputs
        IN_DATA = 128'h69c4e0d86a7b0430d8cdb78070b4c55a; // Example ciphertext block
        IN_KEY  = 128'h000102030405060708090a0b0c0d0e0f; // Example round key

        // Wait for a few clock cycles and observe output
        #100;
        $display("%0d\t%h\t%h\t%h", $time, IN_DATA, IN_KEY, OUT_DATA);

        // You can add additional test cases here with different input data and keys if needed.

        // End the simulation after some time
        #100;
        $finish;
    end

endmodule
