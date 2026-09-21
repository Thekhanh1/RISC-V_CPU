`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:10:21 AM
// Design Name: 
// Module Name: RV32I_imem
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


module RV32I_imem (
    input [31:0] pc,
    output reg [31:0] instr
);
  reg [  31:0] instrRom[0:4095];
  reg [1023:0] memfile;

  initial begin
    if (!$value$plusargs("MEMFILE=%s", memfile)) memfile = "program.hex";
    $readmemh(memfile, instrRom);
  end

  always @(*) begin
    instr = instrRom[pc>>2];
  end
endmodule
