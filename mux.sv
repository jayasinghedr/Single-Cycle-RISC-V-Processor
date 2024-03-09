`timescale 1ns / 1ps

module mux(
    input [31:0] in0,
    input [31:0] in1,
    input sel,
    output [31:0] out
    );

assign out=sel?in1:in0;   //if sel is 1, choose in1 else choose in0

endmodule