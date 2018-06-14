`timescale 1ns / 1ps
module special_HI(
    input clk,
    input wena,
    input [1:0]select,
    input [31:0]DIVU,
    input [31:0]DIV,
    input [31:0]MULU,
    input [31:0]rs,
    output reg [31:0]r
    );
    always@(negedge clk)
    begin
        if(wena)
        begin
            case(select)
                2'b00:
                    r <= DIVU;
                2'b01:
                    r <= DIV;
                2'b10:
                    r <= MULU;
                2'b11:
                    r<=rs;
            endcase
        end
    end
endmodule

