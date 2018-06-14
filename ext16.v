`timescale 1ns / 1ps
module ext16(
    input [15:0]data_in,
    input s,//signed or not
    output [31:0]data_out
);
   // assign data_out = (s&data_in[15])?{16'b1,data_in}:{16'b0,data_i};
    assign data_out={s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],s&data_in[15],
    s&data_in[15],data_in};
endmodule
