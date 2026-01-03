`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2025 19:24:22
// Design Name: 
// Module Name: completehardware
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


module completehardware1(
input clk,
input reset,
input PCwrite,
input Adrsrc,
input Memwrite,
input IRwrite,
input [1:0] ALUsrcA,
input [1:0] ALUsrcB,
input [1:0] Resultsrc,
input [1:0] immsrc,
input Regwrite,
input [3:0] ALUcontrol,
output [31:0] instr,
output zero1
    );
    wire [31:0]PC;
    wire [31:0] result;
    
   
    PC1 pc(.reset(reset),.clk(clk),.PCwrite(PCwrite),.PCnext(result),.PC(PC));
    reg  [31:0] adr;
    wire [31:0] ADR;
     always @(*) begin 
    if(Adrsrc) begin 
    adr = result;
    end 
    else begin 
    adr = PC;
    end 
    end 
    assign ADR =adr;
    wire [31:0] WD,oldPC;
    wire [31:0] readdata,RD1,RD2;
    wire [31:0] data;
    wire [31:0] A,A1,A2,A3,immExt;
    wire [31:0] ALUresult;
     wire [31:0] srcA,srcB;
    reg [31:0] ssrcA,ssrcB;
    reg[31:0] Result;
    wire [31:0] ALUout;
    instrdatamem taste(.memwrite(Memwrite),.clk(clk),.A(ADR),.WD(WD),.RD(readdata));
    rafmem rafmem(.reset(reset),.clk(clk),.PC(PC),.IRwrite(IRwrite),.RD(readdata),.oldPC(oldPC),.instr(instr));
    rafmem2 rafmem2(.reset(reset),.clk(clk),.RD(readdata),.data(data));
    extDm extDm(.inst(instr),.A1(A1),.A2(A2),.A3(A3),.immSrc(immsrc),.immExt(immExt));
    registerfile rgb(.clk(clk),.A1(A1),.A2(A2),.A3(A3),.WD3(result),.WE(Regwrite),.RD1(RD1),.RD2(RD2));
    rareg rareg(.clk(clk),.RD1(RD1),.RD2(RD2),.A(A),.writedata(WD));   
    always @(*) begin 
    case(ALUsrcA) 
    2'b00: ssrcA=PC;
    2'b01: ssrcA=oldPC;
    2'b10: ssrcA= A;
    default: ssrcA=PC;
    endcase 
    end 
      always @(*) begin 
    case(ALUsrcB) 
    2'b00: ssrcB=WD;
    2'b01: ssrcB=immExt;
    2'b10: ssrcB= 32'd4;
    default: ssrcB=32'b0;
    endcase 
    end 
    assign srcA=ssrcA;
    assign srcB= ssrcB;    
    ALU ALU1(.ALUcontrol(ALUcontrol),.srcA(srcA),.srcB(srcB),.zero1(zero1),.ALUresult(ALUresult));    
    rafalu rafalu(.reset(reset),.clk(clk),.ALUresult(ALUresult),.ALUout(ALUout));
    always @(*) begin 
    case(Resultsrc)
    2'b00: Result=ALUout;
    2'b01: Result=data;
    2'b10: Result=ALUresult;
    default: Result=ALUout;
    endcase
    end 
    assign result=Result;
endmodule
