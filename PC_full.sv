module PC_full(
    input clk,                 //clock
    input [1:0] next_pc_sel,   //select jal, jalr,branch pc
    input [31:0] imme,         // 32bit immediate
    input [31:0] jalr,         //jalr
    input eq,                 // equal flag
    input a_lt_b,             // less than flag
    input a_lt_ub,            // less than unsigned flag
    input branch,             //branching ctrl
    input reset,
    output [31:0] pc_out,      //PC out
	 output [31:0] pcinc_to_m2
);


wire [31:0] m4_to_pc;
//wire [31:0] pcinc_to_m2;
wire [31:0] br_adder_to_m2;
wire f_logic_to_m2;
wire [31:0] m2_to_m4;

PC pc(
    .clk(clk),
    .reset(reset),
    .pc_in(m4_to_pc),
    .pc_out(pc_out));


PC_incrementor pc_in(
    .pc_in(pc_out),
    .pc_out(pcinc_to_m2)
	 );

adder adder(
    .PC_current(pc_out),
    .imm(imme),
    .branched_PC(br_adder_to_m2));

flag_logic fl(
    .eq(eq),
    .lt(a_lt_b),
    .ltu(a_lt_ub),
    .branch(branch),
    .branch_flag(f_logic_to_m2));


mux mux2(
    .in0(pcinc_to_m2),
    .in1(br_adder_to_m2),
    .sel(f_logic_to_m2),
    .out(m2_to_m4));

mux_4 mux4(
    .jal(imme),
    .br_pc(m2_to_m4),
    .jalr(jalr),
    .sel(next_pc_sel),
    .y(m4_to_pc)
);

endmodule