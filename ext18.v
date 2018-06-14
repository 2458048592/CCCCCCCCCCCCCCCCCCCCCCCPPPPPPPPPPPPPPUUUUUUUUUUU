`timescale 1ns / 1ps
module ext18(
    input [15:0]data_in,
    output [31:0]data_out
);
assign data_out = {data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in[15],data_in[15],
                data_in,2'b0};
endmodule
