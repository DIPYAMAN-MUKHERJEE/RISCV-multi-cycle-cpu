
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 13:02:13
// Design Name: 
// Module Name: tb_riscmulticycle
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


`timescale 1ns/1ps

module tb_riscmulticycle;

    reg clk;
    reg reset;

    // DUT
    riscmulticycle uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        reset = 1;
        #10;
        reset = 0;
    end

    // Run simulation
    initial begin
        $display("=== Multicycle RISC-V Simulation Start ===");
        #600;

        $display("Simulation finished");
        $stop;
    end


    // This helps you see which state the FSM is in during the error
    always @(uut.cu.state) begin
        case(uut.cu.state)
            4'b0000: $display("%t | State: FETCH", $time);
            4'b0001: $display("%t | State: DECODE", $time);
            4'b0010: $display("%t | State: MEM ADDR", $time);
            4'b0011: $display("%t | State: MEM READ", $time);
            4'b0100: $display("%t | State: WRITEBACK", $time);
            4'b0110:$display("%t | State: MEM ADDR", $time);
            4'b0111: $display("%t | State: WRITEBACK", $time);
            4'b1000:$display("%t | State: MEM ADDR", $time);
            // Add other states as needed
        endcase
    end
endmodule

