`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:10:21 AM
// Design Name: 
// Module Name: RV32I_control
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


module RV32I_control (
    input [6:0] opCode,
    input [2:0] funct3,
    input [6:0] funct7,
    input zero,
    input less,
    input lessU,

    output aluSrc,
    output memWe,
    output regWe,
    output [2:0] immSrc,
    output [1:0] resultSrc,
    output [3:0] aluCtrl,
    output [1:0] pcSrc
);

  wire branchTaken;
  wire branch;
  wire [1:0] jump;
  wire [1:0] aluOp;

  RV32I_maindecoder u_RV32I_maindecoder (
      .opCode(opCode),
      .aluSrc(aluSrc),
      .memWe(memWe),
      .regWe(regWe),
      .immSrc(immSrc),
      .resultSrc(resultSrc),
      .aluOp(aluOp),
      .branch(branch),
      .jump(jump)
  );

  RV32I_ALUdecoder u_RV32I_ALUdecoder (
      .funct3(funct3),
      .funct7(funct7),
      .aluOp(aluOp),
      .aluCtrl(aluCtrl)
  );

  RV32I_branchlogic u_RV32I_branchlogic (
      .branch(branch),
      .zero(zero),
      .less(less),
      .lessU(lessU),
      .funct3(funct3),
      .jump(jump),
      .pcSrc(pcSrc)
  );

endmodule
