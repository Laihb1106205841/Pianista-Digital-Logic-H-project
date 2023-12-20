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

`include "para.v"
module WASDY(
    input [1:0] state,
    input [4:0] WASDE, //我们的5个按键，负责调整顺序
    input clk,
    input rst,
    output reg [4:0] outSong, //选择歌曲
    output select
    );
    
    reg [2:0] SelectedSongs;
    
    reg Up; reg last_Up;
    reg Down; reg last_Down;
    reg Confirm; reg last_Confirm;
    
    reg [4:0] out;
    reg selected;
    
    always @(posedge clk)
    begin
        if(state == `PLAY_MODE || state == `UART_MODE)begin
            Up <= 0;
            Down<=0;
            Confirm<=0;
            selected <= 0;
        end else begin
        if(!rst) begin
            Up <= 0;
            Down<=0;
            Confirm<=0;
            selected <= 0;
        end
        else begin
            last_Up <= Up;
            last_Down <= Down;
            last_Confirm <= Confirm;
        
            Up <= WASDE[0];    //读取按键输入
            Down <= WASDE[1];
            Confirm <= WASDE[2];
            
            if(~last_Up && Up)begin //next song
                selected <= 0;
                out <= out + 1;
            end
            
            if(~last_Down && Down)begin //previous song
                selected <= 0;
                out <= out - 1;
            end
            
            if(~last_Confirm && Confirm)begin
                selected <= 1;
            end
        end
        end
    end
    

    
always @(posedge clk) begin
    outSong <= out;
end
assign select = selected;


    
    
    
//   always @* begin
//        case(WASDE_Signals)
//        `DOWN:begin
//            out = out+1;
//        end
//        `UP:begin
//            out = out-1;
//        end
//        endcase
//   end
   
//   always @(posedge clk)begin
//        if(!rst)begin
            
//        end
//   end
         
    
endmodule
