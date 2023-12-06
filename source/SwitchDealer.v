`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Haibin Lai
// Create Date: 2023/11/30 00:12:10
// Design Name: �������ǵĿ��أ������������ټ�
// Module Name: SwitchDealer
// Tool Versions: 1.0.0

// Revision 0.01 - File Created
// Additional Comments: 
//    input [9:0] Swithes, 9 �� ����  7��doreimi 3������
//    output [9:0] BuzzerNote
//                21λ one-hot
//////////////////////////////////////////////////////////////////////////////////


module SwitchDealer(
    input [9:0] Switch,
    output [9:0] BuzzerNote
    );
    
    assign BuzzerNote = Switch;
    
    
endmodule