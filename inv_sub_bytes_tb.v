`timescale 1ns / 1ns
module inv_sub_bytes_tb;

    reg clk;
    reg [127:0] in_data;
    wire [127:0] inv_sub_data;

    // Instantiate the INV_SUB_BYTES module
    INV_SUB_BYTES uut (
        .clk(clk),
        .IN_DATA(in_data),
        .INV_SB_DATA_OUT(inv_sub_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize
        #20
        clk = 0;
        in_data = 128'h69c4e0d86a7b0430d8cdb78070b4c55a; // Example input

        // Wait for a few clock cycles to see the output
        #20;
        $display("Input Data:  %h", in_data);
        $display("Output Data: %h", inv_sub_data);

        // End the simulation after sufficient time
        #20;
        $finish;
    end
endmodule
