`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: haibin
// 
// Create Date: 2023/12/07 04:06:37
// Design Name: 
// Module Name: UARTnote
// Project Name: 
// Target Devices:for the UART TRANS 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define LOWDO 8'b10011001//fix
`define OneHotLOWDO 10'b1000000_100
`define LOWREI 8'b10101001
`define OneHotLOWREI 10'b0100000_100
`define LOWMI 8'b10111001
`define OneHotLOWMI 10'b0010000_100
`define LOWFA 8'b11001001
`define OneHotLOWFA 10'b0001000_100
`define LOWSO 8'b11011001
`define OneHotLOWSO 10'b0000100_100
`define LOWLA 8'b11101001
`define OneHotLOWLA 10'b0000010_100
`define LOWTI 8'b11111001
`define OneHotLOWTI 10'b0000001_100

`define MIDDO 8'b10010101
`define OneHotMIDDO 10'b1000000_010
`define MIDREI 8'b10100101
`define OneHotMIDREI 10'b0100000_010
`define MIDMI 8'b10110101
`define OneHotMIDMI 10'b0010000_010
`define MIDFA 8'b11000101
`define OneHotMIDFA 10'b0001000_010
`define MIDSO 8'b11010101
`define OneHotMIDSO 10'b0000100_010
`define MIDLA 8'b11100101
`define OneHotMIDLA 10'b0000010_010
`define MIDTI 8'b11110101
`define OneHotMIDTI 10'b0000001_010

`define HIDO 8'b10010011
`define OneHotHIDO 10'b1000000_001
`define HIREI 8'b10100011
`define OneHotHIREI 10'b0100000_001
`define HIMI 8'b10110011
`define OneHotHIMI 10'b0010000_001
`define HIFA 8'b11000011
`define OneHotHIFA 10'b0001000_001
`define HISO 8'b11010011
`define OneHotHISO 10'b0000100_001
`define HILA 8'b11100011
`define OneHotHILA 10'b0000010_001
`define HITI 8'b11110011
`define OneHotHITI 10'b0000001_001
//写完转换！

`define DISABLE 1'b0




