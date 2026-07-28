`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 04:16:43 PM
// Design Name: 
// Module Name: RV32I_maindecoder
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


module RV32I_maindecoder (
    input [6:0] opCode,
    output aluSrc,
    output memWe,
    output regWe,
    output [2:0] immSrc,
    output [2:0] resultSrc,
    output [1:0] aluOp,
    output [1:0] jump,
    output branch
);

  localparam [6:0] R_NORM = 7'b0110011;
  localparam [6:0] I_NORM = 7'b0010011;
  localparam [6:0] I_LOAD = 7'b0000011;
  localparam [6:0] I_JALR = 7'b1100111;
  localparam [6:0] S_STORE = 7'b0100011;
  localparam [6:0] B_BRANCH = 7'b1100011;
  localparam [6:0] U_LUI = 7'b0110111;
  localparam [6:0] U_AUIPC = 7'b0010111;
  localparam [6:0] J_JAL = 7'b1101111;

  reg [13:0] control;

  always @(*) begin
    case (opCode)
      R_NORM:   control = 14'b0_0_1_000_000_10_0_00;
      I_NORM:   control = 14'b1_0_1_001_000_11_0_00;
      I_LOAD:   control = 14'b1_0_1_001_001_00_0_00;
      I_JALR:   control = 14'b1_0_1_001_010_00_0_10;
      S_STORE:  control = 14'b1_1_0_010_000_00_0_00;
      B_BRANCH: control = 14'b0_0_0_011_000_01_1_00;
      J_JAL:    control = 14'b1_0_1_101_010_00_0_01;
      U_LUI:    control = 14'b1_0_1_100_011_00_0_00;
      U_AUIPC:  control = 14'b1_0_1_100_100_00_0_00;

      default: control = 14'b0_0_0_000_000_00_0_00;
    endcase
  end
  assign {aluSrc, memWe, regWe, immSrc, resultSrc, aluOp, branch, jump} = control;
endmodule
