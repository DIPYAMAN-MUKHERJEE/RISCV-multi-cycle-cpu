`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 15:21:48
// Design Name: 
// Module Name: rafmem2
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


module rafmem2(
input reset,
input clk,
input [31:0] RD,
output reg [31:0] data
    );
    always @( posedge clk) begin
     if (reset)
        data <= 32'd0;
        else 
    data <= RD;
    end 
    
endmodule
