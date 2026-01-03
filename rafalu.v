`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 15:21:48
// Design Name: 
// Module Name: rafalu
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


module rafalu(
input reset,
input clk,
input [31:0] ALUresult,
output reg [31:0] ALUout
    );
    always @(posedge clk) begin
    if (reset) begin 
    ALUout<=32'b0;
    end 
    else begin 
    ALUout <= ALUresult;
    end 
    end
endmodule
