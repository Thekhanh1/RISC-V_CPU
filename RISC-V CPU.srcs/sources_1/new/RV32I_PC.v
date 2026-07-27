`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:17:03 AM
// Design Name: 
// Module Name: RV32I_PC
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


module RV32I_PC (
    input clk,
    input rst,
    input [31:0] pcNext,
    output reg [31:0] pc
);

  always @(posedge clk) begin
    if (rst) begin
      pc <= 32'h00000000;
    end else begin
      pc <= pcNext;
    end
  end
endmodule
