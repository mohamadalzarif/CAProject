`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: RegFile.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Register File Module, that consists of 32 Regsiters of size 32bits alongside a decoder.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module RegFile(input clk, rst,
input [4:0] readreg1, readreg2, writereg,
input [31:0] writedata,
input regwrite,
output [31:0] readdata1, readdata2 );

wire [31:0] registers [0:31];
wire [31:0] sel;

decoder myDecoder (.selection(writereg), .enable(regwrite), .load(sel));
genvar i;
generate 

for (i=1;i<32;i=i+1)
begin: loop
Reg_32bit myReg(.in(writedata),.clk(~clk), .load(sel[i]), .rst(rst), .out(registers[i]));
end
assign registers[0] = 32'd0;
endgenerate
assign readdata1=registers[readreg1];
assign readdata2=registers[readreg2];
endmodule


module decoder ( input [4:0] selection, input enable,output reg[31:0] load );
always @(*)
begin 
if (enable) begin
load =32'd0;
load [selection]= 1'b1;
end
else 
load =32'd0;
end
endmodule 
