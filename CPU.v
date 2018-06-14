`timescale 1ns / 1ps
module cpu(
input [15:0]sw,
input _clk,
input reset,
output [7:0]o_seg,
output [7:0]o_sel//,
//output [31:0]in_seg7
//,
//output [2:0] r,    
//output [2:0] g,    
//output [1:0] b,    
//output hs,    
//output vs  
//output [31:0]cpu_out_inst,
//output [31:0]cpu_out_pc,
//output [31:0]cpu_out_alu
);
    //wire [15:0]sw;
    wire [31:0]cpu_out_inst;
    wire [31:0]cpu_out_pc;
    wire [31:0]cpu_out_alu;
//    wire [7:0]o_seg;
//    wire [7:0]o_sel;
//    wire [15:0]sw;
//    assign sw=16'b0;
    wire mem_mux_select;
    wire seg7_cs;
    wire switch_cs;
    wire mem_r_w;
    wire clk;    
    wire pcreg_ena;
    wire d_ram_wena;
    wire rf_we;
    wire [4:0]rf_waddr;
    wire [4:0]rf_raddr1;
    wire [4:0]rf_raddr2;
    wire [3:0]rf_wdata_mux;
    wire wext1;
    wire wext1_mode;
    wire wext5;
    wire wext5_mux;
    wire wext16;
    wire wext16_s_uns;
    wire wext18;
    wire AcatB;
    wire [3:0]alu_aluc;    
    wire [1:0]alu_a_mux;    
    wire [2:0]alu_b_mux;    
    wire [1:0]pc_mux;
    wire exception;
    wire [5:0]instruction;
    wire mfc0;
    wire mtc0;    
    wire alu_zero;
    wire alu_carry;
    wire alu_negative;
    wire add_finish;
    wire ir_ena;
    wire alu_z_ena;
    wire clz_ena;
    wire Hiwena; 
    wire [1:0]Hiselect;
    wire Lowena;
    wire [1:0]Loselect;
    wire div_start;
    wire [1:0]bhw_select;
    wire [1:0]lbhw_select;
    wire lbhw_sign;
    wire mulu_start;
    wire [4:0]CP0_ADDR;
    wire [3:0]cause;
    wire eret;
    wire div_busy;
    wire sign_ext16;
    
    
    
    wire [31:0]rt;
    wire [31:0]alu_out;
    wire [31:0]mem_addr;    
    wire [31:0]rdata; 
    wire [31:0]mem_out;
    wire [31:0]bhw_out;
    wire [31:0]im_inst_out;
    wire [31:0]AcatB_to_mux;
    wire [31:0]ext18_out;
    wire [31:0]ext16_out;
    wire [31:0]ext5_out;
    wire [31:0]exc_addr;    
    wire [31:0]alu_a;
    wire [31:0]alu_b;
    wire [31:0]ext1_out;    
    wire [31:0]multu_hi;
    wire [31:0]multu_lo;    
    wire [31:0]mul_hi;
    wire [31:0]mul_lo;   
    wire [31:0]divu_q;
    wire [31:0]div_q;
    wire [31:0]divu_r;
    wire [31:0]div_r;    
    wire [31:0]hi_out;
    wire [31:0]lo_out;    
    wire [31:0]cp0_rdata;
    wire [31:0]status;
    wire [31:0]lbhwout;
    wire [31:0]rf_in;    
    wire [31:0]clz_out;
    wire [31:0]rs;
    wire [31:0]pc_out;
    wire [31:0] mux_to_pc;
    wire [31:0]alu_z_out;
//    assign sw=16'b0;
//    assign switch_cs = (alu_out == 32'h10010010 && mem_mux_select == 1 && ~mem_r_w == 1) ? 1 : 0;
//    assign rdata=(switch_cs) ? {16'b0, sw[15:0]} : mem_out;
    io_sel io_mem(alu_out,  mem_mux_select ,mem_r_w,~mem_r_w,seg7_cs,switch_cs);

//seg7x16 seg7(clk,reset,seg7_cs,rt,o_seg,o_sel);
    //wire [31:0]in_seg7; 
    //seg7x16 seg7(clk,reset,seg7_cs,in_seg7,o_seg,o_sel);
   //assign in_seg7=32'hfffffffe; 
//    wire clk_1hz;
//    wire num_init;
//    assign num_init=32'h00000064;


    wire [31:0]in_seg7;
    clk_wiz_0 CLK_DIVIDER(.clk_in1(_clk),.clk_out1(clk),.reset(reset)); 
    
    //fdiv1hz divider(clk,clk_1hz);
    //counter counter_100(reset,clk_1hz,num_init,in_seg7);
    seg7x16 seg7(clk,reset,seg7_cs,bhw_out,o_seg,o_sel);
   // assign in_seg7=32'h00000005;
    //seg7x16 seg7(clk,reset,seg7_cs,in_seg7,o_seg,o_sel);
    sw_mem_sel sw_mem  (switch_cs,sw,mem_out,rdata);
    //assign clk=_clk;
    
    
    
    
    
    
    
    
    
    
    
    
   
    instruction decoder(im_inst_out[31:26],im_inst_out[25:21],im_inst_out[20:16],im_inst_out[5:0],instruction,mfc0,mtc0);
    CPU54_muticycle_controler controler(reset,im_inst_out,instruction,clk,
    {alu_zero,alu_negative,status[3:0]},{eret,exception,cause,lbhw_sign,lbhw_select,bhw_select,div_start,mul_start,mulu_start,
    Hiwena,Hiselect,Lowena,Loselect,clz_ena,alu_z_ena,ir_ena,mem_mux_select,pcreg_ena,//mem_r_wÎª¶ÁÐ´¿ØÖÆ 
    rf_we,rf_waddr,rf_raddr1,rf_raddr2,rf_wdata_mux,
    wext1,wext1_mode,wext5,wext5_mux,wext16,wext16_s_uns,wext18,AcatB,
    alu_aluc,alu_a_mux,alu_b_mux,pc_mux,CP0_ADDR},finish_instr,mem_r_w);
    assign clz_out =(rs[31:31] == 1'b1)? 32'd0:((rs[31:30] == 2'b01)? 32'd1:rs[31:29] == 3'b001 ? 32'd2:rs[31:28] == 4'b0001 ? 32'd3:rs[31:27] == 5'b1 ? 32'd4:rs[31:26] == 6'b1 ? 32'd5:rs[31:25] == 7'b1 ? 32'd6:rs[31:24] == 8'b1 ? 32'd7:rs[31:23] == 9'b1 ? 32'd8:rs[31:22] == 10'b1 ? 32'd9:rs[31:21] == 11'b1 ? 32'd10:rs[31:20] == 12'b1 ? 32'd11:rs[31:19] == 13'b1 ? 32'd12:rs[31:18] == 14'b1 ? 32'd13:rs[31:17] == 15'b1 ? 32'd14:rs[31:16] == 16'b1 ? 32'd15:rs[31:15] == 17'b1 ? 32'd16:rs[31:14] == 18'b1 ? 32'd17:rs[31:13] == 19'b1 ? 32'd18:rs[31:12] == 20'b1 ? 32'd19:rs[31:11] == 21'b1 ? 32'd20:rs[31:10] == 22'b1 ? 32'd21:rs[31:9] == 23'b1 ? 32'd22:rs[31:8] == 24'b1 ? 32'd23:rs[31:7] == 25'b1 ? 32'd24:rs[31:6] == 26'b1 ? 32'd25:rs[31:5] == 27'b1 ? 32'd26:rs[31:4] == 28'b1 ? 32'd27:rs[31:3] == 29'b1 ? 32'd28:rs[31:2] == 30'b1 ? 32'd29:rs[31:1] == 31'b1 ? 32'd30:rs[31:0] == 32'b1 ? 32'd31:32'd32);
    regfile_for_pc regfile_PC(clk,reset,mux_to_pc,pcreg_ena,pc_out);
    selector_for2 selector4_4(mem_mux_select,(pc_out-4194304)/4,alu_z_out/4+2048,mem_addr);
    selectorLBLHLW selector_1(bhw_select,rt,mem_out,alu_z_out,bhw_out);
    
    
    dist_mem_gen_0 DMEM(mem_addr,bhw_out,clk,mem_r_w && (mem_addr[31] == 0),mem_out); 
    
    
    instruction_regfile instruction_temp(clk,ir_ena,mem_out,im_inst_out);
    assign ext18_out=(im_inst_out[15]==1)?{14'b1,im_inst_out[15:0],2'b0}:{14'b0,im_inst_out[15:0],2'b0};
    assign sign_ext16=wext16_s_uns&im_inst_out[15];
    assign ext16_out={sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,sign_ext16,im_inst_out[15:0]};
    assign ext5_out=(wext5_mux)?{27'b0,im_inst_out[10:6]}:{27'b0,im_inst_out[25:21]};
    assign AcatB_to_mux={pc_out[31:28],im_inst_out[25:0],2'b0};
    selector_for4 data_mux_sel1(pc_mux,rs,alu_z_out,AcatB_to_mux,exc_addr,mux_to_pc);
    selector_for4 data_mux_sel2(alu_a_mux,ext5_out,rs,im_inst_out,pc_out,alu_a);
    selector_for8_8 data_mux_sel3(alu_b_mux,rt,ext16_out,ext18_out,alu_b);  
    assign ext1_out={31'b0,(alu_negative&wext1_mode)|(alu_carry&~wext1_mode)};
    sign_mult sign_mul(mul_start,clk,reset,{rs,rt},{mul_hi,mul_lo});
    unsign_mult unsign_mult1(mulu_start,clk,reset,{rs,rt},{multu_hi,multu_lo});
    sign_div sign({rs,rt},div_start,clk,reset,{div_q,div_r},div_busy);
    unsign_divu unsign({rs,rt},div_start,clk,reset,{divu_q,divu_r},divu_busy);
    mux_for4 regfile_HI(clk,Hiwena,Hiselect,divu_r,div_r,multu_hi,rs,hi_out);
    mux_for4 regfile_LO(clk,Lowena,Loselect,divu_q,div_q,multu_lo,rs,lo_out);
    regfile_for_cp0 regfile_CP0(clk,reset,{mfc0,mtc0},pc_out-4,CP0_ADDR,rt,{exception,eret},cause,{cp0_rdata,status,exc_addr});
    mux_for7 selector(lbhw_sign,lbhw_select,rdata,alu_z_out,lbhwout);
    
    data_selector selector1(rf_wdata_mux,{ext1_out,lbhwout},{alu_z_out,pc_out},{clz_out,hi_out},lo_out,mul_lo,cp0_rdata,rf_in);
    CPU54_regfiles cpu_ref(clk,reset,rf_we,rf_raddr1,rf_raddr2,rf_waddr,rf_in,rs,rt);//,in_seg7);
    Z_tempreg regfile_Z(alu_z_ena,alu_out,alu_z_out);
    calculator ALU(alu_a,alu_b,alu_aluc,alu_out,alu_zero,alu_carry,alu_negative);
    assign cpu_out_inst = im_inst_out;assign cpu_out_pc = pc_out;assign cpu_out_alu = alu_out;
    
    
    //VGA_driver VGA(_clk,reset,r,g,b,hs,vs);
endmodule