`timescale 1ns / 1ps
module sign_div(input[63:0]data_input,input enable_signal,input clk_in,input reset,output [63:0]out_data,output reg out = 0); 
reg para_nal;reg [5:0]data_sel=0;reg [31:0]selector;reg [63:0]reg_data;
assign out_data[63:32]= reg_data[31:0];assign out_data[31:0]= reg_data[63:32];
always@(posedge clk_in)
begin if(reset)begin reg_data = 0;out = 0;end else begin if(enable_signal)begin reg_data  = 0;out = 1;data_sel = 0;
case({data_input[31],data_input[63]})
2'b00:begin selector = data_input[31:0];reg_data[31:0] = data_input[63:32];para_nal = 0;end
2'b01:begin selector = data_input[31:0];reg_data[31:0] = -data_input[63:32];para_nal = 1;end
2'b10:begin selector = -data_input[31:0];reg_data[31:0] = data_input[63:32];para_nal = 1;end
2'b11:begin selector = -data_input[31:0];reg_data[31:0] = -data_input[63:32];para_nal = 0;end
endcase reg_data[63:32] = 0;end
else if(out)begin reg_data = reg_data<<1;
if(reg_data[63:32]>=selector)begin reg_data[63:32] = reg_data[63:32] - selector;reg_data[31:0] = reg_data[31:0] + 1;end data_sel = data_sel +1;
if(data_sel ==32)begin out = 0;
if(para_nal)reg_data[31:0] = -reg_data[31:0];
if(data_input[63]==1)reg_data[63:32] = - reg_data[63:32]; end end end end endmodule