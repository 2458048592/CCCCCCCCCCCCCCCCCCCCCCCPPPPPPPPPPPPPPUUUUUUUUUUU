`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 20:14:52
// Design Name: 
// Module Name: counter_100
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
input reset,
input clk,
input [31:0]init_data,
output [31:0]seg7_data
);
//reg [31:0]temp;
//reg [31:0]hex_data;
integer am;
always@(posedge clk)
begin
if(reset)
am=init_data;
else
begin
am=am-1;
//seg7_data=temp;
end
end
assign seg7_data=am;
endmodule
