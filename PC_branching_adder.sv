`timescale 1ns / 1ps

module adder(
    input [31:0] PC_current,
    input [31:0] imm,
    output [31:0] branched_PC
    );

assign branched_PC=PC_current+imm; //add PC and immediate (assumed imm incremented by 4)

endmodule