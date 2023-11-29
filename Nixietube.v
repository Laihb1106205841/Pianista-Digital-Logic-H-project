`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 梁杰林

//////////////////////////////////////////////////////////////////////////////////q

  module Nixietube_control (
  input sys_clk,sys_rest,
  input wire [47:0] in,
  output reg [7:0] sel,
  output reg [7:0] tub1,
  output reg [7:0] tub2
);

 parameter CLK_NUM = 4'd10;                       // 参数定义：时钟周期计数上限
 parameter MSNUM = 14'd5000;                      // 参数定义：毫秒计数上限

 reg [3:0] CNT_NUM;                                // 寄存器定义：时钟周期计数器
 reg CLK;                                          // 寄存器定义：时钟信号
  
 reg [12:0] MSCNT;                                 // 寄存器定义：毫秒计数器
 reg MS_flag;                                      // 寄存器定义：毫秒标志
 reg [5:0] char_display1;                          // 寄存器定义：当前显示的字符1
 reg [5:0] char_display2;                          // 寄存器定义：当前显示的字符2
 
 reg [47:0] data;                                  // 寄存器定义：当前显示的完整数据
 reg [6:0] sel_num;                                // 寄存器定义：当前选择的数码管位数
 
   // 七段数码管输入信号定义
   wire [5:0] data0;                                 // 个
   wire [5:0] data1;                                 // 十
   wire [5:0] data2;                                 // 百
   wire [5:0] data3;                                 // 千
   wire [5:0] data4;                                 // 万
   wire [5:0] data5;                                 // 十万
   wire [5:0] data6;                                 // 百万
   wire [5:0] data7;                                 // 千万
   
   // 提取显示数值所对应的字符的各个位
     assign data0 = in[5:0];                         // 个
     assign data1 = in[11:6];                        // 十
     assign data2 = in[17:12];                       // 百
     assign data3 = in[23:18];                       // 千
     assign data4 = in[29:24];                       // 万
     assign data5 = in[35:30];                       // 十万
     assign data6 = in[41:36];                       // 百万
     assign data7 = in[47:42];                       // 千万
     
     
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
       
    // 数值提取逻辑
         always @(posedge CLK or negedge sys_rest) begin
           if (!sys_rest) begin     //低电位重置
             data <= 47'd0;
           end
           else begin
             data[47:42]  <= data7;
             data[41:36]  <= data6;
             data[35:30]  <= data5;
             data[29:24]  <= data4;
             data[23:18]  <= data3;
             data[17:12]  <= data2;
             data[11:6]   <= data1;
             data[5:0]    <= data0;
           end
         end
         
      // 产生1ms脉冲逻辑
           always @(posedge CLK or negedge sys_rest) begin
             if (!sys_rest) begin      //低电位重置
               MSCNT <= 13'd0;
               MS_flag <= 1'b0;
             end
             else if (MSCNT == MSNUM - 1) begin
               MSCNT <= 13'd0;
               MS_flag <= 1'b1;
             end
             else begin
               MSCNT <= MSCNT + 1;
               MS_flag <= 1'b0;
             end
           end
           
           
     // 数码管选择逻辑
             always @(posedge CLK or negedge sys_rest) begin
               if (!sys_rest) begin      //低电位重置
                 sel_num <= 0;
               end
               else if (MS_flag) begin
                 if (sel_num < 7'd7) begin
                   sel_num <= sel_num + 1;
                 end
                 else begin
                   sel_num <= 0;
                 end
               end
               else begin
                 sel_num <= sel_num;
               end
             end
             
             
      // 数码管显示逻辑
               always @(posedge CLK or negedge sys_rest) begin
                 if (!sys_rest) begin        //低电位重置
                   sel <= 8'b00000000;
                 end
                 else begin
                   case (sel_num)
                     7'd0: begin
                       sel <= 8'b00000001;  // 显示数码管第1位
                       char_display1 <= data[5:0];
                     end
                     7'd1: begin
                       sel <= 8'b00000010;  // 显示数码管第2位
                      char_display1 <= data[11:6];
                     end
                     7'd2: begin
                       sel <= 8'b00000100;  // 显示数码管第3位
                       char_display1 <= data[17:12];
                     end
                     7'd3: begin
                       sel <= 8'b00001000;  // 显示数码管第4位
                       char_display1 <= data[23:18];                  
                     end
                     7'd4: begin
                       sel <= 8'b00010000;  // 显示数码管第5位
                       char_display2 <= data[29:24];
                     end
                     7'd5: begin
                       sel <= 8'b00100000;  // 显示数码管第6位
                      char_display2 <= data[35:30];
                     end
                     7'd6: begin
                       sel <= 8'b01000000;  // 显示数码管第7位
                       char_display2 <= data[41:36];
                     end
                     7'd7: begin
                       sel <= 8'b10000000;  // 显示数码管第8位
                       char_display2 <= data[47:42];                  
                     end 
                     default sel <= 8'b00000000;
                   endcase
                 end
               end
               
               
           // 数码管LED显示逻辑
                 always @(posedge CLK or negedge sys_rest) begin
                   if (!sys_rest) begin        //低电位重置
                     tub1 <= 8'b00000000;
                     tub2 <= 8'b00000000;
                   end
                   else begin
                      case (char_display1)
                      6'b000000: tub1 <= 8'b11101110; // Display 'A' for 6'b000000
                      6'b000001: tub1 <= 8'b00111110; // Display 'B' for 6'b000001
                      6'b000010: tub1 <= 8'b10011100; // Display 'C' for 6'b000010
                      6'b000011: tub1 <= 8'b01111010; // Display 'D' for 6'b000011
                      6'b000100: tub1 <= 8'b10011110; // Display 'E' for 6'b000100
                      6'b000101: tub1 <= 8'b10001110; // Display 'F' for 6'b000101
                      6'b000110: tub1 <= 8'b10111100; // Display 'G' for 6'b000110
                      6'b000111: tub1 <= 8'b01101110; // Display 'H' for 6'b000111
                      6'b001000: tub1 <= 8'b11110000; // Display 'I' for 6'b001000
                      6'b001001: tub1 <= 8'b01110000; // Display 'J' for 6'b001001
                      6'b001010: tub1 <= 8'b10101110; // Display 'K' for 6'b001010
                      6'b001011: tub1 <= 8'b00011100; // Display 'L' for 6'b001011
                      6'b001100: tub1 <= 8'b11101100; // Display 'M' for 6'b001100
                      6'b001101: tub1 <= 8'b00101010; // Display 'N' for 6'b001101
                      6'b001110: tub1 <= 8'b00111010; // Display 'O' for 6'b001110
                      6'b001111: tub1 <= 8'b11001110; // Display 'P' for 6'b001111
                      6'b010000: tub1 <= 8'b11100110; // Display 'Q' for 6'b010000
                      6'b010001: tub1 <= 8'b10001100; // Display 'R' for 6'b010001
                      6'b010010: tub1 <= 8'b10010010; // Display 'S' for 6'b010010
                      6'b010011: tub1 <= 8'b00011110; // Display 'T' for 6'b010011
                      6'b101100: tub1 <= 8'b01111100; // Display 'U' for 6'b101100
                      6'b101101: tub1 <= 8'b00111000; // Display 'V' for 6'b101101
                      6'b101110: tub1 <= 8'b01111110; // Display 'W' for 6'b101110
                      6'b101111: tub1 <= 8'b00100110; // Display 'X' for 6'b101111
                      6'b110000: tub1 <= 8'b01110110; // Display 'Y' for 6'b110000
                      6'b110001: tub1 <= 8'b01011010; // Display 'Z' for 6'b110001
                      
                      6'b110010: tub1 <= 8'b11111100; // Display '0' for 6'b110010
                      6'b110011: tub1 <= 8'b01100000; // Display '1' for 6'b110011
                      6'b110100: tub1 <= 8'b11011010; // Display '2' for 6'b110100
                      6'b110101: tub1 <= 8'b11110010; // Display '3' for 6'b110101
                      6'b110110: tub1 <= 8'b01100110; // Display '4' for 6'b110110
                      6'b110111: tub1 <= 8'b10110110; // Display '5' for 6'b110111
                      6'b111000: tub1 <= 8'b10111110; // Display '6' for 6'b111000
                      6'b111001: tub1 <= 8'b11100100; // Display '7' for 6'b111001
                      6'b111010: tub1 <= 8'b11111110; // Display '8' for 6'b111010
                      6'b111011: tub1 <= 8'b11110110; // Display '9' for 6'b111011
                      6'b111111: tub1 <= 8'b01111111; // Display '.' for 6'b111111
                      default: tub1 <= 8'b00000000;   // Default case and display ' '
                      endcase
                      case (char_display2)
                      6'b000000: tub2 <= 8'b11101110; // Display 'A' for 6'b000000
                      6'b000001: tub2 <= 8'b00111110; // Display 'B' for 6'b000001
                      6'b000010: tub2 <= 8'b10011100; // Display 'C' for 6'b000010
                      6'b000011: tub2 <= 8'b01111010; // Display 'D' for 6'b000011
                      6'b000100: tub2 <= 8'b10011110; // Display 'E' for 6'b000100
                      6'b000101: tub2 <= 8'b10001110; // Display 'F' for 6'b000101
                      6'b000110: tub2 <= 8'b10111100; // Display 'G' for 6'b000110
                      6'b000111: tub2 <= 8'b01101110; // Display 'H' for 6'b000111
                      6'b001000: tub2 <= 8'b11110000; // Display 'I' for 6'b001000
                      6'b001001: tub2 <= 8'b01110000; // Display 'J' for 6'b001001
                      6'b001010: tub2 <= 8'b10101110; // Display 'K' for 6'b001010
                      6'b001011: tub2 <= 8'b00011100; // Display 'L' for 6'b001011
                      6'b001100: tub2 <= 8'b11101100; // Display 'M' for 6'b001100
                      6'b001101: tub2 <= 8'b00101010; // Display 'N' for 6'b001101
                      6'b001110: tub2 <= 8'b00111010; // Display 'O' for 6'b001110
                      6'b001111: tub2 <= 8'b11001110; // Display 'P' for 6'b001111
                      6'b010000: tub2 <= 8'b11100110; // Display 'Q' for 6'b010000
                      6'b010001: tub2 <= 8'b10001100; // Display 'R' for 6'b010001
                      6'b010010: tub2 <= 8'b10010010; // Display 'S' for 6'b010010
                      6'b010011: tub2 <= 8'b00011110; // Display 'T' for 6'b010011
                      6'b101100: tub2 <= 8'b01111100; // Display 'U' for 6'b101100
                      6'b101101: tub2 <= 8'b00111000; // Display 'V' for 6'b101101
                      6'b101110: tub2 <= 8'b01111110; // Display 'W' for 6'b101110
                      6'b101111: tub2 <= 8'b00100110; // Display 'X' for 6'b101111
                      6'b110000: tub2 <= 8'b01110110; // Display 'Y' for 6'b110000
                      6'b110001: tub2 <= 8'b01011010; // Display 'Z' for 6'b110001
                                       
                      6'b110010: tub2 <= 8'b11111100; // Display '0' for 6'b110010
                      6'b110011: tub2 <= 8'b01100000; // Display '1' for 6'b110011
                      6'b110100: tub2 <= 8'b11011010; // Display '2' for 6'b110100
                      6'b110101: tub2 <= 8'b11110010; // Display '3' for 6'b110101
                      6'b110110: tub2 <= 8'b01100110; // Display '4' for 6'b110110
                      6'b110111: tub2 <= 8'b10110110; // Display '5' for 6'b110111
                      6'b111000: tub2 <= 8'b10111110; // Display '6' for 6'b111000
                      6'b111001: tub2 <= 8'b11100100; // Display '7' for 6'b111001
                      6'b111010: tub2 <= 8'b11111110; // Display '8' for 6'b111010
                      6'b111011: tub2 <= 8'b11110110; // Display '9' for 6'b111011
                      6'b111111: tub2 <= 8'b01111111; // Display '.' for 6'b111111
                      default: tub2 <= 8'b00000000;   // Default case and display ' '
                      endcase
end
end
 
endmodule


