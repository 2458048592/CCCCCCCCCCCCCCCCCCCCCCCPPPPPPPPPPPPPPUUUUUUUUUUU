`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/22 20:02:59
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
//input [15:0]sw,
input clk_in, 
input reset, 
//output [7:0]o_seg,
//output [7:0]o_sel,
//output [2:0] r,    
//output [2:0] g,    
//output [1:0] b,    
//output hs,    
//output vs  
output[31:0]inst, 
output[31:0]pc, 
output[31:0]addr
);
//cpu sccpu(.sw(sw),._clk(clk_in),.reset(reset),.o_seg(o_seg),.o_sel(o_sel),.r(r),.g(g),.b(b),.hs(hs),.vs(vs));//.cpu_out_inst(inst),.cpu_out_pc(pc),.cpu_out_alu(addr));

cpu sccpu(._clk(clk_in),.reset(reset),.cpu_out_inst(inst),.cpu_out_pc(pc),.cpu_out_alu(addr));
endmodule
