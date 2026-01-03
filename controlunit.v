
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2025 20:42:17
// Design Name: 
// Module Name: controlunit
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


module controlunit(
input reset,
input clk,
input [31:0] instr,
output reg PCwrite,
output reg adrscr,
output reg memwrite,
output reg IRwrite,
output reg [1:0] resultsrc,
output reg [3:0] ALUControl,
output reg [1:0] ALUsrcA,
output reg [1:0] ALUsrcB,
output reg [1:0] immsrc,
output reg regwrite1,
input zero1
    );

    // so now lets now design the fsm......
   reg [3:0] state,nstate;
   parameter s0=4'b0000;
   parameter s1=4'b0001;
   parameter s2=4'b0010;
   parameter s3=4'b0011;
   parameter s4= 4'b0100;
   parameter s5= 4'b0101;
   parameter s6= 4'b0110;
     parameter s7=4'b0111;
   parameter s8=4'b1000;
   parameter s9=4'b1001;
   parameter s10=4'b1010;
   //parameter s11= 4'b1011;
   //parameter s12= 4'b1100;
   //parameter s13= 4'b1101;
   //parameter s14= 4'b1110;
   //parameter s15= 4'b1111;
   always @(posedge clk) begin 
   if (reset) begin 
   state<= s0;
   end 
   else begin 
   state <= nstate;
   end 
   end 
   
   always @(*) begin
     memwrite   = 1'b0;
  regwrite1  = 1'b0;
  PCwrite    = 1'b0;
  IRwrite    = 1'b0;
  adrscr     = 1'b0;
  ALUsrcA    = 2'b00;
  ALUsrcB    = 2'b00;
  ALUControl = 4'b0000;
  resultsrc  = 2'b00;
  immsrc     = 2'b00;
  nstate     = state; 
   case(state) 
s0: begin
   
   memwrite=1'b0;
   regwrite1=1'b0;
   immsrc=2'b00;// jut giving value though its not needed here 
   adrscr= 1'b0;
   IRwrite= 1'b1;
   ALUsrcA=2'b00;
   ALUsrcB=2'b10;
   ALUControl=4'b0000;
   resultsrc=2'b10;
   PCwrite=1'b1;
   nstate=s1;
   end 
s1: begin  // so this is the decoding stage okay okay isee 
      PCwrite=1'b0;
   memwrite=1'b0;
   regwrite1=1'b0;
   IRwrite= 1'b0;
   ALUsrcA=2'b00;// default type shit no need as i want alu to stop working that time 
   ALUsrcB=2'b00;
   ALUControl=4'b0000;
  
   case (instr[6:0]) 
   7'b0000011: nstate=s2;//lw 
   7'b0100011:nstate=s2;//sw
   7'b0110011: nstate=s6; //Rtype
   7'b0010011:nstate=s8; // rest I type
   7'b1100011: begin 
   immsrc=2'b10;// else idc whats the value of immex
   ALUsrcA=2'b01;
   ALUsrcB=2'b01;
   ALUControl=4'b0000;
    nstate=s9; // beq :)
    end
   endcase
   end 
s2:begin 
   //MemAdr
     PCwrite=1'b0;
   memwrite=1'b0;
   regwrite1=1'b0;
   ALUsrcA=2'b10;
   ALUsrcB=2'b01;
   ALUControl=4'b0000;
   resultsrc=2'b10;
   if(instr[6:0]==7'b0000011) begin 
   nstate=s3;
   immsrc=2'b00;//lw
   end
   if(instr[6:0]==7'b0100011) begin 
   nstate=s5;
   immsrc=2'b01;//sw
   end 
   end 
s3: begin 
        PCwrite=1'b0;
   memwrite=1'b0;
   regwrite1=1'b0;
   immsrc=2'b00;
   IRwrite= 1'b0;
   resultsrc=2'b00;
   adrscr= 1'b1;
   nstate=s4;
   end 
s4: begin 
           PCwrite=1'b0;
   memwrite=1'b0;
   regwrite1=1'b1;
   resultsrc=2'b01;
   adrscr= 1'b1;
   nstate=s0;// again fetching lw is completee:)
   end 
s5:begin
     resultsrc=2'b00; 
   PCwrite=1'b0;
   adrscr= 1'b1;
   memwrite=1'b1;
   IRwrite=1'b0;
   nstate=s0;
   end 
s6: begin 
   ALUsrcA=2'b10;
   ALUsrcB=2'b00; 
       PCwrite=1'b0;
    memwrite=1'b0;
    IRwrite=1'b0;
    regwrite1=1'b0; 
    resultsrc=2'b00;
        case (instr[14:12])
            3'b000: ALUControl = (instr[31:25] == 7'b0100000) ? 4'b0001 : 4'b0000; 
            3'b001: ALUControl = 4'b1010; 
            3'b010: ALUControl = 4'b0101; 
            3'b011: ALUControl = 4'b0110; 
            3'b100: ALUControl = 4'b0111; 
            3'b101: ALUControl = (instr[31:25] == 7'b0100000) ? 4'b1001 : 4'b1000; 
            3'b110: ALUControl = 4'b0011; 
            3'b111: ALUControl = 4'b0010; 
            default: ALUControl = 4'b0000;
        endcase
        nstate=s7;
    end
s7:begin 
    resultsrc=2'b00;
    regwrite1=1'b1;
    PCwrite=1'b0;
    memwrite=1'b0;
    IRwrite=1'b0;
    nstate=s0;
    end 
s8: begin 
    // this is for I type :)
    immsrc=2'b00;
       ALUsrcA=2'b10;
   ALUsrcB=2'b01;
       resultsrc=2'b00;
    PCwrite=1'b0;
    memwrite=1'b0;
    IRwrite=1'b0;
       case(instr[14:12]) 
        3'b000: ALUControl = 4'b0000; 
        3'b111: ALUControl = 4'b0010; 
        3'b110: ALUControl = 4'b0011; 
        3'b010: ALUControl = 4'b0101; 
        3'b011: ALUControl = 4'b0110; 
        3'b100: ALUControl = 4'b0111; 
        default: ALUControl = 4'b0000;
      endcase
      nstate=s7;
    end
s9: begin
  // BEQ execute + decision
  ALUsrcA    = 2'b10;   // rs1
  ALUsrcB    = 2'b00;   // rs2
  ALUControl = 4'b0001; // SUB

  if (zero1)
    PCwrite = 1'b1;
  else
    PCwrite = 1'b0;

  nstate = s0;
end

    
  default : nstate=s0;  
    endcase 
    end 
endmodule
