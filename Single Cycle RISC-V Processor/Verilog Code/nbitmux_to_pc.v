`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// Module Name: nbitmux_to_pc.v
// Project Name: Single Cycle RISC-V Processor
// Author: Farah Mohamed and Mohamad Zarif
// Description: This is the Multiplexer Module, that is used for the selection of the Program Counter to increment to depending on the instruction.
// 
// Change History: 11/3/2022 - Implemented the module.
//////////////////////////////////////////////////////////////////////////////////


module nbitmux_to_pc#(parameter N=8)(input[N-1:0] Input1,input[N-1:0] Input2, input[N-1:0] Input3, input[N-1:0] Input4, input Sel1,[1:0] Sel2,output[N-1:0] mux_output);

reg [N-1:0] out;
    always @ (*)
    begin
    
    case ({Sel2,Sel1})
    3'b100 : out <= Input1; 
    3'b110 : out <= Input2; 
    3'b000 : out <= Input3; 
    3'b001 : out <= Input4; 
    default: out <= Input3;
    endcase
    end
    assign mux_output = out;
endmodule
