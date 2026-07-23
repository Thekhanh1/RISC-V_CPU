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
    input ALUSrc,
    input PCSrc,
    input [1:0] resultSrc,
    input [3:0] ALUCtrl,
    input [2:0] immSrc,
    input [31:0] Instr,
    input [31:0] readData,


    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] dataWrite,
    output zero
);

  wire [31:0] immExt;
  wire [31:0] SrcA;
  wire [31:0] SrcB = (ALUSrc == 1'b1) ? immExt : dataWrite;
  wire [31:0] PCTarget = immExt + PC;
  wire [31:0] PCPlus4 = PC + 4;
  wire [31:0] PCNext = (PCSrc == 1'b1) ? PCTarget : PCPlus4;
  wire [31:0] resultOut = (resultSrc == 2'b00) ? ALUResult :
                            (resultSrc == 2'b01) ? readData :
                            (resultSrc == 2'b10) ? PCPlus4 : 32'b0;


  RV32I_PC u_RV32I_PC (
      .PC(PC),
      .PCNext(PCNext),
      .rst(rst),
      .clk(clk)
  );

  RV32I_ALU u_RV32I_ALU (
      .ALUCtrl(ALUCtrl),
      .SrcA(SrcA),
      .SrcB(SrcB),
      .ALUResult(ALUResult),
      .zero(zero)
  );

  RV32I_regfile u_RV32I_regfile (
      .A1 (Instr[19:15]),
      .A2 (Instr[24:20]),
      .A3 (Instr[11:7]),
      .WD3(resultOut),
      .WE3(regWrite),
      .RD1(SrcA),
      .RD2(dataWrite)
  );

  RV32I_extend u_RV32I_extend (
      .immField(Instr),
      .immSrc  (immSrc),
      .immExt  (immExt)
  );

endmodule
