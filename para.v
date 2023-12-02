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
`define FREE_MODE_ENABLE    6'b111101

//BUZZER LED UART SHUMA WASDY PIN
`define LEARN_MODE_ENABLE   6'b111111

//BUZZER LED UART? SHUMA WASDY 
`define PLAY_MODE_ENABLE    6'b111110

//BUZZER LED UART SHUMA 
`define UART_MODE_ENABLE    6'b111100
`define DISABLE 1'b0