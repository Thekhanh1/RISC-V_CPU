`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 10:49:04 AM
// Design Name: 
// Module Name: RV32I_ALU
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

`define ADD 4'b0000
`define SUB 4'b0001
`define AND 4'b0010
`define OR 4'b0011
`define XOR 4'b0100
`define SLL 4'b0101
`define SRL 4'b0110
`define SRA 4'b0111
`define SLT 4'b1000
`define SLTU 4'b1001

module RV32I_ALU (
    input [3:0] ALUSrc,
    input [31:0] srcA,
    input [31:0] srcB,
    output reg [31:0] ALUResult,
    output reg zero
);

  always @(*) begin
    case (ALUSrc)
      `ADD: begin
        ALUResult = srcA + srcB;
      end
      `SUB: begin
        ALUResult = srcA - srcB;
      end
      `AND: begin
        ALUResult = srcA & srcB;
      end
      `OR: begin
        ALUResult = srcA | srcB;
      end
      `XOR: begin
        ALUResult = srcA ^ srcB;
      end
      `SLL: begin
        ALUResult = srcA << srcB[4:0];
      end
      `SRL: begin
        ALUResult = srcA >> srcB[4:0];
      end
      `SRA: begin
        ALUResult = $signed(srcA) >>> srcB[4:0];
      end
      `SLT: begin
        if ($signed(srcA) < $signed(srcB)) begin
          ALUResult = 1;
        end else begin
          ALUResult = 0;
        end
      end
      `SLTU: begin
        if (srcA < srcB) begin
          ALUResult = 1;
        end else begin
          ALUResult = 0;
        end
      end
      default: begin
        ALUResult = 32'h00000000;
      end
    endcase
    zero = (ALUResult == 32'b0);
  end


endmodule
