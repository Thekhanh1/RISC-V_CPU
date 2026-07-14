`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/25/2026 11:10:21 AM
// Design Name:
// Module Name: RV32I_extend
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
// 436
//////////////////////////////////////////////////////////////////////////////////
`define I 3'b000
`define S 3'b001
`define B 3'b010
`define U 3'b011
`define J 3'b100

module RV32I_extend (
    input [31:0] immField,
    input [2:0] immSrc,
    output reg [31:0] immExt
);

  always @(*) begin
    case (immSrc)
      `I: begin
        immExt = {{20{immField[31]}}, immField[31:20]};
      end

      `S: begin
        immExt = {{20{immField[31]}}, immField[31:25], immField[11:7]};
      end

      `B: begin
        immExt = {{20{immField[31]}}, immField[7], immField[30:25], immField[11:8], 1'b0};
      end

      `U: begin
        immExt = {immField[31:12], {12{1'b0}}};
      end

      `J: begin
        immExt = {{12{immField[31]}}, immField[19:12], immField[20], immField[30:21], 1'b0};
      end

      3'b101: begin
        immExt = 32'h00000000;
      end

      3'b110: begin
        immExt = 32'h00000000;
      end

      3'b111: begin
        immExt = 32'h00000000;
      end

      default: begin
        immExt = 32'h00000000;
      end
    endcase
  end

endmodule

