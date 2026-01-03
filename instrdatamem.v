`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 14:42:36
// Design Name: 
// Module Name: instrdatamem
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


module instrdatamem(
input memwrite,
input clk,
input [31:0] A,
input [31:0] WD,
output  [31:0] RD 
    );
    reg [31:0] dtinsmem [0:2047];
    initial begin 
    $readmemh("multimemory.mem", dtinsmem);
    end 
    assign RD = dtinsmem[A>>2];
    always @(posedge clk) begin 
    if(memwrite) begin 
    dtinsmem[A>>2] <= WD;
    
    end 
    end
endmodule
