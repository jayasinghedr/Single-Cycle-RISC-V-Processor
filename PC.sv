`timescale 1ns / 1ps

module PC(
	input clk,
	input reset, //reset
    input [31:0] pc_in,
    output reg [31:0] pc_out
    );

initial begin
	pc_out<=0;
	end
	
always @(posedge clk)      //Assigns pc_out equal to pc_in at every clock cycle
	begin
		if(reset==1)
		begin
			pc_out<=0;
		end
		else
		begin
			pc_out<=pc_in;
		end          
	end

endmodule