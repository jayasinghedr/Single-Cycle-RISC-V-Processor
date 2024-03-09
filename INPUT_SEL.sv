`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Team Zigma
// Engineer: Nuwan Udara
// 
// Create Date: 02.02.2023 18:59:48
// Design Name: Input selector
// Module Name: INPUT_SEL
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Select the input to the ALU from either Register bank or Imm
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module INPUT_SEL(
    input         ALUSrc1,       // ALUSrc is Control unit flag to select the Input, 
    input  [31:0] IMMval,       // IF 1, select imm value
    input  [31:0] reg_val,      // If 0, select register out put
    output [31:0] AluInput2
    );

    assign AluInput2 = ALUSrc1 ? IMMval:reg_val;

endmodule
