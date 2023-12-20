`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 梁杰林
// 
// Create Date: 2023/12/20 21:47:18
// Design Name: 
// Module Name: UARTNixietube
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.03 - Updated
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "UARTNixietube.v"
`include "para.v"

module Proteus(
input wire [9:0] NOTE,
input wire [9:0] store,
input wire [47:0] SONG_NAME,
input wire [1:0] state,
input sys_clk,sys_rest,
output reg [7:0] sel,
output reg [7:0] tub1,
output reg [7:0] tub2
);

wire [7:0] sel_FREE_MODE;
wire [7:0] tub1_FREE_MODE;
wire [7:0] tub2_FREE_MODE;
wire [7:0] sel_AUTOPLAY_MODE;
wire [7:0] tub1_AUTOPLAY_MODE;
wire [7:0] tub2_AUTOPLAY_MODE;
wire [7:0] sel_STUDY_MODE;
wire [7:0] tub1_STUDY_MODE;
wire [7:0] tub2_STUDY_MODE;

Proteus_FREE_MODE p1(.NOTE(NOTE),.sys_clk(sys_clk),.sys_rest(sys_rest),.sel(sel_FREE_MODE),.tub1(tub1_FREE_MODE),.tub2(tub2_FREE_MODE));
Proteus_AUTOPLAY_MODE p2(.SONG_NAME(SONG_NAME),.sys_clk(sys_clk),.sys_rest(sys_rest),.sel(sel_AUTOPLAY_MODE),.tub1(tub1_AUTOPLAY_MODE),.tub2(tub2_AUTOPLAY_MODE));
Proteus_STUDY_MODE p3 (.NOTE(NOTE),.store(store),.sys_clk(sys_clk),.sys_rest(sys_rest),.sel(sel_STUDY_MODE),.tub1(tub1_STUDY_MODE),.tub2(tub2_STUDY_MODE));

always @(*) begin        //根据当前状态赋值
      case(state)
      2'b00:sel = sel_FREE_MODE;
      2'b11:sel = sel_FREE_MODE;
      2'b01:sel = sel_STUDY_MODE;
      2'b10:sel = sel_AUTOPLAY_MODE;
      default:sel = 8'b0000000;
       endcase
       end  
always @(*) begin      
      case(state)
      `FREE_MODE:tub1 = tub1_FREE_MODE;
      `UART_MODE:tub1 = tub1_FREE_MODE;
      `LEARN_MODE:tub1 = tub1_STUDY_MODE;
      `PLAY_MODE:tub1 = tub1_AUTOPLAY_MODE;
      default:tub1 = 8'b0000000;
       endcase
       end         
 always @(*) begin      
       case(state)
       `FREE_MODE:tub2 = tub2_FREE_MODE;
       `UART_MODE:tub2 = tub2_FREE_MODE;
       `LEARN_MODE:tub2 = tub2_STUDY_MODE;
       `PLAY_MODE:tub2 = tub2_AUTOPLAY_MODE;
       default:tub2 = 8'b0000000;
        endcase
        end        
always @(*) begin      
        case(state)
       `FREE_MODE:sel = sel_FREE_MODE;
       `UART_MODE:sel = sel_FREE_MODE;
       `LEARN_MODE:sel = sel_STUDY_MODE;
       `PLAY_MODE:sel = sel_AUTOPLAY_MODE;
        default:sel = 8'b0000000;
         endcase
         end        
endmodule



