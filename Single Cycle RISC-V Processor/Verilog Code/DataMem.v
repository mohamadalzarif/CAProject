`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: DataMem.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Data Memory Module, that is used for memory.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module DataMem
 (input clk, input MemRead, input MemWrite, input [2:0]funct3,
 input [5:0] addr, input [31:0] data_in, output reg [31:0] data_out);
 reg [31:0] mem [0:63];

always@(*)
begin
if (clk)
     data_out = mem[addr];
else begin
if (MemWrite) begin
case(funct3) 
 3'b010: mem[addr] <= data_in; //SW
 3'b000: mem[addr] <= data_in[7:0]; //SB
 3'b001: mem[addr] <= data_in[15:0]; //SH
default: mem[addr] = mem[addr];
endcase

end
else if(MemRead)begin
case(funct3) 
 3'b001: data_out = { {16{mem[addr][15]}}, mem[addr][15:0]};  //LH
 3'b000: data_out = { {24{mem[addr][7]}}, mem[addr][7:0]};  //LB 
 3'b010: data_out = mem[addr]; //LW
 3'b100: data_out = {24'b0,mem[addr][7:0]}; //LBU  
 3'b101: data_out = {16'b0,mem[addr][15:0]}; //LHU
default: data_out=0;
endcase
end
else begin
data_out=0;
mem[addr]=mem[addr];
end
end
end

initial begin
 mem[0]=32'd17;
 mem[1]=32'd9;
 mem[2]=32'd25;
end

endmodule

