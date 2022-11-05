`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: InstMem.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Instruction Memory Module, that is used to contain the program instructions.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////

module InstMem (input [5:0] addr, output  [31:0]  data_out);
 reg [31:0] mem [0:63];
 assign data_out = mem[addr];
 initial begin
 
 
end 


endmodule