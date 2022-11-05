`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: shifter.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Shifter Module, that is used for shifting for shift operations.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module shifter(input [31:0] a,input[4:0] shamt,input [1:0]AluOp,output reg [31:0] r);


always@(*)begin

if(AluOp==2'b01)begin //shift left logical

r = a << shamt;
end
else if(AluOp==2'b00)begin //shift right logical

r = a >> shamt;
end
else if(AluOp==2'b10)begin //shift right arithmetic

r = $signed(a) >>> shamt;
end
else begin 
r = a;
end

end

endmodule
