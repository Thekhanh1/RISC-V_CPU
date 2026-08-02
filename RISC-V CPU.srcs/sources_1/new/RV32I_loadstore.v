`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2026 08:14:52 PM
// Design Name: 
// Module Name: RV32I_loadstore
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


module RV32I_loadstore (
    input [31:0] aluResult,
    input [31:0] rd2,
    input [31:0] readData,
    input [31:0] instr,

    output reg [31:0] dataWrite,
    output reg [31:0] loadResult
);

  wire [1:0] addr = aluResult[1:0];
  wire [2:0] funct3 = instr[14:12];

  always @(*) begin
    case (funct3)
      3'b000: begin
        dataWrite = readData;
        case (addr)
          2'b00: dataWrite[7:0] = rd2[7:0];
          2'b01: dataWrite[15:8] = rd2[7:0];
          2'b10: dataWrite[23:16] = rd2[7:0];
          2'b11: dataWrite[31:24] = rd2[7:0];
        endcase
      end
      3'b001: begin
        dataWrite = readData;
        if (addr[1] == 1'b0) dataWrite[15:0] = rd2[15:0];
        else dataWrite[31:16] = rd2[15:0];
      end
      default: dataWrite = rd2;
    endcase
  end

  wire [31:0] shifted = readData >> (addr * 8);
  always @(*) begin
    case (funct3)
      3'b000:  loadResult = {{24{shifted[7]}}, shifted[7:0]};
      3'b001:  loadResult = {{16{shifted[15]}}, shifted[15:0]};
      3'b010:  loadResult = readData;
      3'b100:  loadResult = {24'b0, shifted[7:0]};
      3'b101:  loadResult = {16'b0, shifted[15:0]};
      default: loadResult = readData;
    endcase
  end

endmodule
