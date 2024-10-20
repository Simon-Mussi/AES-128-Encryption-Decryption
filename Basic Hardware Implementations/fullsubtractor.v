module FullSubtractor(
    input A, 
    input B, 
    input Bin,
    output D, 
    output Bout
);
assign D = A ^ B ^ Bin;
assign Bout = (~A & B) | (B & Bin) | (~A & Bin);
endmodule