`timescale 1ns / 1ns

module aes_tb;
  reg clk;
  reg reset;

  reg [127:0] input_data;
  reg [127:0] input_key;
  wire [127:0] encrypted_data;
  wire [127:0] decrypted_data;

  // Instantiate the AES encryption module
  AES_128 AES_128_ENCRYPT(
    .clk(clk),
    .reset(reset),
    .INPUT_DATA(input_data), 
    .INPUT_KEY(input_key),     
    .OUTPUT_DATA(encrypted_data)
  );

  // Instantiate the AES decryption module
  AES_128_DECRYPT AES_128_DECRYPT(
    .clk(clk),
    .reset(reset),
    .INPUT_DATA(encrypted_data), 
    .INPUT_KEY(input_key),     
    .OUTPUT_DATA(decrypted_data)
  );

  initial begin  
      #20
      clk = 0;
      reset = 0;

      // Test Case 1
      input_data = 128'h00112233445566778899aabbccddeeff;
      input_key = 128'h000102030405060708090a0b0c0d0e0f;
      #800 $display("Test Case 1:");
      $display("Input Data: %h", input_data);
      $display("Encrypted Data: %h", encrypted_data);
      $display("Decrypted Data: %h", decrypted_data);

      // Check if decrypted data matches original input data
      if (decrypted_data == input_data) 
          $display("Decryption successful!");
      else
          $display("Decryption failed!");

      // Test Case 2
      input_data = 128'h00112233445566778899aabbccddeeff;
      input_key = 128'h110102030405060708090a0b0c0d0e0f;
      #800 $display("Test Case 2:");
      $display("Input Data: %h", input_data);
      $display("Encrypted Data: %h", encrypted_data);
      $display("Decrypted Data: %h", decrypted_data);

      if (decrypted_data == input_data) 
          $display("Decryption successful!");
      else
          $display("Decryption failed!");

      // Test Case 3
      input_data = 128'h11112233445566778899aabbccddeeff;
      input_key = 128'h110102030405060708090a0b0c0d0e0f;
      #800 $display("Test Case 3:");
      $display("Input Data: %h", input_data);
      $display("Encrypted Data: %h", encrypted_data);
      $display("Decrypted Data: %h", decrypted_data);

      if (decrypted_data == input_data) 
          $display("Decryption successful!");
      else
          $display("Decryption failed!");

      #100 $finish;
  end

  always #5 clk = !clk;  // Generate clock signal with a period of 10 time units

endmodule
