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
    input rst,                      //A.reset button, low for active

// ------------------ From: Note Dealer ---------------//
    input [9:0] Pin_Note,       //3.我们的按键音符 NOTE 7+3,Pin_Note[0]是LSB
                                //  UART_Note, 来自UART的音符,将通过UART输入，所以这里略过 UART'S NOTE
 // -------------------From: Buzzer -------------------//
    output wire speaker,       //B.Buzzer output signal；one_hot_Note,  one-hot-Note,去往：buzzer  
    output sel,
                              
// ------------------ From: WASDY --------------------//准备上线
//    input [4:0] WASDE,          //4.我们的5个按键，负责调整顺序
//    output [4:0] WASDE_Signal,  //C.按键的映射 output:去往各个按键
    
// -------------------From: UART----------------------//准备上线
//    input uart_intoFPGA,        //5.来的数据
//    output uart_outFPGA,        //D.走的数据
    
//--------------------From: Display-------------------//
//    output [47:0] DigitalMoss,  //E.数码管的输出PRETEUS 准备上线
    
    output [6:0] led_note,
    output [2:0] led_HighLow            //F.LED
    );

////#------------------- STATE;ENABLE -------------------#enable 功能还没有上线
    reg [1:0] current_state;            //state 
    reg [6:0] current_ENABLE;           //ENABLE
//    reg SD_ENABLE;                      
//    reg WASDY_ENABLE;
//    reg BUZZER_ENABLE;
//    reg LED_ENABLE;
//    reg UART_ENABLE;
//    reg PROTEUS_ENABLE;
//    reg MEMORY_ENABLE;
    
////#------------------- UART ---------------------------#//
//    reg uart_message;
//    reg [9:0] UARTNOTE;
    
////#------------------- 数码棍哥 -----------------------#//
//    reg [1:0] Proteus_state;
    
////#------------------- MEMORY -------------------------#//
//    reg MEMORYNOTE;
    
//#--------------------- NOTE -------------------------#//
    wire [9:0] NOTE;
    reg [9:0] PINNOTE;
    
////#--------------------- WASD -------------------------#//    
//    reg [4:0] wasd_out;
    
    //***********NOTE***************//
    NoteDealer ND(
     //INPUT
    .clk(clk),                      //CLOCK]
//    .Pin_Note(Pin_Note),            //我们的按键音符 7+2
      .Pin_Note(PINNOTE),
//    .SD_ENABLE(SD_ENABLE),          //SWITCH ENABLE
//    .UART_ENABLE(UART_ENABLE),      //UART   ENABLE
//    .Memory_ENABLE(MEMORY_ENABLE),  //MEMORY ENABLE

//    .UART_Note(UARTNOTE),           //来自UART的音符，准备上线
            //OUTPUT
    .one_hot_Note(NOTE)            // one-hot-Note    
//    .Memory_Note(MEMORYNOTE)准备上线
    );
    
//    //***********WASD***************// 准备上线
//    WASDY WASDY(
//    .clk(clk),
//    .WASDE(WASDE),
//    .WASDE_Signal(wasd_out)
//    );
    
    //***********BUZZER*************//
    wire[9:0] out_led;    
    Buzzer Buzzer(
    .clk(clk),                       // Clock signal
    .low({NOTE[6],NOTE[5],NOTE[4],NOTE[3],NOTE[2],NOTE[1],NOTE[0]}),
    .pitch({NOTE[9],NOTE[8],NOTE[7]}),
    
    .speaker(speaker),       
    .sel(sel)        ,                //启动！
    .markLED(out_led)
    );

    //***********LED****************//
    Led Led(
    .Busline(out_led),
    .lednote(led_note),
    .HighLow(led_HighLow)
    );
    
//    //***********UL*****************//准备上线
//    uart_loop UL(
//    .i_clk_sys(clk),
//    .i_uart_rx(uart_intoFPGA),
//    .uart_rx(uart_message),
//    .i_rst_n(UART_ENABLE),
//    .o_uart_tx(uart_outFPGA),
//     .UART_ENABLE(UART_ENABLE)
//    );
    
//    //***********MEMORY*************//准备上线
//    Memory Me(
//       .clk(clk)
//   );
   
   
//    三段式状态机，启动！    

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
            
        default:// just in case
            current_ENABLE = `FREE_MODE_ENABLE;
       endcase 
    end
    
//      阶段三：Execute 阶段，在时钟上升沿触发
    always @(posedge clk or negedge rst) begin
            if(!rst) begin
              PINNOTE <=  `DISABLE;
//            SD_ENABLE    = `DISABLE;
//            WASDY_ENABLE = `DISABLE;
//            BUZZER_ENABLE= `DISABLE;
//            LED_ENABLE   = `DISABLE;
//            UART_ENABLE  = `DISABLE;
//            PROTEUS_ENABLE=`DISABLE; 
//            MEMORY_ENABLE= `DISABLE; 
            end 
            
            else begin
            case(current_ENABLE)
                `FREE_MODE_ENABLE:
                    PINNOTE <=  Pin_Note;
            endcase
//            SD_ENABLE    = current_ENABLE[5];
//            WASDY_ENABLE = current_ENABLE[4];
//            BUZZER_ENABLE= current_ENABLE[0];
//            LED_ENABLE   = current_ENABLE[1];
//            UART_ENABLE  = current_ENABLE[2];
//            PROTEUS_ENABLE=current_ENABLE[3];
//            MEMORY_ENABLE= current_ENABLE[6];            
            end
     end
     
     // 祈祷：
     //-----------笑看众生成正果，方知自己是如来-----------//
     //*                    _ooOoo_                       *//
     //*                   o8888888o                      *//
     //*                   88" . "88                      *//
     //*                   (| -_- |)                      *//
     //*                    O\ = /O                       *//
     //*                ____/`---'\____                   *//
     //*              .   ' \\| |// `.                    *//
     //*               / \\||| : |||// \                  *//
     //*             / _||||| -:- |||||- \                *//
     //*               | | \\\ - /// | |                  *//
     //*             | \_| ''\---/'' | |                  *//
     //*              \ .-\__ `-` ___/-. /                *//
     //*           ___`. .' /--.--\ `. . __               *//
     //*        ."" '< `.___\_<|>_/___.' >'"".            *//
     //*       | | : `- \`.;`\ _ /`;.`/ - ` : | |         *//
     //*         \ \ `-. \_ __\ /__ _/ .-` / /            *//
     //* ======`-.____`-.___\_____/___.-`____.-'======    *//
     //*                    `=---='                       *//
     //----------------------------------------------------//
     
endmodule
