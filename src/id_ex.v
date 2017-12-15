`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 21:53:02
// Design Name: 
// Module Name: id_ex
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

module id_ex(
        
        input wire clk,
        input wire rst,
        
        // form id
        input wire[`AluOpBus] id_aluop,
        input wire[`AluSelBus] id_alusel,
        input wire[`RegBus] id_reg1,
        input wire[`RegBus] id_reg2,
        input wire[`RegAddrBus] id_wd, // write addr
        input wire id_wreg, // wire reg or not
        
        // to ex
        output reg[`AluOpBus] ex_aluop,
        output reg[`AluSelBus] ex_alusel,
        output reg[`RegBus] ex_reg1,
        output reg[`RegBus] ex_reg2,
        output reg[`RegAddrBus] ex_wd,
        output reg ex_wreg
    );
    
    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            ex_aluop <= `EXE_NOP_OP;
            ex_alusel <= `EXE_RES_NOP;
            ex_reg1 <= `ZeroWord;
            ex_reg2 <= `ZeroWord;
            ex_wd <= `NOPRegAddr;
            ex_wreg <= `WriteDisable;
        end else begin
            ex_aluop <= id_aluop;
            ex_alusel <= id_alusel;
            ex_reg1 <= id_reg1;
            ex_reg2 <= id_reg2;
            ex_wd <= id_wd;
            ex_wreg <= id_wreg;
        end
    end
    
endmodule
