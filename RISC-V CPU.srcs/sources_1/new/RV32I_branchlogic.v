`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 04:16:43 PM
// Design Name: 
// Module Name: RV32I_branchlogic
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


module RV32I_branchlogic (
    input branch,
    input zero,
    input less,
    input lessU,
    input [2:0] funct3,
    input [1:0] jump,
    output reg [1:0] pcSrc
);
  wire branchTaken = (funct3 == 3'b000) ?  zero :
                      (funct3 == 3'b001) ? ~zero :
                      (funct3 == 3'b100) ?  less :
                      (funct3 == 3'b101) ? ~less :
                      (funct3 == 3'b110) ?  lessU :
                      (funct3 == 3'b111) ? ~lessU :
                      1'b0;

  always @(*) begin
    case (jump)
      2'b01:   pcSrc = 2'b01;
      2'b10:   pcSrc = 2'b10;
      default: pcSrc = (branch && branchTaken) ? 2'b01 : 2'b00;
    endcase
  end
endmodule
