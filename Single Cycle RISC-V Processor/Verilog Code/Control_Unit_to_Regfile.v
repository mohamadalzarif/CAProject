`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: Control_Unit_to_Regfile.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the RegFile Input Control Unit Module, that is used to control input incoming to the RegFile.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module Control_Unit_to_Regfile#(parameter N=8)(input [N-1:0] ALUOutput, input [N-1:0]Data_Memory_Output, input [N-1:0]PC_Plus_4,input [N-1:0] PC_Plus_Shift, input [1:0] jal, input auipc,MemtoReg,output [N-1:0]Write_Data);

reg [N-1:0] out;
always@(*) begin
if(jal== 2'b10 && !auipc && MemtoReg) //JAL
     out=PC_Plus_4;
 else if(jal== 2'b10 && !auipc&& MemtoReg) //JALR
     out=PC_Plus_4;
 else if(jal== 2'b00 && auipc&& MemtoReg) //AUIPC
          out=PC_Plus_Shift;
 else if(jal== 2'b00 && !auipc && MemtoReg) //Mem_Data
          out=Data_Memory_Output;
 
 
else begin
       out=ALUOutput;
       end
end


assign Write_Data= out;

endmodule
