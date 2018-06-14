`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/08 19:56:39
// Design Name: 
// Module Name: VGA_driver
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


    module VGA_driver(    
    input clk,    
    input rst,    
    output reg [2:0] r,    
    output reg [2:0] g,    
    output reg [1:0] b,    
    output hs,    
    output vs    
    );    
    
    parameter UP_BOUND = 31;    
    parameter DOWN_BOUND = 510;    
    parameter LEFT_BOUND = 144;    
    parameter RIGHT_BOUND = 783;    
    reg h_speed, v_speed;    
    reg [9:0] up_pos, down_pos, left_pos, right_pos;    
    
    wire pclk;    
    reg [1:0]count;    
    reg [9:0] hcount, vcount;    
        
    // 获得像素时钟25MHz    
    assign pclk = count[1];    
    always @ (posedge clk)    
    begin    
        if (rst)    
            count <= 0;    
        else    
            count <= count+1;    
    end    
        
    // 列计数与行同步    
    assign hs =1;    
    always @ (posedge pclk or posedge rst)    
    begin    
        if (rst)    
            hcount <= 0;    
        else if (hcount == 799)    
            hcount <= 0;    
        else    
            hcount <= hcount+1;    
    end    
        
    // 行计数与场同步    
    assign vs = 1;    
    always @ (posedge pclk or posedge rst)    
    begin    
        if (rst)    
            vcount <= 0;    
        else if (hcount == 799) begin    
            if (vcount == 520)    
                vcount <= 0;    
            else    
                vcount <= vcount+1;    
        end    
        else    
            vcount <= vcount+1;    
    end    
        
    // 显示方块    
    always @ (posedge pclk or posedge rst)    
    begin    
        if (rst) begin    
            r <= 0;    
            g <= 0;    
            b <= 0;    
        end    
        else begin    
            if (vcount>=up_pos && vcount<=down_pos    
                    && hcount>=left_pos && hcount<=right_pos) begin    
                r <= 3'b000;    
                g <= 3'b111;    
                b <= 2'b00;    
            end    
            else begin    
                r <= 3'b000;    
                g <= 3'b000;    
                b <= 2'b00;    
            end    
        end    
    end    
        
     //每一帧动画之后根据方块当前位置调整速度    
    always @ (negedge vs or posedge rst)    
    begin    
        if (rst) begin    
            h_speed <= 0;    
            v_speed <= 0;    
        end    
        else begin    
            if (up_pos == UP_BOUND)    
                v_speed <= 0;    
            else if (down_pos == DOWN_BOUND)    
                v_speed <= 0;    
            else    
                v_speed <= v_speed;    
                
            if (left_pos == LEFT_BOUND)    
                h_speed <= 0;    
            else if (right_pos == RIGHT_BOUND)    
                h_speed <= 0;    
            else    
                h_speed <= h_speed;    
        end    
    end    
        
    // 每一帧动画之后根据速度值更新方块的位置    
    always @ (posedge vs or posedge rst)    
    begin    
        if (rst) begin    
            up_pos <= 391;    
            down_pos <= 510;    
            left_pos <= 384;    
            right_pos <= 543;    
        end    
        else begin    
            if (v_speed) begin    
                up_pos <= up_pos;    
                down_pos <= down_pos;    
            end    
            else begin    
                up_pos <= up_pos;    
                down_pos <= down_pos;    
            end    
                
            if (h_speed) begin    
                left_pos <= left_pos;    
                right_pos <= right_pos;    
            end    
            else begin    
                left_pos <= left_pos;    
                right_pos <= right_pos;    
            end    
        end    
    end    
    
endmodule
