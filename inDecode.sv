`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Team Zigma
// Engineer: Nuwan Udara
// 
// Create Date: 31.01.2023 18:07:12
// Design Name: 
// Module Name: inDecode
// Project Name: 
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



module inDecode (
    input      [31:0] inst,
    output reg [ 6:0] opcode,
    output reg [ 4:0] rsAddr,    //rs1
    output reg [ 4:0] rdAddr,    //rd
    output reg [ 4:0] shamt,     //SHIFT VAL AND RS2
    output reg [ 3:0] alu_func,  // FOR ALU_contoller func_3 + 1 bit for add sub chnage like things
    output reg [31:0] imm        // i TYPE  imm and branching
    //output reg [31:0] label    // for braching
);

  always @(*) begin
    opcode = inst[6:0];  //Opcode is always the first 7 bits

    if(opcode==7'b0110011)        //Arithmetic and Shift Operations
		begin
      rsAddr   = inst[19:15];
      rdAddr   = inst[11:7];
      shamt    = inst[24:20];
      alu_func = {inst[30], inst[14:12]};  //only for R instructions need inst[1],0
      imm      = 32'b0;
      //label    = 32'b0;
    end

	else if(opcode==7'b0010011)   //Immediate Operations
		begin
      rsAddr   = inst[19:15];
      rdAddr   = inst[11:7];
      shamt    = 5'b00000;  // no need second address
      alu_func = {1'b0, inst[14:12]};  // no need for a sign bit from function 7
      imm      = $signed(inst[31:20]);
      //label    = 32'b0;  //only for U and UJ
    end
	else if(opcode==7'b0000011)   //Load Operations only using LW still pass function_3, this is basicly a I nstruction
		begin
      rsAddr   = inst[19:15];  //rs1
      rdAddr   = inst[11:7];  //rd
      shamt    = 5'b00000;  // no need second address
      alu_func = {1'b0, inst[14:12]};  // no need for a sign bit from function 7
      imm      = $signed(inst[31:20]);  //immediate value sign extended
      // label    = 32'b0;  // no need for this, only used in U and UJ
    end
    
    else if(opcode==7'b0100011)   //Store Operations Only Store Word, SW S instrucctions
		begin
      rsAddr   = inst[19:15];  //rs1
      rdAddr   = 5'b00000;    //inst[23:19]; // will be used to take from the ALU result, if rdAddr =0, use write address from ALU result
      shamt    = inst[24:20];  // We need this
      alu_func = {1'b0, inst[14:12]};
      imm      = $signed({inst[31:25], inst[11:7]});  // MSB and LSM in order
      // label    = 32'b0;  //No need this

    end

	else if(opcode==7'b1100011)    //Branch/Jump Operations   //BEQ, BLT, BLTU, BNE, SB; "B" instructions
		begin
      rsAddr   = inst[19:15];  // rs1 adddress
      rdAddr   = 5'b0;
      shamt    = inst[24:20];
      alu_func = {1'b0, inst[14:12]};
      imm      = $signed({ inst[31], inst[7], inst[30:25], inst[11:8], 1'b0});
      // label    = 32'b0;
    end

	else if(opcode==7'b1101111)    //J - JAL
		begin
      rsAddr   = 5'b0;
      rdAddr   = inst[11:7];
      shamt    = 5'b0;
      alu_func = 4'b0;
      imm      = {inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};  // will be sign extended
      // imm      = 32'b0;
      // label    = {inst[31], inst[19:12], imm[20], imm[30:21], 1'b0};  // will be sign extended
    end

    else if(opcode==7'b1100111)    //I-type  JALR
		begin
      rsAddr   = inst[19:15];
      rdAddr   = inst[11:7];
      shamt    = 5'b00000;  // no need second address
      alu_func = {1'b0, inst[14:12]};  // no need for a sign bit from function 7
      imm      = $signed(inst[31:20]);
      // label    = 32'b0;  //only for U and UJ
    end
    
    else if(opcode==7'b0110111)    //Upper LUI
		begin
      rsAddr   = 5'b0;
      rdAddr   = inst[11:7];
      shamt    = 5'b0;
      alu_func = 4'b0;
      imm      = $signed({inst[31:12], 12'b0});
      // imm      = 32'b0;
      // label    = $signed({inst[31:12], 12'b0});
    end
    
    else if(opcode==7'b0010111)    //Upper AUIPC
		begin
      rsAddr   = 5'b0;
      rdAddr   = inst[11:7];
      shamt    = 5'b0;
      alu_func = 4'b0;
      imm      = $signed({inst[31:12], 12'b0});
      // imm      = 32'b0;
      // label    = $signed({inst[31:12], 12'b0});
    end
    
    else  //invalid instruction/empty instruction: make everything 0
    begin
      rsAddr   = 5'b0;
      rdAddr   = 5'b0;
      shamt    = 5'b0;
      alu_func = 4'b0;
      imm      = 32'b0;
      //label    = 32'b0;
    end
  end

endmodule
