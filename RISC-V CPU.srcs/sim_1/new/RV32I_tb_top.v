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
  reg clk = 0;
  reg rst = 1;

  RV32I_top u_RV32I_top (
      .clk(clk),
      .rst(rst)
  );

  always #5 clk = ~clk;

  initial begin
    rst = 1;
    #20;
    rst = 0;

    #200000;
    $display("RESULT: TIMEOUT (ecall was never reached)");
    $finish;
  end

  // ECALL Detection Logic
  always @(posedge clk) begin
    if (!rst && u_RV32I_top.u_RV32I_core.instr == 32'h00000073) begin
      // #1 delta delay to avoid clock edge race conditions when reading register file
      #1;
      if (u_RV32I_top.u_RV32I_core.u_RV32I_datapath.u_RV32I_regfile.registers[3] == 1) begin
        $display("RESULT: PASS");
      end else begin
        $display("RESULT: FAIL gp=%0d",
                 u_RV32I_top.u_RV32I_core.u_RV32I_datapath.u_RV32I_regfile.registers[3]);
      end
      $finish;
    end
  end

endmodule
