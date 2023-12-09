`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Haibin Lai
// 
// Create Date: 2023/11/29 23:50:05
// Design Name: 控制我们的音符
// Module Name: NoteDealer

// Target Devices: 
// Tool Versions: 1.0.1
// Description: 如何把8位的note转换成21位的one hot
// 
// Additional Comments:noop
// 
//////////////////////////////////////////////////////////////////////////////////


module BUZZERCONTROLLER(
    input clk,
    input [1:0] State,
    input [9:0] Pin_Note, //我们的按键音符 7+2
    input [7:0] UART_Note, //来自UART的音符,上线
    input [9:0] DATABASE_Note,
    input rst,
    
    output reg [9:0] one_hot_Note // one-hot-Note
//    output [9:0] Memory_out_Note
    );
    wire [9:0] trans_uart;
    
    UARTTRANS UART(
    .UART_Note(UART_Note),
    .TRAN(trans_uart),
    .rst(rst),
    .clk(clk)
    );
    

always @* begin
    case(State)
        `FREE_MODE:
            one_hot_Note = Pin_Note;
        `UART_MODE:
            one_hot_Note = trans_uart;
        `LEARN_MODE:
            one_hot_Note = Pin_Note;
        `PLAY_MODE:
            one_hot_Note = DATABASE_Note;
    endcase
end
 
endmodule
