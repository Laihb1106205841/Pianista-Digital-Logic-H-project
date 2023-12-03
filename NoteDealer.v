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
    input clk,
    input SD_ENABLE,
    input UART_ENABLE,
    input Memory_ENABLE,    
    input [9:0] Pin_Note, //我们的按键音符 7+2
//    input [8:0] UART_Note, //来自UART的音符,准备上线
    
    output [9:0] one_hot_Note, // one-hot-Note
    output [9:0] Memory_out_Note
    );
    wire [9:0] SWNOTE;
    wire [9:0] UARTNOTE;
    
    SwitchDealer SD(
        .Switch(Pin_Note),
        .BuzzerNote(SWNOTE)
    );
//    UARTDealer   UD(准备上线
//        .UART_Note(UART_Note),
//        .UARTNOTE_out(UARTNOTE)
//    );
    
    or or0(SWNOTE[0],
//    UARTNOTE,
    one_hot_Note[0]);
        or or1(SWNOTE[1],
//    UARTNOTE,
    one_hot_Note[1]);
        or or2(SWNOTE[2],
//    UARTNOTE,
    one_hot_Note[2]);
        or or3(SWNOTE[3],
//    UARTNOTE,
    one_hot_Note[3]);
        or or4(SWNOTE[4],
//    UARTNOTE,
    one_hot_Note[4]);
        or or5(SWNOTE[5],
//    UARTNOTE,
    one_hot_Note[5]);
        or or6(SWNOTE[6],
//    UARTNOTE,
    one_hot_Note[6]);
        or or7(SWNOTE[7],
//    UARTNOTE,
    one_hot_Note[7]);
        or or8(SWNOTE[8],
//    UARTNOTE,
    one_hot_Note[8]);
        or or9(SWNOTE[9],
//    UARTNOTE,
    one_hot_Note[9]);
    
endmodule
