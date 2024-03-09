`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Team Zigma
// Engineer: Nuwan Udara
// 
// Create Date: 04.02.2023 17:27:50
// Design Name: INSTRUCTION MEM
// Module Name: Ins_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Take the PC and send the instruction from memmory to the Instruction Decoder, InDecode module.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Ins_Mem (
    //input clk,
    input [4:0] addr,
    output reg [31:0] instruction
    //output wire [31:0] instruction
);
  reg [31:0] memory[31:0];  //chnage as you like later.

  initial begin
	
	
    memory[0]  = 32'b00000000001100000000000010110011; //add x1, x0, x3
    memory[1]  = 32'b00000000001100000000000010110011; 
    memory[2]  = 32'b00000000001100000000000010110011; 
    memory[3]  = 32'b00000001010110100000100100110011; //add x18, x20, x21
    memory[4]  = 32'b00000001011110110000100010110011; //add x17, x22, x23
    memory[5]  = 32'b00000000000000000000000001101111; //jal x0, 0
    memory[6]  = 32'b0; 
    memory[7]  = 32'b0; 
    memory[8]  = 32'b0;
    memory[9]  = 32'b0;
    memory[10] = 32'h000;
    memory[11] = 32'h000;
    memory[12] = 32'h000;
    memory[13] = 32'h000;
    memory[14] = 32'h000;
    memory[15] = 32'h000;
    memory[16] = 32'h000;
    memory[17] = 32'h0012;
    memory[18] = 32'h0013;
    memory[19] = 32'h0014;
    memory[20] = 32'h0015;
    memory[21] = 32'h0016;
    memory[22] = 32'h0017;
    memory[23] = 32'h0018;
    memory[24] = 32'h0019;
    memory[25] = 32'h001a;
    memory[26] = 32'h001b;
    memory[27] = 32'h001c;
    memory[28] = 32'h001d;
    memory[29] = 32'h0013;
    memory[30] = 32'h001f;
    memory[31] = 32'h0;
	
  end

  // Retriving the instruction code based on the PC count
  //assign instruction = memory[addr[3:0]];
  always @(*) 
  begin
    instruction = memory[addr[4:0]];
  end

endmodule