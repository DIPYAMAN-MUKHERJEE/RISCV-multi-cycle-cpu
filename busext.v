`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 15:11:46
// Design Name: 
// Module Name: extDm
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

module extDm(
input [31:0] inst,
output [4:0] A1,
output [4:0] A2,
output [4:0] A3 ,
input [1:0] immSrc,
output [31:0] immExt

    );
    
    assign A1= inst[19:15];
   assign A2=  inst[24:20];
    assign A3= inst[11:7];
    assign immExt= (immSrc==2'b00)?{{20{inst[31]}},inst[31:20]} : (immSrc==2'b10)?{{20{inst[31]}}, inst[31:25], inst[11:7]}:(immSrc==2'b11)?{{19{inst[31]}},
       inst[31],inst[7],inst[30:25],inst[11:8],1'b0}:32'b000000000000;
    
    
endmodule
