`timescale 1ns / 1ps
module MUX_2(
    input select,
    input [4:0]i1,
    input [4:0]i2,
    output reg [4:0]o
    );
    always@(*)
        begin
        case(select)
            1'b0:  o <=  i1;
            1'b1:  o <=  i2;
        endcase
        end
endmodule