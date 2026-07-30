`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:19:56 AM
// Design Name: 
// Module Name: RV32I_core
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


module RV32I_core (
    input clk,
    input rst,
    input [31:0] instr,
    input [31:0] readData,


    output memWe,
    output [31:0] pc,
    output [31:0] dataAdr,
    output [31:0] dataWrite
);

  wire aluSrc;
  wire zero;
  wire less;
  wire lessU;
  wire regWrite;
  wire [6:0] opCode;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [2:0] immSrc;
  wire [2:0] resultSrc;
  wire [3:0] aluCtrl;
  wire [1:0] pcSrc;
  wire [31:0] aluResult;

  assign opCode = instr[6:0];
  assign funct3 = instr[14:12];
  assign funct7 = instr[31:25];

  RV32I_control u_RV32I_control (
      .opCode(opCode),
      .funct3(funct3),
      .funct7(funct7),
      .zero(zero),
      .less(less),
      .lessU(lessU),
      .aluSrc(aluSrc),
      .memWe(memWe),
      .regWe(regWrite),
      .immSrc(immSrc),
      .resultSrc(resultSrc),
      .aluCtrl(aluCtrl),
      .pcSrc(pcSrc)
  );

  RV32I_datapath u_RV32I_datapath (
      .clk(clk),
      .rst(rst),
      .regWrite(regWrite),
      .aluSrc(aluSrc),
      .pcSrc(pcSrc),
      .resultSrc(resultSrc),
      .aluCtrl(aluCtrl),
      .immSrc(immSrc),
      .instr(instr),
      .readData(readData),
      .pc(pc),
      .aluResult(aluResult),
      .dataWrite(dataWrite),
      .zero(zero),
      .less(less),
      .lessU(lessU)
  );

  assign dataAdr = aluResult;
endmodule
