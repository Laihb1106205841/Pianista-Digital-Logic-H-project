`timescale 1ns / 1ps

///////////////////////////////
// Led module
//author Haibin Lai
//date 11/19

//input: 
//input [9:0] Busline 总线

//output:
//[6:0]lednote: 对应7个led 灯
//[2:0]HighLow: 对应升8降8

////////////////////////////////

`include "para.v"
module Led(
    input [9:0] BUZZERBusline,
    input [9:0] LEARNBusline,
    input [1:0] Status,

    output reg [9:0] NOTELED,
    output [1:0] StaLed
    );
    assign StaLed = Status;
    
    always @* begin
        case(Status)
            `FREE_MODE://传输
            begin
                NOTELED = BUZZERBusline;
            end
             
            `UART_MODE:
            begin
               NOTELED = BUZZERBusline;
            end
             
            `LEARN_MODE://当有数据库里的音符奏响而我们没有按下按键时亮；如果按下了，就熄灭了
            begin
            NOTELED[9] = LEARNBusline[9]^(~BUZZERBusline[9]);
            NOTELED[8] = LEARNBusline[8]^(~BUZZERBusline[8]);
            NOTELED[7] = LEARNBusline[7]^(~BUZZERBusline[7]);
            NOTELED[6] = LEARNBusline[6]^(~BUZZERBusline[6]);
            NOTELED[5] = LEARNBusline[5]^(~BUZZERBusline[5]);
            NOTELED[4] = LEARNBusline[4]^(~BUZZERBusline[4]);
            NOTELED[3] = LEARNBusline[3]^(~BUZZERBusline[3]);
            NOTELED[2] = LEARNBusline[2]^(~BUZZERBusline[2]);
            NOTELED[1] = LEARNBusline[1]^(~BUZZERBusline[1]);         
            NOTELED[0] = LEARNBusline[0]^(~BUZZERBusline[0]);  
            end
             
             `PLAY_MODE:
             begin
                NOTELED = BUZZERBusline;
             end
        endcase
    end


endmodule
