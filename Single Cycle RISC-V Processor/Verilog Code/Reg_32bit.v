`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: Reg_32bit.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Register Module, consists of a register of size 32 bits.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module Reg_32bit(input [31:0] in, input clk, load, rst, output  [31:0] out);
wire [31:0] connect;
genvar i;
generate
for(i=0; i<32; i=i+1)
begin: Loop
mux_2x1 mymux (out[i],in[i], load, connect[i]);
DFlipFlop myflop (clk, rst,connect[i], out[i]);
end
endgenerate
endmodule
