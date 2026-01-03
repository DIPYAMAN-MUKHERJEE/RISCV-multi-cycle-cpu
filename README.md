# RISCV-multi-cycle-cpu

 This project implements a 32-bit RISC-V multicycle CPU in Verilog HDL.
 The processor follows an FSM-based control design where each instruction
 is executed over multiple clock cycles (Fetch, Decode, Execute, Memory,
 Writeback). Hardware resources such as the ALU and memory are reused across
 cycles, reducing datapath complexity compared to a single-cycle design.

 Architecture:
 -------------
 - ISA            : RV32I (subset)
 - Design Style   : Multicycle (FSM controlled)
 - Datapath       : Shared ALU, unified instruction/data memory
 - Control Unit   : Hardwired FSM
 - Language       : Verilog HDL

 Instruction Execution Model:
 ----------------------------
 Instructions progress through multiple states:
   1. Instruction Fetch
   2. Instruction Decode
   3. Execute / Address Calculation
   4. Memory Access (if required)
   5. Write Back (if required)

 Different instruction types use different subsets of these stages.

 Supported Instructions:
 -----------------------

 R-Type Instructions (opcode: 0110011):
   add   : rd = rs1 + rs2
   sub   : rd = rs1 - rs2
   and   : rd = rs1 & rs2
   or    : rd = rs1 | rs2
   xor   : rd = rs1 ^ rs2
   sll   : rd = rs1 << rs2
   srl   : rd = rs1 >> rs2
   sra   : rd = rs1 >>> rs2
   slt   : rd = (rs1 < rs2)
   sltu  : rd = (rs1 < rs2) unsigned

 I-Type Arithmetic Instructions (opcode: 0010011):
   addi  : rd = rs1 + imm
   andi  : rd = rs1 & imm
   ori   : rd = rs1 | imm
   xori  : rd = rs1 ^ imm
   slti  : rd = (rs1 < imm)
   sltiu : rd = (rs1 < imm) unsigned

 Load Instruction:
   lw (opcode: 0000011)
     rd = Mem[rs1 + imm]

 Store Instruction:
   sw (opcode: 0100011)
     Mem[rs1 + imm] = rs2

 Branch Instruction:
   beq (opcode: 1100011)
     if (rs1 == rs2)
         PC = PC + imm

 FSM States:
 -----------
   S0  : Instruction Fetch
   S1  : Instruction Decode
   S2  : Address Calculation
   S3  : Memory Read
   S4  : Load Writeback
   S5  : Store
   S6  : R-Type Execute
   S7  : ALU Writeback
   S8  : I-Type Execute
   S9  : Branch Compare
   S10 : Branch PC Update

 Major Hardware Blocks:
 ----------------------
 - Program Counter (PC)
 - Register File (32 x 32)
 - ALU
 - Instruction Register (IR)
 - ALUOut Register
 - Data Register (MDR)
 - Immediate Generator
 - Unified Instruction/Data Memory
 - FSM-based Control Unit

 Verification:
 -------------
 - Verified using a custom Verilog testbench
 - FSM state transitions observed via $display
 - Register write operations logged during simulation
 - Memory initialized using .mem file
**References**
