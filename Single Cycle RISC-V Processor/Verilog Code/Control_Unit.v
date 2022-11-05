`timescale 1ns / 1ps
`include "definition.v"
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: Control_Unit.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Control unit Module, that is used to pass on the Slecetion Lines to respective modules.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module Control_Unit(input [4:0]Opcode,output Branch, output MemRead,output MemtoReg,output[2:0]ALUOp,output MemWrite,output ALUSrc,output RegWrite,output[1:0]jal,output stopflag, output auipc );

reg [12:0] out;
always@(*)
begin
case(Opcode) 
`OPCODE_Arith_R: out=13'b0001000010000;
`OPCODE_Load:    out=13'b0110010110000;
`OPCODE_Store:   out=13'b0000011100000;
`OPCODE_Branch:  out=13'b1001010000000;
`OPCODE_Arith_I: out=13'b0000000110000;
`OPCODE_JAL:     out=13'b0000101111000;
`OPCODE_JALR:    out=13'b0000101111100;
`OPCODE_LUI:     out=13'b0000110110000;
`OPCODE_AUIPC:   out=13'b0010111111001;
`OPCODE_SYSTEM:  out=13'b0000000000010;
`OPCODE_Custom:  out=13'b0000000000010;

default:         out=13'b000000000000;
endcase
end
assign{Branch, MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,jal,stopflag,auipc}=out;

endmodule
