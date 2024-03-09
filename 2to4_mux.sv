module mux_4(
    input [31:0] jal,
    input [31:0] br_pc,
    input [31:0] jalr,
    input [1:0] sel,
    output reg [31:0] y
    );

   always @(*) begin
      case (sel)
         2'b00: y = br_pc;
         2'b01: y = jal;
         2'b10: y = jalr;
      endcase
   end
endmodule