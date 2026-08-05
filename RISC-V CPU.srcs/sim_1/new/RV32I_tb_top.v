`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2026 02:19:49 PM
// Design Name: 
// Module Name: RV32I_tb_top
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


module RV32I_tb_top ();
  reg clk;
  reg rst;

  RV32I_top u_RV32I_top (
      .clk(clk),
      .rst(rst)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    #20;
    rst = 0;
    #2000;
    $finish;
  end

endmodule
