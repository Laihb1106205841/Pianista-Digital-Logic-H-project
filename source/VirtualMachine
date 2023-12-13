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

//  From: Note Dealer ---------------//
    input [9:0] Pin_Note,       //3.我们的按键音符 NOTE 7+3,Pin_Note[0]是LSB
                                    //  UART_Note, 来自UART的音符,将通过UART输入，所以这里略过 UART'S NOTE
 // From: Buzzer -------------------//
    output wire speaker,           //B.Buzzer output signal；one_hot_Note,  one-hot-Note,去往：buzzer  
    output sel,

// From: WASDY --------------------//准备上线
    input [4:0] WASDE,           //4.我们的5个按键，负责调整顺序
//    output [4:0] WASDE_Signal,   //C.按键的映射 output:去往各个按键
    input Recording,
    
// From: UART----------------------//准备上线
    input uart_rxd,//5.来的数据
    output uart_txd,//D.走的数据      
    
//From: Display-------------------//
    
//    output [7:0] Tub1,
//    output [7:0] Tub2,  //E.数码管的输出PRETEUS 准备上线
    output [9:0] NOTELED,           //F.LED
    output [1:0] StatusLED,  
    output RecordingLED,
    output wire ENABLEBUZZER
    
    );///////////////////////////////////////////////////////////////////////////////END IO
    
    assign ENABLEBUZZER = 1'b0;

//#------------------- STATE;ENABLE -------------------#enable 功能还没有上线
    reg [1:0] current_state;            //state 
    reg [6:0] current_ENABLE;           //ENABLE
    

    
//#------------------- 数码棍哥 -----------------------#//
    reg [1:0] Proteus_state;
    reg [47:0] DigitalMoss;          //E.数码管的输出PRETEUS 准备上线
    
    
    
//#--------------------- NOTE -------------------------#//
    wire [9:0] NOTE;   //out from NOTEDEALER, into Led and Buzzer
    reg [9:0] LearnNote;//用于处理学习模式中从数据库里取出来的note
    reg [9:0] PINNOTE; //专门处理input的数据的
    reg [9:0] DATABASE_Note;//专门处理播放模式下的数据的
    
////#-------------------- WASD ------------------------#//    
    reg [4:0] wasd_out;
    reg [4:0] wasd_to_other;
    
////#------------------- UART ---------------------------#//
//    reg uart_message;
    wire [7:0] UARTme;
    //********专门用来处理进入buzzer的NOTE***************//
    BUZZERCONTROLLER ND(
      .clk(clk),                      //CLOCK]   
      .rst(rst),
      .State(current_state),
      .Pin_Note(PINNOTE),             //我们的按键音符 7+3  INPUT         
      .UART_Note(UARTme),           //来自UART的音符，准备上线        
      .DATABASE_Note(DATABASE_Note),
      .one_hot_Note(NOTE)               // one-hot-Note OUTPUT
    );
    
    
    //***********WASD***************// 准备上线
    WASDY WASDY(
    .clk(clk),
    .rst(rst),
    .WASDE(WASDE),
    .WASDE_Signal(wasd_out)
    );
    
    //***********BUZZER*************//
     wire[9:0] out_led; //output
      
    Buzzer Buzzer(
    .clk(clk),                       // Clock signal
    .note({NOTE[6],NOTE[5],NOTE[4],NOTE[3],NOTE[2],NOTE[1],NOTE[0]}),
    .pitch({NOTE[9],NOTE[8],NOTE[7]}),
    .speaker(speaker),       
    .sel(sel)   ,                //启动！
    .markLED(out_led)
    );

//#------------------------ LED -----------------------#//
//    reg  
    //***********LED****************//
    Led Led(
    .BUZZERBusline(NOTE),       // 自由模式，播放模式所使用的line，和buzzer相同
    .LEARNBusline(LearnNote),   // 学习模式所使用的line，和buzzer不同，要求是一旦按下按键，led关闭。
    .Status(current_state),//Control STATUS
    .NOTELED(NOTELED), //output LED
    .StaLed(StatusLED) ,//output LED
    .RecordingLED(RecordingLED)
    );
    
    //***********数码管**************//
    proteus Pr(
    .DigitalMoss(DigitalMoss)
    //io
    );

    
//    //***********UL*****************//上线
    UARTController UART(
    .clk(clk),
    .rst(rst)  ,   
    .uart_rxd(uart_rxd),
    .uart_txd(uart_txd),
   .storedMessage(UARTme) // 用于存储消息的寄存器   
    );
    
//    //***********MEMORY*************//上线中
////#------------------- MEMORY -----------------------#//
    reg databaseEnable;
reg [9:0] MreadNote;
    Memory MEMORY(
    //in
       .clk(clk),
       .databaseEnable(databaseEnable),
       .state(current_state),
       //to do: more input
    
    //out
        .readNote(MreadNote)
   );
   
   
//    三段式状态机，启动！    SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

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
          
//            SD_ENABLE  <= `DISABLE;
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
                begin
                    PINNOTE <=  Pin_Note;
                    databaseEnable <= `DISABLE;
                    wasd_to_other <= `DISABLE;
                 end
                 
                `PLAY_MODE_ENABLE:
                begin
                    PINNOTE <= `DISABLE;
                    databaseEnable <= `ABLE;
                    wasd_to_other <= wasd_out;
                end
                
                `UART_MODE_ENABLE:
                begin
                    PINNOTE <= `DISABLE;
                    databaseEnable <= `DISABLE;
                    wasd_to_other <= `DISABLE;
                end
                
                `LEARN_MODE_ENABLE:
                begin
                    PINNOTE <= Pin_Note;
                    databaseEnable <= `ABLE;
                    wasd_to_other <= wasd_out;
                end
               
            endcase      
            end
     end

     
endmodule
