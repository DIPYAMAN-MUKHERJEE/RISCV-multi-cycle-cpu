`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 10:53:04
// Design Name: 
// Module Name: riscmulticycle
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


module riscmulticycle(
input clk,
input reset
    );
    wire [31:0] instr;
wire PCwrite;
wire adrscr;
wire memwrite;
wire IRwrite;
wire [1:0] resultsrc;
wire[3:0] ALUControl;
wire [1:0] ALUsrcA;
 wire [1:0] ALUsrcB;
wire [1:0] immsrc;
wire regwrite1;
wire zero1;
    controlunit cu (.reset(reset),.clk(clk),.instr(instr),.PCwrite(PCwrite),.adrscr(adrscr),.memwrite(memwrite),.IRwrite(IRwrite),.resultsrc(resultsrc),.ALUControl(ALUControl),.ALUsrcA(ALUsrcA),.ALUsrcB(ALUsrcB),.immsrc(immsrc),.regwrite1(regwrite1),.zero1(zero1));
    completehardware1 ch1 (.reset(reset),.clk(clk),.PCwrite(PCwrite),.Adrsrc(adrscr),.Memwrite(memwrite),.IRwrite(IRwrite),.ALUsrcA(ALUsrcA),.ALUsrcB(ALUsrcB),.ALUcontrol(ALUControl),.instr(instr),.Resultsrc(resultsrc),.immsrc(immsrc),.Regwrite(regwrite1),.zero1(zero1));
endmodule
