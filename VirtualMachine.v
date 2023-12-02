`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
//haibin Lai
//
// VM, centural of the programme
// VM机器负责导入状态，然后将状态传给各个Controller
//input: all of the signal,pins,...
//function:all the little led...etc
//output:led,shuweiguan,
//////////////////////////////////////////////////////////////////////////////////

`include "para.v"

//总类
    //一共包含：
    //输入 INPUT：
    //1.PINS_NOTE 2.PINS_STATE 3.WASDE 4.RESET 5.UART
    //输出 OUTPUT：
    //A.RESET  B.BUZZER  C.WASDE  D.UART_OUT  E.PRETEUS  F.LED
module VirtualMachine(

input clk,                      //1.我们的时钟CLOCK
input [1:0] next_state,         //2.总状态STATE
input rst,                      //A.reset button

// From: Note Dealer
    input [8:0] Pin_Note,       //3.我们的按键音符 NOTE 7+2,Pin_Note[0]是LSB
                                //  UART_Note, 来自UART的音符,将通过UART输入，所以这里略过 UART'S NOTE
    output wire speaker,       //B.Buzzer output signal；one_hot_Note,  one-hot-Note,去往：buzzer                                
// From: WASDY
    input [4:0] WASDE,          //4.我们的5个按键，负责调整顺序
    output [4:0] WASDE_Signal,  //C.按键的映射 output:去往各个按键
// From: UART
    input uart_intoFPGA,        //5.来的数据
    output uart_outFPGA,        //D.走的数据
    
//Display
    output [47:0] DigitalMoss,  //E.数码管的输出PRETEUS
    output [7:0] Led_note            //F.LED
    );
//    assign BuzzerSpeaker = `BAUD_RATE;

    reg [1:0] current_state; //state 
    reg [5:0] current_ENABLE; //ENABLE
    reg SD_ENABLE;
    reg WASDY_ENABLE;
    reg BUZZER_ENABLE;
    reg LED_ENABLE;
    reg UART_ENABLE;
    reg PROTEUS_ENABLE;
    
    reg uart_message;


    NoteDealer ND(
    .clk(clk)
    );
    WASDY WASDY(
    .clk(clk)
    );
    Buzzer Buzzer(
    .clk(clk)
    );
    Led Led(
    .clk(clk)
    );
    uart_loop UL(
    .clk(clk),
    .uart_in(uart_intoFPGA),
    .uart_rx(uart_message),
    .rst(current_ENABLE[2]),
    .uart_out(uart_outFPGA)

    );
    

//    VM，启动！
//    阶段一：Fetch 阶段，在时钟上升沿触发
    always @(posedge clk or negedge rst) begin
// 在 Fetch 阶段，只进行状态的读取，同步数据
        if(!rst) begin
            current_state <= `FREE_MODE;
        end
        else begin
            current_state <= next_state;
        end
    end


//    阶段二：Decode 阶段，在时钟恒定时触发
always @* begin
       case (current_state)
       //自由模式
       `FREE_MODE:
            current_ENABLE = `FREE_MODE_ENABLE;
            
       //播放模式    
       `PLAY_MODE:
            current_ENABLE = `PLAY_MODE_ENABLE;
       
       //UART串口通信web模式   
       `UART_MODE:
            current_ENABLE = `UART_MODE_ENABLE;
           
       //学习模式
       `LEARN_MODE:
            current_ENABLE = `LEARN_MODE_ENABLE;
            
            
        default:
            current_ENABLE = `FREE_MODE_ENABLE;
       endcase 
    end
    
//      阶段三：Execute 阶段，在时钟上升沿触发
    always @(posedge clk or negedge rst) begin

            if(!rst) begin
            SD_ENABLE    = `DISABLE;
            WASDY_ENABLE = `DISABLE;
            BUZZER_ENABLE= `DISABLE;
            LED_ENABLE   = `DISABLE;
            UART_ENABLE  = `DISABLE;
            PROTEUS_ENABLE=`DISABLE;
            end 
            else begin
            SD_ENABLE    = current_ENABLE[5];
            WASDY_ENABLE = current_ENABLE[4];
            BUZZER_ENABLE= current_ENABLE[0];
            LED_ENABLE   = current_ENABLE[1];
            UART_ENABLE  = current_ENABLE[2];
            PROTEUS_ENABLE=current_ENABLE[3];            
            end
     end
endmodule
