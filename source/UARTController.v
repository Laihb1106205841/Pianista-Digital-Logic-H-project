`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 02:32:07
// Design Name: 
// Module Name: UARTController
// Project Name: 
// Target Devices: 
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


module UARTController(
    input clk,
    input rst,
    input uart_rxd,
    input uart_txd,
    output [7:0] storedMessage // 用于存储消息的寄存器
    );
    
    
    uart_Top UT(
        .sys_clk(clk),
        .sys_rst_n(rst),
        .GetMessage(storedMessage),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd)
    );


endmodule
