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
    input [31:0] aluResult,
    output reg [31:0] instr
);

  reg [31:0] instrRom[0:255];

  initial begin
    $readmemh("program.hex", instrRom);
  end
  always @(*) begin
    instr = instrRom[aluResult>>2];
  end
endmodule
