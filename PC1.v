`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 14:37:57
// Design Name: 
// Module Name: PC1
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


module PC1(
input reset,
input clk ,
input PCwrite,
input [31:0] PCnext,
output reg [31:0] PC
    );
    always @(posedge clk) begin 
    if(reset) begin 
    PC<=0;
    end 
    else if(PCwrite) begin 
    PC <=PCnext;
    end 
 
    end  
endmodule
