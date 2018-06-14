`timescale 1ns / 1ns
module sign_mult(input enable_signal,input clock_in,input reset,input [63:0]input_data,output [63:0]out_data,output reg busy = 0);//乘法忙信号
reg [5:0]counter =0;reg [63:0]temp_regfile=0;reg enble = 0;//标志信号
always@(posedge clock_in)
begin if(reset)temp_regfile=0;
else if(enable_signal)begin temp_regfile[63:0]={32'b0,input_data[31:0]};enble = 0;busy = 1;counter = 0;end
else if(busy)begin
case({temp_regfile[0],enble})//选择信号select
2'b00,2'b11:;
2'b01:temp_regfile[63:32]=  temp_regfile[63:32] + input_data[63:32];
2'b10:temp_regfile[63:32]=  temp_regfile[63:32] - input_data[63:32];
endcase enble = temp_regfile[0];temp_regfile = {temp_regfile[63],temp_regfile[63:1]};counter=counter+1;busy=((counter)==32)?0:1;
end end assign out_data = temp_regfile;endmodule