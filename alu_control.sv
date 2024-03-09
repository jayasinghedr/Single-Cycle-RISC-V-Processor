`timescale 1ns / 1ps

module alu_control (	input	[1:0]			alu_op,
						input	[3:0]			alu_funct,
						output reg	[3:0]		alu_ctrl);
	
	wire	[5:0]	temp;

	assign temp = {alu_op, alu_funct};

	always @(*) begin
		if (temp == 6'b10_0000 | temp == 6'b00_0010 | temp == 6'b11_0000) begin
			/* ADD for add, addi, lw, sw instructions */
			alu_ctrl = 4'b0000;

		end else if (temp == 6'b10_1000) begin
			/* SUB */
			alu_ctrl = 4'b0001;

		end else if (temp == 6'b01_0001) begin
			/* SLL */
			alu_ctrl = 4'b0010;

		end else if (temp == 6'b10_0010) begin
			/* SLT -> slt & slti*/
			alu_ctrl = 4'b0011;

		end else if (temp == 6'b10_0011) begin
			/* ALU SLTU */
			alu_ctrl = 4'b0100;

		end else if (temp == 6'b10_0100) begin
			/* XOR */
			alu_ctrl = 4'b0101;

		end else if (temp == 6'b10_0101) begin
			/* SRL */
			alu_ctrl = 4'b0110;

		end else if (temp == 6'b10_1101) begin
			/* SRA */
			alu_ctrl = 4'b0111;

		end else if (temp == 6'b10_0110) begin
			/* OR */
			alu_ctrl = 4'b1000;

		end else if (temp == 6'b10_0111) begin
			/* AND */
			alu_ctrl = 4'b1001;

		end else if (temp == 6'b01_0000) begin
			/* BEQ */
			alu_ctrl = 4'b1011;

		end else if (temp == 6'b01_0100) begin
			/* BLT */
			alu_ctrl = 4'b1100;

		end else if (temp == 6'b01_0110) begin
			/* BLTU */
			alu_ctrl = 4'b1101;

		end else begin
			alu_ctrl = 4'bzzzz;
		end
	end	
endmodule
