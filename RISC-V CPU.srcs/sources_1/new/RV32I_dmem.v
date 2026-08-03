`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:10:21 AM
// Design Name: 
// Module Name: RV32I_dmem
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


module RV32I_dmem (
    input clk,
    input memWe,
    input [31:0] aluResult,
    input [31:0] writeData,
    output reg [31:0] readData
);

  reg [31:0] dataRam[0:255];

  always @(*) begin
    readData = dataRam[aluResult>>2];
  end

  always @(posedge clk) begin
    if (memWe == 1'b1) begin
      dataRam[aluResult>>2] <= writeData;
    end
  end
endmodule
