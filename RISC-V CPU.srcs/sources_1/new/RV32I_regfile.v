`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 11:10:21 AM
// Design Name: 
// Module Name: RV32I_regfile
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


module RV32I_regfile (
    input             clk,
    input             WE3,
    input      [ 4:0] A1,
    input      [ 4:0] A2,
    input      [ 4:0] A3,
    input      [31:0] WD3,
    output reg [31:0] RD1,
    output reg [31:0] RD2
);

  reg [31:0] registers[0:31];

  always @(*) begin
    if (A1 == 5'b0) begin
      RD1 = 32'b0;
    end else begin
      RD1 = registers[A1];
    end

    if (A2 == 5'b0) begin
      RD2 = 32'b0;
    end else begin
      RD2 = registers[A2];
    end
  end

  always @(posedge clk) begin
    if (WE3 == 1'b1) begin
      if (A3 != 5'b0) begin
        registers[A3] <= WD3;
      end
    end

  end
endmodule
