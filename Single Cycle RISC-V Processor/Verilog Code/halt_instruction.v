`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: halt_instruction.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is a Halt Module that takes a stop flag from the specificied instructions and halts the update of the Program Counter
// 
// Change History: 11/5/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module halt_instruction(input rst, stopFlag, output reg load);
always@(*) begin
if(rst)
load = 1'b1;
else if(stopFlag)
load = 1'b0;

end
endmodule

