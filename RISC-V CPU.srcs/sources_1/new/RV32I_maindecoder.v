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
    output [1:0] resultSrc,
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

  reg [12:0] control;

  always @(*) begin
    case (opCode)
      R_NORM:   control = 13'b0_0_1_000_00_10_0_00;
      I_NORM:   control = 13'b1_0_1_001_00_11_0_00;
      I_LOAD:   control = 13'b1_0_1_001_01_00_0_00;
      I_JALR:   control = 13'b1_0_1_001_10_00_0_01;
      S_STORE:  control = 13'b1_1_0_010_00_00_0_00;
      B_BRANCH: control = 13'b0_0_0_011_00_01_1_00;
      J_JAL:    control = 13'b1_0_1_101_10_00_0_10;
      U_LUI:    control = 13'b1_0_1_100_00_00_0_00;
      U_AUIPC:  control = 13'b1_0_1_100_00_00_0_00;

      default: control = 13'b0_0_0_000_00_00_0_00;
    endcase
  end
  assign {aluSrc, memWe, regWe, immSrc, resultSrc, aluOp, jump, branch} = control;
endmodule
