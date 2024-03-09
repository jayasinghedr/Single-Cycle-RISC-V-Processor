`timescale 1ns / 1ps

module PC_incrementor(
    input [31:0] pc_in,
    output [31:0] pc_out
    );

assign pc_out=pc_in+32'b00000000000000000000000000000001;  //increment PC val by 1

endmodule
