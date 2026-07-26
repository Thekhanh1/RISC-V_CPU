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

module RV32I_ALU (
    input [3:0] ALUCtrl,
    input [31:0] srcA,
    input [31:0] srcB,
    output reg [31:0] ALUResult,
    output wire zero,
    output wire less,
    output wire lessU
);

  localparam [3:0] ADD = 4'b0000;
  localparam [3:0] SUB = 4'b0001;
  localparam [3:0] AND = 4'b0010;
  localparam [3:0] OR = 4'b0011;
  localparam [3:0] XOR = 4'b0100;
  localparam [3:0] SLL = 4'b0101;
  localparam [3:0] SRL = 4'b0110;
  localparam [3:0] SRA = 4'b0111;
  localparam [3:0] SLT = 4'b1000;
  localparam [3:0] SLTU = 4'b1001;

  always @(*) begin
    case (ALUCtrl)
      ADD: ALUResult = srcA + srcB;
      SUB: ALUResult = srcA - srcB;
      AND: ALUResult = srcA & srcB;
      OR: ALUResult = srcA | srcB;
      XOR: ALUResult = srcA ^ srcB;
      SLL: ALUResult = srcA << srcB[4:0];
      SRL: ALUResult = srcA >> srcB[4:0];
      SRA: ALUResult = $signed(srcA) >>> srcB[4:0];
      SLT: begin
        if ($signed(srcA) < $signed(srcB)) begin
          ALUResult = 1;
        end else begin
          ALUResult = 0;
        end
      end
      SLTU: begin
        if (srcA < srcB) begin
          ALUResult = 1;
        end else begin
          ALUResult = 0;
        end
      end
      default: ALUResult = 32'h00000000;
    endcase
  end
  assign zero  = (ALUResult == 32'b0);
  assign less  = ($signed(srcA) < $signed(srcB));
  assign lessU = (srcA < srcB);
endmodule
