`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: nbit_shift.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Shift Left by 1 Module, that is used to for the shifting of the progrma counter.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module nbit_shift#(parameter N=15)(input[N-1:0] D,output[N-1:0] Output);

assign Output = {D[N-1:0],1'b0};

endmodule