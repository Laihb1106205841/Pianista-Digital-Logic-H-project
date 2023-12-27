`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:赖海斌 
// 
// Create Date: 2023/12/23 23:34:38
// Design Name: 
// Module Name: VGAt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module VGA_Display_Color_OneHot (
  input wire clk,             // 时钟输入
  input wire rst,             // 复位输入
  input wire [6:0] input_signal, // 输入信号，7位表示7种颜色

  output reg [3:0] red,       // 红色分量输出
  output reg [3:0] green,     // 绿色分量输出
  output reg [3:0] blue,      // 蓝色分量输出
  output reg h_sync,          // 水平同步信号输出
  output reg v_sync           // 垂直同步信号输出
);

  // VGA参数
  parameter H_SYNC_CYCLES = 96; // 水平同步脉冲周期
  parameter H_BACK_PORCH = 48; // 水平后肩周期
  parameter H_ACTIVE = 640;    // 水平活动周期
  parameter H_FRONT_PORCH = 16; // 水平前肩周期
  parameter V_SYNC_LINES = 2;   // 垂直同步行数
  parameter V_BACK_PORCH = 33;  // 垂直后肩周期
  parameter V_ACTIVE = 480;     // 垂直活动周期
  parameter V_FRONT_PORCH = 10; // 垂直前肩周期

  // 内部计数器
  reg [10:0] h_count = 0;
  reg [10:0] v_count = 0;

  // VGA信号生成
//  reg h_sync, v_sync;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      h_count <= 0;
      v_count <= 0;
      h_sync <= 0;
      v_sync <= 0;
    end else begin
      // 水平计数
      if (h_count == H_SYNC_CYCLES + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH - 1)
        h_count <= 0;
      else
        h_count <= h_count + 1;

      // 垂直计数
      if (v_count == V_SYNC_LINES + V_BACK_PORCH + V_ACTIVE + V_FRONT_PORCH - 1) begin
        v_count <= 0;
        h_sync <= 1; // 在垂直同步周期内，水平同步信号为高
      end else begin
        v_count <= v_count + 1;
        h_sync <= 0;
      end

      // 垂直同步信号
      if (v_count == V_SYNC_LINES + V_BACK_PORCH - 1)
        v_sync <= 1;
      else if (v_count == V_SYNC_LINES + V_BACK_PORCH + V_ACTIVE + V_FRONT_PORCH - 1)
        v_sync <= 0;
    end
  end

  // 颜色选择
  always @* begin
    case (input_signal)
      7'b1000000: begin // 输入为1000000时，红色
        red = 4'b1111;
        green = 4'b0000;
        blue = 4'b0000;
      end
      7'b0100000: begin // 输入为0100000时，橙色
        red = 4'b1111;
        green = 4'b1100;
        blue = 4'b0000;
      end
      7'b0010000: begin // 输入为0010000时，黄色
        red = 4'b1111;
        green = 4'b1111;
        blue = 4'b0000;
      end
      7'b0001000: begin // 输入为0001000时，绿色
        red = 4'b0000;
        green = 4'b1111;
        blue = 4'b0000;
      end
      7'b0000100: begin // 输入为0000100时，青色
        red = 4'b0000;
        green = 4'b1111;
        blue = 4'b1111;
      end
      7'b0000010: begin // 输入为0000010时，蓝色
        red = 4'b0000;
        green = 4'b0000;
        blue = 4'b1111;
      end
      7'b0000001: begin // 输入为0000001时，紫色
        red = 4'b1111;
        green = 4'b0000;
        blue = 4'b1111;
      end
      default: begin // 默认为黑色
        red = 4'b0000;
        green = 4'b0000;
        blue = 4'b0000;
      end
    endcase
  end

endmodule



