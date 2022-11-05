`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: Branch_Control_Unit.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Branch Control Unit Module, that is used for generating signals based on multiple branch instructions.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module Branch_Control_Unit(input Branch, input [2:0] funct3,  input Carry_Flag, Zero_Flag, Overflow_Flag, Sign_Flag , output Control_Unit_Output );
reg out;
always@(*) begin
if(Branch && funct3== 3'b000)begin //BEQ
 if(Zero_Flag)
    out=1;
 else
    out=0;
 end
 else if(Branch && funct3== 3'b001)begin //BNE
  if(Zero_Flag)
     out=0;
  else
     out=1;
  end
 
 else if(Branch &&funct3== 3'b100)begin //BLT
 if(Overflow_Flag != Sign_Flag)
        out=1;
     else
        out=0;
    end
 
 else if(Branch &&funct3== 3'b101)begin //BGE
   if(Overflow_Flag == Sign_Flag)
       out=1;
    else
       out=0;
   end
 
 else if(Branch && funct3== 3'b110)begin //BLTU
    if(~Carry_Flag)
        out=1;
     else
        out=0;
    end
 
 else if(Branch && funct3== 3'b111)begin //BGEU
     if(Carry_Flag)
         out=1;
      else
         out=0;
     end
 
 
else begin
       out=0;
       end
end


assign Control_Unit_Output= out;
endmodule
