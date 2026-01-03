`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 15:21:48
// Design Name: 
// Module Name: rafmem
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


module rafmem(
input reset,
input clk,
input [31:0] PC,
input IRwrite,
input [31:0] RD,
output reg  [31:0] oldPC,
output reg [31:0] instr
    );
    always @(posedge clk) begin
      if (reset) begin
        instr <= 32'd0;
        oldPC <= 32'd0;
    end 
    else if(IRwrite) begin 
    oldPC<=PC;
    instr<=RD;
    end 
    end 
endmodule
