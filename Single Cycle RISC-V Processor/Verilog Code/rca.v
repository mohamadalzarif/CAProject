`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: rca.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Ripple Carry Adder Module, that is used for the shifting and incrementing of the PC.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module rca(input[31:0]A,input[31:0] B, output[31:0] sum);


assign sum =A+B;



 
endmodule
