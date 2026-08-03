`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:19:56 AM
// Design Name: 
// Module Name: RV32I_top
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


module RV32I_top (
    input clk,
    input rst
);

  wire memWe;
  wire [31:0] pc;
  wire [31:0] instr;
  wire [31:0] readData;
  wire [31:0] dataAdr;
  wire [31:0] dataWrite;

  RV32I_core u_RV32I_core (
      .clk(clk),
      .rst(rst),
      .instr(instr),
      .readData(readData),
      .memWe(memWe),
      .pc(pc),
      .dataAdr(dataAdr),
      .dataWrite(dataWrite)
  );

  RV32I_exmem u_RV32I_exmem (
      .clk(clk),
      .memWe(memWe),
      .pc(pc),
      .aluResult(dataAdr),
      .writeData(dataWrite),
      .readData(readData),
      .instr(instr)
  );

endmodule
