`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 15:21:48
// Design Name: 
// Module Name: rafreg
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


module rareg(
input clk,
input [31:0] RD1,
input [31:0] RD2,
output reg [31:0] A,
output reg [31:0] writedata
    );
    always @(posedge clk) begin 
    A<= RD1;
    writedata<=RD2;
    end 
endmodule
