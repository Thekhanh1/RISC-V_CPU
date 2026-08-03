`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:19:56 AM
// Design Name: 
// Module Name: RV32I_exmem
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


module RV32I_exmem (
    input clk,
    input memWe,
    input [31:0] aluResult,
    input [31:0] writeData,
    output reg [31:0] readData,
    output reg [31:0] instr
);

  RV32I_imem u_RV32I_imem (
      .aluResult(aluResult),
      .instr(instr)
  );

  RV32I_dmem u_RV32I_dmem (
      .clk(clk),
      .memWe(memWe),
      .aluResult(aluResult),
      .writeData(writeData),
      .readData(readData)
  );
endmodule
