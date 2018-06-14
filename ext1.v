`timescale 1ns / 1ps
module ext1(
    input negative,
    input carry,
    input mode,
    output [31:0]data_out
    );
    assign data_out = {31'b0,(negative&mode) | (carry&~mode) };
endmodule
