`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 赖海斌
// 
// Create Date: 2023/12/01 23:49:38
// Design Name: 常数
// Module Name: para
// Project Name: 数字逻辑
// Target Devices: FPGA
// Tool Versions: 
// Description: 用来定义常数的“宏文件”

//　　//`define+name+参数 　
//　　　　`define 　　STATE_INIT　　   3'd0
//　　　　`define 　　STATE_IDLE　 　 3'd1
//　　　　`define 　　STATE_WRIT　　 3'd2
//　　　　`define 　　STATE_READ　　3'd3
//　　　　`define 　　STATE_WORK      3'd4
//　　　　`define 　　STATE_RETU　　3'd5

//在需要调用参数的文件init.v中使用`include "para.v"：
//　　　　`include "para.v"
//实际使用：
//    assign BuzzerSpeaker = `BAUD_RATE;
//注意要加“`”
//////////////////////////////////////////////////////////////////////////////////

`define BAUD_RATE 9600
`define WIDTH 32
`define CLK_PERIOD 10

`define FREE_MODE 2'b00
`define UART_MODE 2'b11
`define LEARN_MODE 2'b01
`define PLAY_MODE 2'b10

//BUZZER LED UART SHUMA        PIN  
`define FREE_MODE_ENABLE    7'b1111010

//BUZZER LED UART SHUMA WASDY PIN  MEMORY
`define LEARN_MODE_ENABLE   7'b1111111

//BUZZER LED UART? SHUMA WASDY     MEMORY
`define PLAY_MODE_ENABLE    7'b1111101

//BUZZER LED UART SHUMA            MEMORY
`define UART_MODE_ENABLE    7'b1111001
`define DISABLE 1'b0

`define LIGHTNDPLAY 2'b01
`define LIGHTBEFOREPLAY 2'b10
`define PLAYMODELIGHT 2'b11


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