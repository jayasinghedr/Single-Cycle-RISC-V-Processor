`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Team Zigma
// Engineer: Nwuan Udara
// 
// Create Date: 07.02.2023 20:29:41
// Design Name: 
// Module Name: INPUT_SEL_2
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


module INPUT_SEL_2(
    input         ALUSrc2,       // ALUSrc is Control unit flag to select the Input, 
        input  [31:0] Pc,       // IF 1, select imm value
        input  [31:0] reg_val,      // If 0, select register out put
        output [31:0] AluInput1
        );
    
        assign AluInput1 = ALUSrc2 ? Pc:reg_val;
endmodule
