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


module NoteDealer(
    input [8:0] Pin_Note, //我们的按键音符
    input [8:0] UART_Note, //来自UART的音符
    output [20:0] one_hot_Note // one-hot-Note
    );
    
    SwitchDealer SD();
    UARTDealer   UD();
endmodule
