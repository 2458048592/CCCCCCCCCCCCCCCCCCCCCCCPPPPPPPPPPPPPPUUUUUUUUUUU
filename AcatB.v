`timescale 1ns / 1ps
module data1_link_data2(
    input [3:0]addr,
    input [25:0]IM_25_0,
    output [31:0]addr_o
    );
    assign addr_o = {addr,IM_25_0,2'b0};

endmodule
