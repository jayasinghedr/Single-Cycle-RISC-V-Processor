`timescale 1ns / 1ps

module main_control(	input [6:0]			opcode,
							output reg			alu_src_1,
							output reg			alu_src_2,
							output reg[1:0]	mem_to_reg,
							output reg			reg_write,
							output reg			mem_read,
							output reg			mem_write,
							output reg			branch,
							output reg[1:0]	alu_op,
							output reg[1:0]	next_pc_sel
							);

	always @ (*) begin
		if (opcode == 7'b0110011) begin
			/*Control signals for R-type & I-type(immediate)*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b0;
			mem_to_reg 		= 2'b00;
			reg_write 		= 1'b1;
			mem_read			= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b10;
			next_pc_sel		= 2'b00;
		end else if (opcode == 7'b0010011) begin	
			/*I-type(immediate)*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b1;
			mem_to_reg 		= 2'b00;
			reg_write 		= 1'b1;
			mem_read			= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b10;
			next_pc_sel		= 2'b00;
		end else if (opcode == 7'b0000011) begin
			/*Control signals for I-type(load)*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b1;
			mem_to_reg 		= 2'b01;
			reg_write 		= 1'b1;
			mem_read			= 1'b1;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b00;
			next_pc_sel		= 2'b00;
		end else if (opcode == 7'b0100011) begin
			/*Control signals for S-type*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b1;
			mem_to_reg 		= 2'b00;	/*don't care*/
			reg_write 		= 1'b0;
			mem_read		= 1'b0;
			mem_write		= 1'b1;
			branch			= 1'b0;
			alu_op			= 2'b00;
			next_pc_sel		= 2'b00;
		end else if (opcode == 7'b1100011) begin
			/*Control signals for SB-type*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b0;
			mem_to_reg 		= 2'b00;
			reg_write 		= 1'b0;
			mem_read		= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b1;
			alu_op			= 2'b01;
			next_pc_sel		= 2'b00;
		end else if (opcode == 7'b1101111) begin
			/*JAL instrution (UJ-type)*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b0;
			mem_to_reg 		= 2'b11;
			reg_write 		= 1'b1;
			mem_read		= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b11; 
			next_pc_sel		= 2'b01;
		end else if (opcode == 7'b1100111) begin
			/*JALR instruction (I-type)*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b1;
			mem_to_reg 		= 2'b11;
			reg_write 		= 1'b1;
			mem_read		= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b11; 
			next_pc_sel		= 2'b10;
		end else if (opcode == 7'b0110111) begin
			/*LUI instruction (U-type)*/
			alu_src_1 		= 1'b0;
			alu_src_2		= 1'b1;
			mem_to_reg 		= 2'b00;
			reg_write 		= 1'b1;
			mem_read		= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b11; 
			next_pc_sel		= 2'b00;
		end else if (opcode == 7'b0010111) begin
			/*AUIPC instuction (U-type)*/
			alu_src_1 		= 1'b1;
			alu_src_2		= 1'b1;
			mem_to_reg 		= 2'b00;
			reg_write 		= 1'b1;
			mem_read		= 1'b0;
			mem_write		= 1'b0;
			branch			= 1'b0;
			alu_op			= 2'b11;
			next_pc_sel		= 2'b00;
		end else begin
			/*Keep high impedence for any other input*/
			alu_src_1 		= 1'bz;
			alu_src_2		= 1'bz;
			mem_to_reg 		= 2'bzz;
			reg_write 		= 1'bz;
			mem_read			= 1'bz;
			mem_write		= 1'bz;
			branch			= 1'bz;
			alu_op			= 2'bzz;
			next_pc_sel		= 2'bzz;
		end
	end
endmodule
	