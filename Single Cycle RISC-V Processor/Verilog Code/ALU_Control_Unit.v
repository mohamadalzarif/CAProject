`timescale 1ns / 1ps
`include "definition.v"
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: ALU_Control_Unit.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the ALU Control Module, that is used to send the select lines for the ALU.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module ALU_Control_Unit(input [2:0] ALUOp, input inst_5,input [2:0] funct3, input inst_30, output reg [3:0] ALU_Sel );
 
 
   
always@(*) begin

 if(ALUOp== 3'b000) begin
case({funct3[2:0],inst_30})
 4'b000x: ALU_Sel=`ALU_ADD; //ADDI
 4'b111x: ALU_Sel=`ALU_AND; //ANDI
 4'b110x: ALU_Sel=`ALU_OR;  //ORI
 //4'b: ALU_Sel=`ALU_PASS;    
 4'b100x: ALU_Sel=`ALU_XOR;  //XORI   
   
 4'b1010: ALU_Sel=`ALU_SRL;  //SRLI 
 4'b1011: ALU_Sel=`ALU_SRA;  //SRAI    
  
 4'b001x: ALU_Sel=`ALU_SLL;  //SLLI      
 4'b010x: ALU_Sel=`ALU_SLT;  //SLTI   
 4'b011x: ALU_Sel=`ALU_SLTU; //SLTUI  
   
   default: ALU_Sel=4'b1111;
  endcase
  end
 else if(ALUOp== 3'b001)
 ALU_Sel=  `ALU_ADD; //L and S
  else if(ALUOp== 3'b101)
 ALU_Sel=  `ALU_SUB; //Branch
 else if(ALUOp== 3'b010)
 ALU_Sel=  4'b0110; //JALR

 else if(ALUOp== 3'b011) begin
 if(inst_5)
  ALU_Sel=  4'b1110; //LUI
  else
  ALU_Sel=  4'b1100; //AUIPC
  end
 else if(ALUOp== 3'b100)begin
 case({funct3[2:0],inst_30})
  4'b0000: ALU_Sel=`ALU_ADD; //ADD
  4'b0001: ALU_Sel=`ALU_SUB; //SUB
  4'b1110: ALU_Sel=`ALU_AND; //AND
  4'b1100: ALU_Sel=`ALU_OR;  //OR
  //4'b: ALU_Sel=`ALU_PASS;    
  4'b1000: ALU_Sel=`ALU_XOR;  //XOR     
  4'b1010: ALU_Sel=`ALU_SRL;  //SRL   
  4'b1011: ALU_Sel=`ALU_SRA;  //SRA     
  4'b0010: ALU_Sel=`ALU_SLL;  //SLL      
  4'b0100: ALU_Sel=`ALU_SLT;  //SLT   
  4'b0110: ALU_Sel=`ALU_SLTU; //SLTU      
  
  default: ALU_Sel=4'b1111;
 endcase
 end
 end
 
endmodule