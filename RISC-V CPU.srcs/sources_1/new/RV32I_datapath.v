`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:24:00 AM
// Design Name: 
// Module Name: RV32I_datapath
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


module RV32I_datapath (
    input clk,
    input rst,
    input regWrite,
    input aluSrc,
    input [1:0] pcSrc,
    input [2:0] resultSrc,
    input [3:0] aluCtrl,
    input [2:0] immSrc,
    input [31:0] instr,
    input [31:0] readData,


    output [31:0] pc,
    output [31:0] aluResult,
    output [31:0] dataWrite,
    output zero,
    output less,
    output lessU
);

  wire [31:0] immExt;
  wire [31:0] srcA;
  wire [31:0] srcB = (aluSrc == 1'b1) ? immExt : dataWrite;
  wire [31:0] pcTarget = immExt + pc;
  wire [31:0] pcPlus4 = pc + 4;
  wire [31:0] pclinkReg = immExt + srcA;
  wire [31:0] pcNext = (pcSrc == 2'b00) ? pcPlus4   :
                       (pcSrc == 2'b01) ? pcTarget  : 
                       (pcSrc == 2'b10) ? pclinkReg :
                       0;
  wire [31:0] resultOut = (resultSrc == 3'b000) ? aluResult :
                          (resultSrc == 3'b001) ? readData  :
                          (resultSrc == 3'b010) ? pcPlus4   : 
                          (resultSrc == 3'b011) ? immExt    : 
                          pcTarget;


  RV32I_PC u_RV32I_PC (
      .pc(pc),
      .pcNext(pcNext),
      .rst(rst),
      .clk(clk)
  );

  RV32I_ALU u_RV32I_ALU (
      .aluCtrl(aluCtrl),
      .srcA(srcA),
      .srcB(srcB),
      .aluResult(aluResult),
      .zero(zero),
      .less(less),
      .lessU(lessU)
  );

  RV32I_regfile u_RV32I_regfile (
      .clk(clk),
      .A1(instr[19:15]),
      .A2(instr[24:20]),
      .A3(instr[11:7]),
      .WD3(resultOut),
      .WE3(regWrite),
      .RD1(srcA),
      .RD2(dataWrite)
  );

  RV32I_extend u_RV32I_extend (
      .immField(instr),
      .immSrc(immSrc),
      .immExt(immExt)
  );

endmodule
