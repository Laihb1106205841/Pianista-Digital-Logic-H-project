`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 梁杰林
//////////////////////////////////////////////////////////////////////////////////


module proteus_FREE_MODE(                  //free mode 的 controller
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
                      10'b1000000000: data <= 24'b000000_000000_111100_110011;       // Display '平调' for 6'b111100  Display '1' for 6'b110011
                      10'b0100000000: data <= 24'b000000_000000_111100_110100;       // Display '平调' for 6'b111100  Display '2' for 6'b110100
                      10'b0010000000: data <= 24'b000000_000000_111100_110101;       // Display '平调' for 6'b111100  Display '3' for 6'b110101
                      10'b0001000000: data <= 24'b000000_000000_111100_110110;       // Display '平调' for 6'b111100  Display '4' for 6'b110110
                      10'b0000100000: data <= 24'b000000_000000_111100_110111;       // Display '平调' for 6'b111100  Display '5' for 6'b110111
                      10'b0000010000: data <= 24'b000000_000000_111100_111000;       // Display '平调' for 6'b111100  Display '6' for 6'b111000
                      10'b0000001000: data <= 24'b000000_000000_111100_111001;       // Display '平调' for 6'b111100  Display '7' for 6'b111001
                      
                      10'b1000000100: data <= 24'b000000_000000_111101_110011;       // Display '升调' for 6'b111101  Display '1' for 6'b110011
                      10'b0100000100: data <= 24'b000000_000000_111101_110100;       // Display '升调' for 6'b111101  Display '2' for 6'b110100
                      10'b0010000100: data <= 24'b000000_000000_111101_110101;       // Display '升调' for 6'b111101  Display '3' for 6'b110101
                      10'b0001000100: data <= 24'b000000_000000_111101_110110;       // Display '升调' for 6'b111101  Display '4' for 6'b110110
                      10'b0000100100: data <= 24'b000000_000000_111101_110111;       // Display '升调' for 6'b111101  Display '5' for 6'b110111
                      10'b0000010100: data <= 24'b000000_000000_111101_111000;       // Display '升调' for 6'b111101  Display '6' for 6'b111000
                      10'b0000001100: data <= 24'b000000_000000_111101_111001;       // Display '升调' for 6'b111101  Display '7' for 6'b111001
                      
                      10'b1000000010: data <= 24'b000000_000000_111110_110011;       // Display '降调' for 6'b111110  Display '1' for 6'b110011
                      10'b0100000010: data <= 24'b000000_000000_111110_110100;       // Display '降调' for 6'b111110  Display '2' for 6'b110100
                      10'b0010000010: data <= 24'b000000_000000_111110_110101;       // Display '降调' for 6'b111110  Display '3' for 6'b110101
                      10'b0001000010: data <= 24'b000000_000000_111110_110110;       // Display '降调' for 6'b111110  Display '4' for 6'b110110
                      10'b0000100010: data <= 24'b000000_000000_111110_110111;       // Display '降调' for 6'b111110  Display '5' for 6'b110111
                      10'b0000010010: data <= 24'b000000_000000_111110_111000;       // Display '降调' for 6'b111110  Display '6' for 6'b111000
                      10'b0000001010: data <= 24'b000000_000000_111110_111001;       // Display '降调' for 6'b111110  Display '7' for 6'b111001
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



module proteus_AUTOPLAY_MODE(                  //autoplay mode 的 controller
input wire [47:0] SONG_NAME,
input sys_clk,sys_rest,
output reg [7:0] sel,
output reg [7:0] tub1,
output reg [7:0] tub2
    );
    
Nixietube_control nc2(.sys_clk(sys_clk),.sys_rest(sys_rest),.in(SONG_NAME),.sel(sel),.tub1(tub1),.tub2(tub2));      //给到翻译机翻译显示

endmodule


module proteus_STUDY_MODE(                  //study mode 的 controller
input wire [5:0] grade,
input sys_clk,sys_rest,
output reg [7:0] sel,
output reg [7:0] tub1,
output reg [7:0] tub2
    );
   
    wire [47:0] in;
   
   assign in[47:42] = 6'b010010;                // Display 'S' for 6'b010010
   assign in[41:36] = 6'b010011;                // Display 'T' for 6'b010011
   assign in[35:30] = 6'b101100;                // Display 'U' for 6'b101100
   assign in[29:24] = 6'b000011;                // Display 'D' for 6'b000011
   assign in[23:18] = 6'b110000;                // Display 'Y' for 6'b110000
   assign in[17:6] = 12'b000000_000000;   
   assign in[5:0] = grade;
   
Nixietube_control nc3(.sys_clk(sys_clk),.sys_rest(sys_rest),.in(in),.sel(sel),.tub1(tub1),.tub2(tub2));      //给到翻译机翻译显示

endmodule