`timescale 1ns / 1ps

module inv_mix_columns_tb;

    // Inputs
    reg clk;
    reg [127:0] in_data;

    // Outputs
    wire [127:0] inv_mixed_data;

    // Instantiate the Unit Under Test (UUT)
    INV_MIX_COLUMNS uut (
        .clk(clk),
        .IN_DATA(in_data),
        .INV_MIXED_DATA(inv_mixed_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test vectors
    initial begin
        #100
        // Test case 1
        in_data = 128'h69c4e0d86a7b0430d8cdb78070b4c55a; // Example encrypted data
        #100; // Wait for a clock cycle to process
        $display("Test Case 1:");
        $display("Input Data:       %h", in_data);
        $display("Output Data:      %h", inv_mixed_data);

        // Check expected result here (replace with the known expected result)
        // For example, let's assume the expected output after inverse mix columns is:
        // 128'h00112233445566778899aabbccddeeff
        $finish;
    end

endmodule
