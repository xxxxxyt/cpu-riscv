`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 15:15:24
// Design Name: 
// Module Name: regfile
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

`include "defines.v"

module regfile(
        
        input wire clk,
        input wire rst,
        
        // д�˿�
        input wire we, // write enable
        input wire[`RegAddrBus] waddr,
        input wire[`RegBus] wdata,
        
        // ���˿�1
        input wire re1, // read enable
        input wire[`RegAddrBus] raddr1,
        output reg[`RegBus] rdata1,
        
        // ���˿�2
        input wire re2,
        input wire[`RegAddrBus] raddr2,
        output reg[`RegBus] rdata2
    );
    
    // 32���Ĵ���
    reg[`RegBus] regs[0:`RegNum-1];
    
    // д����
    always @ (posedge clk) begin // ʱ��������д
        if (rst == `RstDisable) begin
            // cannot modify x0==0
            if ((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
                regs[waddr] <= wdata;
            end
        end
    end
    
    // ���˿�1�Ķ�����
    always @ (*) begin // input�޸�ʱ��
        if (rst == `RstEnable) begin
            rdata1 <= `ZeroWord;
        end else if (raddr1 == `RegNumLog2'h0) begin
            rdata1 <= `ZeroWord;
        end else if ((raddr1 == waddr) && (we == `WriteEnable)
                                       && (re1 == `ReadEnable)) begin
            rdata1 <= wdata;
        end else if (re1 == `ReadEnable) begin
            rdata1 <= regs[raddr1];
        end else begin
            rdata1 <= `ZeroWord;
        end
    end
    
    // ���˿�2�Ķ�����
    always @ (*) begin
        if (rst == `RstEnable) begin
            rdata2 <= `ZeroWord;
        end else if (raddr2 == `RegNumLog2'h0) begin
            rdata2 <= `ZeroWord;
        end else if ((raddr2 == waddr) && (we == `WriteEnable)
                                       && (re2 == `ReadEnable)) begin
            rdata2 <= wdata;
        end else if (re2 == `ReadEnable) begin
            rdata2 <= regs[raddr2];
        end else begin
            rdata2 <= `ZeroWord;
        end
    end
            
    
endmodule
