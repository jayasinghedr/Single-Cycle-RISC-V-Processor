`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Movindi Mathotaarachchi
// 
// Create Date: 02/07/2023 11:01:55 AM
// Design Name: Data Memory 
// Module Name: Multiplexer
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


module Multiplexer(
    input [31:0] Read_data,
    input [31:0] Address,
    input [31:0] PC4,
    input [1:0] MemtoReg,
    output reg [31:0] mux_out
    );
    
    always @(*) begin
        case (MemtoReg)
          2'b00: mux_out = Address;
          2'b01: mux_out = Read_data;
          2'b11: mux_out = PC4;
          default: mux_out = 32'b0;
        endcase
    end
endmodule
