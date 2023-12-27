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
    output reg [1:0] outSongs, //选择歌曲
    output  reg [1:0]outSo
//    output select
    );
    
    
    
    reg history_UP;
    reg UP;

    reg history_Down;
    reg Down;
    
    reg history_Confi;
    reg Confi;
    
    always @(posedge clk)begin
    if(!rst)begin
        outSo<=0;
        outSongs<=0;
        
    end
    
//    if(WASDE[4])begin // up
    
//    end
    
    
    
    if(state == `LEARN_MODE || state == `PLAY_MODE)begin
    
        UP <= WASDE[4];
        Down<=WASDE[1];
        Confi<=WASDE[2];
        
        if(UP && ~history_UP)begin
            case(outSo)
//            outSo <= outSo +1;
            2'b00:outSo <= 2'b01;
            2'b01:outSo <= 2'b10;
            2'b10:outSo <= 2'b11;
            2'b11:outSo <= 2'b00;
            endcase
        end    
        
        if(Confi && ~history_Confi)begin
            outSongs <=outSo;
        end        
         if(Down && ~history_Down)begin
            case(outSo)
//            outSo <= outSo +1;
            2'b00:outSo <= 2'b11;
            2'b01:outSo <= 2'b00;
            2'b10:outSo <= 2'b01;
            2'b11:outSo <= 2'b10;
            endcase
        end   
    
    end else begin
        UP <= 0;
        Down<=0;
        Confi<=0;
        outSo <= 0;
        outSongs <= 0;
    end
    

    end
    
    
    
    
    
//    reg [1:0]outSo;
//    assign outSongs = outSo;
    
//    always @(posedge WASDE[4]) begin
//    if(!rst)begin
//        outSo <= 2'b00;
//    end else begin
//        outSo <= 2'b10;
//        end
//    end
    
//    always @(posedge WASDE[2]) begin
//        outSo <= 2'b01;
//    end
    
//    always @(posedge WASDE[1]) begin
//        outSo <= 2'b11;
//    end
    
//    always @(posedge WASDE[3]) begin // 右边的赋值
//        outSongs <= outSo;
//    end
    
//    always @(posedge WASDE[0]) begin
//        outSo <= 2'b00;
//    end
    
//    reg [1:0] outSong;
//    reg [2:0] SelectedSongs;
    
////    reg Up; reg last_Up;
////    reg Down; reg last_Down;
////    reg Confirm; reg last_Confirm;
    
////    reg [1:0] out;
//    reg selected;
    
//    always @(posedge clk)
//    begin
//          if(!rst) begin
////            Up <= 0;
////            Down<=0;
////            Confirm<=0;
////            selected <= 0;
////            out <=0;
////            outSongs<=0;
//        end
    
//        if(state == `FREE_MODE || state == `UART_MODE) begin
////            Up <= 0;
////            Down<=0;
////            Confirm<=0;
//            selected <= 0;
////            out <=2;
//            outSong<=0;
//        end else begin

       
////            last_Up <= Up;
////            last_Down <= Down;
////            last_Confirm <= Confirm;
        
////            Up <= WASDE[4];    //读取按键输入
////            Down <= WASDE[1];
////            Confirm <= WASDE[2];
            
////            if(~last_Up && Up)begin //next song
////                selected <= 0;
////                out <= out + 1;
////            end
            
////            if(~last_Down && Down)begin //previous song
////                selected <= 0;
////                out <= out - 1;
////            end
            
////            if(~last_Confirm && Confirm)begin
////                selected <= ~selected;
////            end
       
//        end
//    end
    
//    always @(posedge WASDE[4])begin //down
//    if(state == `PLAY_MODE || state == `LEARN_MODE) begin
//    case(outSong)
//        2'b00:outSong <=2'b01;
//        2'b01:outSong <=2'b10;
//        2'b10:outSong <=2'b11;
//        2'b11:outSong <=2'b00;
//    endcase
////       outSong <= outSong+1;
//        selected <= 0;
//    end
//    end
    
//    always @(posedge WASDE[1])begin //down
//   if(state == `PLAY_MODE || state == `LEARN_MODE) begin
//     case(outSong)
//        2'b00:outSong <=2'b11;
//        2'b01:outSong <=2'b00;
//        2'b10:outSong <=2'b01;
//        2'b11:outSong <=2'b10;
//    endcase
//        selected <= 0;
//    end
//    end
    
//    always @(posedge WASDE[2])begin //select
//       if(state == `PLAY_MODE || state == `LEARN_MODE) begin
//       selected <= 1;
//    end
//    end

    
//always @(posedge clk) begin
//    if(selected == 1)begin
//    outSong <= out;
//    end else begin
//    outSong <= 0;
//    end
//end
//reg [1:0] SONY;

//always @(posedge clk)begin
//    if(outSong == 1)begin
//        SONY <= 1;
//    end
//end


//assign select = selected;
//assign outSongs = outSong;

         
    
endmodule
