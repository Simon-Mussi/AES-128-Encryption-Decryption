`timescale 1ns / 1ns

module inv_shift_rows_tb;
    // Inputs
    reg clk;
    reg [127:0] IN_DATA;

    // Outputs
    wire [127:0] INV_SHIFT_DATA;

    // Instantiate the INV_SHIFT_ROWS module
    INV_SHIFT_ROWS uut (
        .clk(clk),
        .IN_DATA(IN_DATA),
        .INV_SHIFT_DATA(INV_SHIFT_DATA)
    );

    // Clock generation
    always #5 clk = ~clk; // Generate a clock signal with a period of 10ns

    initial begin
        // Initialize Inputs
        #10
        clk = 0;
        IN_DATA = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;

        // Wait for a few clock cycles
        #10;
        
        // Display the output
        $display("Test Case 1:");
        $display("Input Data:       %h", IN_DATA);
        $display("Output Data:      %h", INV_SHIFT_DATA);

        // Add more test cases if needed
        // For example, using known plaintext and ciphertext pairs.

        // Finish the simulation after some time
        #100;
        $finish;
    end
endmodule
