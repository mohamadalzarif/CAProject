`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: nbit_mux.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Multiplexer Module, that controls the second input to the ALU.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module nbit_mux#(parameter N=8)(input load,input[N-1:0] D1,input[N-1:0] D2,output[N-1:0] Output);

assign Output = load? D2:D1;

endmodule
