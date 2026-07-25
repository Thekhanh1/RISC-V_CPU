`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 04:16:43 PM
// Design Name: 
// Module Name: RV32I_ALUdecoder
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


module RV32I_ALUdecoder (
    input [2:0] funct3,
    input [6:0] funct7,
    input [1:0] ALUop,
    output reg [3:0] ALUCtrl
);

  always @(*) begin
    case (ALUop)
      2'b00: ALUCtrl = 4'b0000;
      2'b01: ALUCtrl = 4'b0001;
      default:
      case (funct3)
        3'b000: begin
          if ((ALUop == 2'b10) & (funct7 == 7'h20)) ALUCtrl = 4'b0001;
          else ALUCtrl = 4'b0000;
        end
        3'b001:  ALUCtrl = 4'b0101;
        3'b010:  ALUCtrl = 4'b1000;
        3'b011:  ALUCtrl = 4'b1001;
        3'b100:  ALUCtrl = 4'b0100;
        3'b101: begin
          if (funct7 == 7'h20) ALUCtrl = 4'b0111;
          else ALUCtrl = 4'b0110;
        end
        3'b110:  ALUCtrl = 4'b0011;
        3'b111:  ALUCtrl = 4'b0010;
        default: ALUCtrl = 4'b1111;
      endcase
    endcase
  end
endmodule
