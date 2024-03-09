`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Movindi Mathotaarachchi
// 
// Create Date: 02/07/2023 05:28:18 PM
// Design Name: Data memory
// Module Name: Data_memory
// Project Name: RISC-V processor design
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


module Data_memory(
	 input clk,
    input [31:0] Address,
    input [31:0] Write_data,
    input MemRead,
    input MemWrite,
    output reg [31:0] Read_data
    );
    
  	reg [31:0] mem [1023:0]; // 1024 32-bit words of memory
  
  
  	initial begin
      for (int i = 0; i < 1024; i++)
      begin
      	mem[i] = 0;
      	end
      	//mem[6] =32'b11101;
      	
    end
    
  always @(*)
    begin
    	if (MemRead == 1) begin
        	Read_data = mem[Address[9:0]];
      	end
    end

  always @(posedge clk) 
    begin
      if (MemWrite == 1) begin
        mem[Address[9:0]] <= Write_data;
      end
    
    end 
endmodule
