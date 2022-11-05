`timescale 1ns / 1ps
`include "definition.v"
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: ALU.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the ALU Module, that is used to perform operations.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////

module ALU(
	input   wire [31:0] Input1, Input2,
	input   wire [4:0]  shamt,
	output  reg  [31:0] ALU_Output,
	output  wire        cf, zf, vf, sf,
	input   wire [3:0]  ALUOp
);

    wire [31:0] add, op_b;
    
    assign op_b = (~Input2);
    
    assign {cf, add} = ALUOp[0] ? (Input1 + op_b + 1'b1) : (Input1 + Input2);
    wire [31:0] pc_add_imm;
    assign pc_add_imm= (Input1 + Input2);
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (Input1[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] Shifted_Output;
    shifter shifter0(Input1, shamt, ALUOp[1:0], Shifted_Output);
    
    always @ * begin
        ALU_Output = 0;
        (* parallel_case *)
        case (ALUOp)
            // arithmetic
            `ALU_ADD : ALU_Output = add; //true addition
            `ALU_SUB : ALU_Output = add; //true substraction
            `ALU_PASS : ALU_Output = Input1;
            // logic
            `ALU_OR:  ALU_Output = Input1 | Input2; //OR
            `ALU_AND:  ALU_Output = Input1 & Input2; //AND
            `ALU_XOR:  ALU_Output = Input1 ^ Input2; //XOR
            // shift
            `ALU_SRL:  ALU_Output=Shifted_Output; //SRL
            `ALU_SRA:  ALU_Output=Shifted_Output; //SRA
            `ALU_SLL:  ALU_Output=Shifted_Output; //SLL
            // slt & sltu
            `ALU_SLT:  ALU_Output = {31'b0,(sf != vf)}; //SLT
            `ALU_SLTU:  ALU_Output = {31'b0,(~cf)}; //SLTU   
            // JALR & LUI & AUIPC  
            4'b01_10: ALU_Output ={pc_add_imm [31:1],1'b0};   //JALR
            4'b11_10: ALU_Output ={Input2 [31:12],12'b0}; //LUI   	
            4'b11_00: ALU_Output =Input1 + {Input2 [31:12],12'b0}; //AUIPC   	
        endcase
    end
endmodule