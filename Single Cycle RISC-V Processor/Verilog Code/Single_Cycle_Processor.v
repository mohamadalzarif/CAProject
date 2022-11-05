`timescale 1ns / 1ps
`include "definition.v"
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: Single_Cycle_Processor.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is a single cycled non pipelined implementation of a RISC-V Processor
// 
// Change History: 11/3/2022 - Fixed namings according to Coding Guidelines.
//                 11/4/2022 - Added Branch Control Unit, Fixed Wirings.
//                 11/4/2022 - Implemented Immediate and Shift Instructions.
//                 11/5/2022 - Implemented JAL, AUIPC, LUI instructions.
//                 11/5/2022 - Implemented Load and Store Instructions.
//                 11/5/2022 - Fixed bugs and wrong wirings.
//////////////////////////////////////////////////////////////////////////////////


module Single_Cycle_Processor(input clk,rst,output reg [15:0] leds,output [3:0] Anode,output [6:0] LED_out,input [3:0] ssd_sel,input [1:0] led_sel, input clock_ssd );

parameter N=32;
wire [31:0] Instruction;
wire [31:0] PC;
wire [31:0] MUX_to_PC;
wire [31:0] PC_Plus_4;
wire [31:0] PC_Plus_Shift;
wire Branch, MemRead,MemtoReg;
wire Zero_Flag;
wire [31:0] Shifted_Output_to_Adder;
wire MemWrite,ALUSrc,RegWrite; 
wire Branch_Control_Unit_Output;
wire [1:0]jal;
wire [31:0] ALUOutput;
wire load;
wire Stop_Flag;
halt_instruction halt_ebreak(rst, Stop_Flag, load);
Reg_32bit PC_Reg(MUX_to_PC,  clk, load, rst, PC);
rca PC_Add_4(PC,4,PC_Plus_4);
rca PC_Add_Shift(PC,Shifted_Output_to_Adder, PC_Plus_Shift);
nbitmux_to_pc#(N)MUX_Adders_to_PC(PC_Plus_Shift, ALUOutput, PC_Plus_4, PC_Plus_Shift, Branch_Control_Unit_Output, jal, MUX_to_PC);

InstMem Instruction_Memory(PC[31:2], Instruction);

wire [31:0] Write_Data;
wire [31:0] Read_Data_1, Read_Data_2;
RegFile regfile(clk, rst,
Instruction[`IR_rs1], Instruction[`IR_rs2], Instruction[`IR_rd],
Write_Data,
 RegWrite,
 Read_Data_1, Read_Data_2 );
wire [31:0] Immediate_Generator_Output;
ImmGen Immediate_Generator(Instruction, Immediate_Generator_Output);

wire [2:0]ALUOp;
wire auipc;
Control_Unit Control_unit(Instruction[`IR_opcode],Branch, MemRead,MemtoReg,ALUOp, MemWrite,ALUSrc,RegWrite,jal,Stop_Flag,auipc);
wire [3:0] ALU_Sel;
ALU_Control_Unit ALU_Control_Unit(ALUOp,Instruction[5], Instruction[`IR_funct3], Instruction[30] , ALU_Sel );
wire [31:0] MUX_to_ALU_Output;

wire Carry_Flag, Overflow_Flag, Sign_Flag;
ALU ALU(Read_Data_1, MUX_to_ALU_Output, Instruction[`IR_shamt], ALUOutput, Carry_Flag, Zero_Flag, Overflow_Flag, Sign_Flag, ALU_Sel);
wire [31:0] Data_Memory_Output;

Branch_Control_Unit Branch_Control_Unit(Branch, Instruction[`IR_funct3], Carry_Flag, Zero_Flag, Overflow_Flag, Sign_Flag , Branch_Control_Unit_Output);
DataMem Data_Memory(clk, MemRead, MemWrite,Instruction[`IR_funct3], ALUOutput[31:2],  Read_Data_2,  Data_Memory_Output);

nbit_shift#(N) Shift_Left_1( Immediate_Generator_Output, Shifted_Output_to_Adder);
Control_Unit_to_Regfile#(N) Control_Unit_to_RegFile(ALUOutput, Data_Memory_Output, PC_Plus_4, PC_Plus_Shift, jal, auipc,MemtoReg,Write_Data);
nbit_mux#(N)MUX_to_ALU(ALUSrc,Read_Data_2, Immediate_Generator_Output,MUX_to_ALU_Output );

reg [15:0] num;

Four_Digit_Seven_Segment_Driver bcd(clock_ssd, num,Anode, LED_out);

always@(*)
begin
case(ssd_sel)
4'b0000: num=PC [12:0];
4'b0001: num=PC_Plus_4 [12:0];
4'b0010: num=PC_Plus_Shift [12:0];
4'b0011: num=MUX_to_PC [12:0];
4'b0100: num=Read_Data_1 [12:0];
4'b0101: num=Read_Data_2 [12:0];
4'b0110: num=Write_Data [12:0];
4'b0111: num=Immediate_Generator_Output [12:0];
4'b1000: num=Shifted_Output_to_Adder [12:0];
4'b1001: num= MUX_to_ALU_Output [12:0];
4'b1010: num=ALUOutput [12:0];
4'b1011: num=Data_Memory_Output [12:0];
default: num=0;
endcase
end


always@(*)
begin
case(led_sel)
2'b00: leds=Instruction[15:0];
2'b01: leds=Instruction[31:16];
2'b10: leds={2'b00,ALUOp,ALU_Sel,Zero_Flag,(Branch&Zero_Flag)};
default: leds=16'b0;
endcase
end


endmodule

