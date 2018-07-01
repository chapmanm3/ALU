module PC(signExtOut, uncondBranch, branch, output0, address);
input signExtOut, uncondBranch, branch, output0;
output address;
endmodule

module InstMem(address, instruction);
input address;
output instruction;
endmodule

module Register(readReg1, readReg2, writeData, regWrite, aluSrc, signExtIn, signExtOut, readData1, readData2);
input readReg1, readReg2, writeData, regWrite, aluSrc, signExtIn;
output signExtOut, readData1, readData2;
endmodule

module Controller(instruction, reg2logic, uncondBranch, branch, memRead, memReg, aluOp, memWrite, aluSrc, regWrite, reg1, reg2, writeReg, aluControl);
input instruction;
//reg reg2logic, uncondBranch, branch, memRead, memReg, aluOp, memWrite, aluSrc, regWrite, aluControl;
//reg [4:0]reg1, reg2, writeReg;
output reg2logic, uncondBranch, branch, memRead, memReg, aluOp, memWrite, aluSrc, regWrite, reg1, reg2, writeReg, aluControl;
endmodule

module ALU(reg1, reg2, aluControl, output0, aluResult);
input [31:0]reg1, reg2;
input [3:0]aluControl;
output output0, aluResult;
reg output0 = 1'b0;
reg [31:0]aluResult;
always @* begin
if(aluControl == 4'b0010)
	aluResult = reg1 + reg2;
else if(aluControl == 4'b1010)
	aluResult = reg1 - reg2;
else if(aluControl == 4'b0110)
	aluResult = reg1 & reg2;
else if(aluControl == 4'b0100)
	aluResult = reg1 | reg2;
else if(aluControl == 4'b1001)
	aluResult = reg1 ^ reg2;
else if(aluControl == 4'b0101)
	aluResult = ~(reg1 | reg2);
else if(aluControl == 4'b1100)
	aluResult = ~(reg1 & reg2);
else if(aluControl == 4'b1101)
	aluResult = reg1 + reg2;
else if(aluControl == 4'b0111)
	aluResult = reg1 - reg2;
	if(aluResult == 0)
		output0 = 1'b1;
end
endmodule

module ALUTest;
reg [31:0]reg1, reg2;
reg [3:0]aluControl;
wire output0;
wire [31:0]aluResult;

ALU alu0(reg1, reg2, aluControl, output0, aluResult);

initial begin
reg1 = 32'b0101; reg2 = 32'b0100; aluControl = 4'b0010;
#50 $display("reg1: %x, reg2: %x, aluControl: LDUR/STUR/ADD %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b0111;
#50 $display("reg1: %x, reg2: %x, aluControl: CBZ %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b1010;
#50 $display("reg1: %x, reg2: %x, aluControl: SUB %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b0110;
#50 $display("reg1: %x, reg2: %x, aluControl: AND %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b0100;
#50 $display("reg1: %x, reg2: %x, aluControl: ORR %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b1001;
#50 $display("reg1: %x, reg2: %x, aluControl: EOR %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b0101;
#50 $display("reg1: %x, reg2: %x, aluControl: NOR %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b1100;
#50 $display("reg1: %x, reg2: %x, aluControl: NAND %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b1101;
#50 $display("reg1: %x, reg2: %x, aluControl: MOV %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
aluControl = 4'b0111; reg1 = 32'b0100;
#50 $display("reg1: %x, reg2: %x, aluControl: CBZ %x, output0: %x, aluResult: %x", reg1, reg2, aluControl, output0, aluResult);
end
endmodule

module Multiplex(data0, data1, control, dataout);
input data0, data1, control;
output dataout;
endmodule

module DataMem(address, writeData, memWrite, memToReg, readData);
input address, writeData, memWrite, memToReg;
output readData;
endmodule
