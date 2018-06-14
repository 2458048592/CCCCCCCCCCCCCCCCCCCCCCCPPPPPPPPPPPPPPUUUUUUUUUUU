`timescale 1ns / 1ps
module unsign_divu(input [63:0]input_data,input enable,input clk_in,input reset,output [63:0]out_data,output reg busy); 
reg [63:0]regfile;reg [5:0]regdelete=0;
assign out_data[63:32]=regfile[31:0];assign out_data[31:0]=regfile[63:32];
always@(posedge clk_in)
begin if(reset)begin regfile=0;busy=0;end
else begin if(enable)begin regfile=0;busy=1;regdelete = 0;regfile[31:0]=input_data[63:32];regfile[63:32] = 0;end
else if(busy)begin regfile = regfile<<1;
if(regfile[63:32]>=input_data[31:0])begin regfile[63:32]=regfile[63:32]-input_data[31:0];regfile[31:0]=regfile[31:0]+1;end regdelete=regdelete +1;
if(regdelete==32)busy=0;end end end endmodule
