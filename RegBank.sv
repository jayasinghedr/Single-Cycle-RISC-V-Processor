`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Team Zigma
// Engineer: Nuwan Udara
// 
// Create Date: 06.02.2023 17:27:45
// Design Name: Tea
// Module Name: RegBank
// Project Name:  
// Target Devices: 
// Tool Versions: 
// Description: Provide a register bank and support Write and Read REgisters
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RegBank(
    input             clk,
    input      [ 4:0] r_addr1,
    input      [ 4:0] r_addr2,
    input      [ 4:0] w_addr,
    input             write_en,
	 input 				reset,
    input      [31:0] write_data,
    output reg [31:0] data1, //to alu directly 
    output reg [31:0] data2 // send to the input selector between imm or reg
    );

    reg [31:0] regs[31:0]; // registers, there are 32 total.
    
   //Initially make all registers 0
    //writing data in the address.

    always @(posedge clk) // will execute on next pc update. same clock 
        begin
		  if (reset) begin
			regs[0]=32'b0;		regs[ 8]=32'b0;	regs[16]=32'b0;	regs[24]=32'b0;	
			regs[1]=32'b0;  	regs[ 9]=32'b0;	regs[17]=32'b0;	regs[25]=32'b0;	
			regs[2]=32'b0;  	regs[10]=32'b0;	regs[18]=32'b0;	regs[26]=32'b0;	
			regs[3]=32'b0;  	regs[11]=32'b0;	regs[19]=32'b0;	regs[27]=32'b0;	
			regs[4]=32'b0;  	regs[12]=32'b0;	regs[20]=32'b0;	regs[28]=32'b0;	
			regs[5]=32'b0;		regs[13]=32'b0;	regs[21]=32'b0;	regs[29]=32'b0;	
			regs[6]=32'b0;  	regs[14]=32'b0;	regs[22]=32'b0;	regs[30]=32'b0;	
			regs[7]=32'b0;  	regs[15]=32'b0;	regs[23]=32'b0;	regs[31]=32'b0;	
		  end
        
        else begin
			  if ((write_en == 1'b1) && (w_addr != 5'b00000)) 
					begin
						 regs[w_addr] = write_data;
			  end
			 end 
        end

    always @(*)
        begin
            data1 = regs[r_addr1];
            data2 = regs[r_addr2];
        end


endmodule