module Proteus_FREE_MODE(                  //free mode 的 controller
input wire [9:0] NOTE,
input sys_clk,sys_rest,
output reg [7:0] sel,
output reg [7:0] tub1,
output reg [7:0] tub2
    );
    
    parameter CLK_NUM = 4'd10;                       // 参数定义：时钟周期计数上限
    
    wire [47:0] in;
    reg [23:0] data;
    
    reg CLK;     
    reg [3:0] CNT_NUM;                                // 寄存器定义：时钟周期计数器
    
   // 时钟周期计数逻辑
           always @(posedge sys_clk or negedge sys_rest) begin
             if (!sys_rest) begin     //低电位重置
               CNT_NUM <= 4'd0;
               CLK <= 1'd1;
             end
             else if (CNT_NUM <= CLK_NUM/2 - 1'b1) begin
               CLK <= ~CLK;
               CNT_NUM <= 4'd0;
             end
             else begin
               CNT_NUM <= CNT_NUM + 1;
               CLK <= CLK;
             end
           end
           
    always @(posedge CLK or negedge sys_rest) begin
                      if (!sys_rest) begin        //低电位重置
                        tub1 <= 8'b00000000;
                        tub2 <= 8'b00000000;
                      end
                      else begin
                         case (NOTE)
                      `OneHotMIDDO: data <= 24'b000000_000000_111100_110011;       // Display '平调' for 6'b111100  Display '1' for 6'b110011
                      `OneHotMIDREI: data <= 24'b000000_000000_111100_110100;       // Display '平调' for 6'b111100  Display '2' for 6'b110100
                      `OneHotMIDMI: data <= 24'b000000_000000_111100_110101;       // Display '平调' for 6'b111100  Display '3' for 6'b110101
                      `OneHotMIDFA: data <= 24'b000000_000000_111100_110110;       // Display '平调' for 6'b111100  Display '4' for 6'b110110
                      `OneHotMIDSO: data <= 24'b000000_000000_111100_110111;       // Display '平调' for 6'b111100  Display '5' for 6'b110111
                      `OneHotMIDLA: data <= 24'b000000_000000_111100_111000;       // Display '平调' for 6'b111100  Display '6' for 6'b111000
                      `OneHotMIDTI: data <= 24'b000000_000000_111100_111001;       // Display '平调' for 6'b111100  Display '7' for 6'b111001
                      
                      `OneHotHIDO: data <= 24'b000000_000000_111101_110011;       // Display '升调' for 6'b111101  Display '1' for 6'b110011
                      `OneHotHIREI: data <= 24'b000000_000000_111101_110100;       // Display '升调' for 6'b111101  Display '2' for 6'b110100
                      `OneHotHIMI: data <= 24'b000000_000000_111101_110101;       // Display '升调' for 6'b111101  Display '3' for 6'b110101
                      `OneHotHIFA: data <= 24'b000000_000000_111101_110110;       // Display '升调' for 6'b111101  Display '4' for 6'b110110
                      `OneHotHISO: data <= 24'b000000_000000_111101_110111;       // Display '升调' for 6'b111101  Display '5' for 6'b110111
                      `OneHotHILA: data <= 24'b000000_000000_111101_111000;       // Display '升调' for 6'b111101  Display '6' for 6'b111000
                      `OneHotHITI: data <= 24'b000000_000000_111101_111001;       // Display '升调' for 6'b111101  Display '7' for 6'b111001
                      
                      `OneHotLOWDO: data <= 24'b000000_000000_111110_110011;       // Display '降调' for 6'b111110  Display '1' for 6'b110011
                      `OneHotLOWREI: data <= 24'b000000_000000_111110_110100;       // Display '降调' for 6'b111110  Display '2' for 6'b110100
                      `OneHotLOWMI: data <= 24'b000000_000000_111110_110101;       // Display '降调' for 6'b111110  Display '3' for 6'b110101
                      `OneHotLOWFA: data <= 24'b000000_000000_111110_110110;       // Display '降调' for 6'b111110  Display '4' for 6'b110110
                      `OneHotLOWSO: data <= 24'b000000_000000_111110_110111;       // Display '降调' for 6'b111110  Display '5' for 6'b110111
                      `OneHotLOWLA: data <= 24'b000000_000000_111110_111000;       // Display '降调' for 6'b111110  Display '6' for 6'b111000
                      `OneHotLOWTI: data <= 24'b000000_000000_111110_111001;       // Display '降调' for 6'b111110  Display '7' for 6'b111001
                      default: data <= 24'b000000_000000_000000_000000;
                      endcase
                      end
                      end
                      
                      assign in[47:42] = 6'b001111;   // Display 'P' for 6'b001111
                      assign in[41:36] = 6'b001011;   // Display 'L' for 6'b001011
                      assign in[35:30] = 6'b000000;   // Display 'A' for 6'b000000
                      assign in[29:24] = 6'b110000;   // Display 'Y' for 6'b110000
                      assign in[23:0] = data;
                      
                      Nixietube_control nc1(.sys_clk(sys_clk),.sys_rest(sys_rest),.in(in),.sel(sel),.tub1(tub1),.tub2(tub2));      //给到翻译机翻译显示
endmodule



module Proteus_AUTOPLAY_MODE(                  //autoplay mode 的 controller
input wire [47:0] SONG_NAME,
input sys_clk,sys_rest,
output reg [7:0] sel,
output reg [7:0] tub1,
output reg [7:0] tub2
    );
    
Nixietube_control nc2(.sys_clk(sys_clk),.sys_rest(sys_rest),.in(SONG_NAME),.sel(sel),.tub1(tub1),.tub2(tub2));      //给到翻译机翻译显示

endmodule


module Proteus_STUDY_MODE(                  //study mode 的 controller
input wire [9:0] NOTE,
input wire [9:0] store,
input sys_clk,sys_rest,
output reg [7:0] sel,
output reg [7:0] tub1,
output reg [7:0] tub2
    );
   
    wire [47:0] in;
    wire [5:0] grade;
    
    Grade g1(.store(store),.NOTE(NOTE),.clk(sys_clk),.rst(sys_rest),.grade(grade));
   
   assign in[47:42] = `LetterS;                // Display 'S' for 6'b010010
   assign in[41:36] = `LetterT;                // Display 'T' for 6'b010011
   assign in[35:30] = `LetterU;                // Display 'U' for 6'b101100
   assign in[29:24] = `LetterD;                // Display 'D' for 6'b000011
   assign in[23:18] = `LetterY;                // Display 'Y' for 6'b110000
   assign in[17:6] = 12'b000000_000000;   
   assign in[5:0] = grade;
   
Nixietube_control nc3(.sys_clk(sys_clk),.sys_rest(sys_rest),.in(in),.sel(sel),.tub1(tub1),.tub2(tub2));      //给到翻译机翻译显示

endmodule