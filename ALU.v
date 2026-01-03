`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 15:13:01
// Design Name: 
// Module Name: ALU
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


module ALU(
input wire [3:0]  ALUcontrol,
input [31:0] srcA,
input [31:0] srcB,
output zero1,
output reg [31:0] ALUresult
    );


 //wire [2:0] ALUcontrol= 000;
 always @(*) begin 
 case (ALUcontrol) 
    4'b0000: ALUresult = srcA+srcB;
    4'b0001: ALUresult= srcA- srcB;
    4'b0010: ALUresult= srcA & srcB;
    4'b0011: ALUresult = srcA | srcB;
    4'b0101: ALUresult  = ($signed(srcA) < $signed(srcB)) ? 32'd1 : 32'd0;
    4'b0110: ALUresult = (srcA < srcB) ? 32'd1 : 32'd0;
    4'b0111:ALUresult= srcA ^ srcB;
    4'b1000: ALUresult = srcA>>srcB[4:0];
    4'b1001: ALUresult = $signed(srcA)>>>srcB[4:0];
    4'b1010:ALUresult = srcA<<srcB[4:0];
    default: ALUresult=32'b0; 
    endcase 
    end 
    assign zero1 = (ALUresult==32'b0);
endmodule
