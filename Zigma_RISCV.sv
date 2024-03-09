`timescale 1ns / 1ps
/****************** This is the TOP module*****************/
                           
module Zigma_RISCV(
		 input clk_max,
		 input reset
    );
	  
	wire clk;	//clock after dividing
	Clock_divider clk_div0(
		.clock_in	(clk_max),
		.clock_out	(clk)
	);
    
	wire [31:0] pc_number;
	wire [31:0] data = 32'h0; 	
	wire wren = 0;		/*write diables for instruction memory*/
	wire [31:0]	inst_out_inst_Mem;

	/***********Instruction Memory**********/
	/*implemented in RAM module*/	
	 myTop instr_mem0(
		.address (pc_number[9:0]),
		.clock   (clk_max),
		.data    (data),
		.wren    (wren),
		.q       (inst_out_inst_Mem)
	);
	 
	/**********Instruction Decoder********/
	wire [6:0] inDec_opcode;
	wire [4:0] inDec_rs1Add;
	wire [4:0] inDec_rs2Add;
	wire [ 4:0] inDec_rdAddr;
	wire [ 3:0] inDec_alu_func;
	wire [31:0]  inDec_imm;
 
    inDecode inDec(
      .inst(inst_out_inst_Mem),
      .opcode(inDec_opcode),
      .rsAddr( inDec_rs1Add),
      .rdAddr(inDec_rdAddr),
      .shamt(inDec_rs2Add),
      .alu_func(inDec_alu_func),
      .imm(inDec_imm)
    );  
    
    /****************register bank***********************/
	 wire        regB_write_en;
    wire [31:0] regB_write_data;
    wire [31:0] regB_data1;
    wire [31:0] regB_data2;
	 
    RegBank regBank1(
      .clk(clk),
      .r_addr1(inDec_rs1Add),
      .r_addr2(inDec_rs2Add),
      .w_addr(inDec_rdAddr),
      .write_en(regB_write_en),
		.reset(~reset),
      .write_data(regB_write_data),
      .data1(regB_data1),
      .data2(regB_data2)
    );
	
	//select between register data or immediate data for alu
	wire         inp_ALUSrc_2;
	wire [31:0] inp_AluInput2;
     
	INPUT_SEL input_sel1(
		.ALUSrc1(inp_ALUSrc_2),
		.IMMval(inDec_imm),
		.reg_val(regB_data2),
		.AluInput2(inp_AluInput2)
	 );
 
	wire         inp_ALUSrc1   ;  // ALUSrc is Control unit flag to select the Input, 
	wire  [31:0] inp_1_reg_val;      // If 0, select register out put
	wire [31:0]  inp_AluInput1;
 
	// select between register and pc for alu
	INPUT_SEL_2 input_sel2(
		.ALUSrc2(inp_ALUSrc1),
		.Pc(pc_number),
		.reg_val(regB_data1),
		.AluInput1(inp_AluInput1)
	);
   
	/*************ALU*************************/
	wire[31:0] alu_alu_out;
	wire alu_eq, alu_a_lt_b, alu_a_lt_ub; 
	wire [3:0] alu_ctrl;
    
	alu Alu1(
		.func(alu_ctrl),
		.A(inp_AluInput1),
		.B(inp_AluInput2),
		.alu_out(alu_alu_out),
		.eq(alu_eq),
		.a_lt_b(alu_a_lt_b),
		.a_lt_ub(alu_a_lt_ub)
	);

	/******************* Main contoler ******************/  
	wire  mem_read, mem_write, branch;
	wire [1:0] mem_to_reg, next_pc_sel;
	wire [1:0] alu_op;
  
	main_control mc_0 (
		.opcode			  (inDec_opcode),
		.alu_src_1		(inp_ALUSrc1),
		.alu_src_2		(inp_ALUSrc_2),
		.mem_to_reg		(mem_to_reg),
		.reg_write		(regB_write_en),
		.mem_read		  (mem_read),
		.mem_write	  (mem_write),
		.branch			  (branch),
		.alu_op			  (alu_op),
		.next_pc_sel	(next_pc_sel)
	);
	
	/*******************ALU controler*******************/
	alu_control ac_0 (
			.alu_op			(alu_op),
			.alu_funct		(inDec_alu_func),
			.alu_ctrl		(alu_ctrl)
	);
	
	/*******************Data Memory******************/
	wire [31:0] dat_mem_output;
	
	Data_memory dat_mem(
	  .clk(clk),
	  .Address(alu_alu_out),
	  .Write_data(regB_data2),
	  .MemRead(mem_read),
	  .MemWrite(mem_write),
	  .Read_data(dat_mem_output)
	);

	// Mux for register input selector after the data memmory
	wire [31:0] incr_pc; // use this one in Pc parts

	Multiplexer multi_reg(
	  .Read_data(dat_mem_output),
	  .Address(alu_alu_out),  		/*direct output from ALU*/
	  .PC4(incr_pc),
	  .MemtoReg(mem_to_reg),
	  .mux_out(regB_write_data) //sending to register bank
	);
	
	/********************Program Counter******************/
	PC_full pc_full(
	  .clk(clk),
	  .next_pc_sel(next_pc_sel),
	  .imme(inDec_imm),
	  .jalr(alu_alu_out),
	  .eq(alu_eq),
	  .a_lt_b(alu_a_lt_b),
	  .a_lt_ub(alu_a_lt_ub),
	  .branch(branch),
	  .pc_out(pc_number),
	  .reset(~reset),
	  .pcinc_to_m2(incr_pc)
	);
     
endmodule

