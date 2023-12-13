`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Haibin Lai
// 
// Create Date: 2023/12/01 21:45:28
// Design Name: 控制我们的WASDY键，从而切换歌曲
// Module Name: WASDY
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 只负责读取WASDY并输出
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module WASDY(
    input [4:0] WASDE, //我们的5个按键，负责调整顺序
    input clk,
    input rst,
    output reg [4:0] WASDE_Signal //按键的映射
    );
    
    always @(posedge clk)
    begin
        if(!rst)
            WASDE_Signal <= 0;
        else
            WASDE_Signal <= WASDE;    //读取按键输入

    end
         
    
endmodule
