`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 梁杰林
// 
// Create Date: 2023/12/27 16:09:30
// Design Name: 
// Module Name: user
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

`include "UARTNixietube.v"      
module user(                              //通过一些延时，错开赋值达到切换用户的目的
input wire [9:0] store,
input wire [9:0] NOTE,
input wire [5:0] grade,
input wire [1:0] Select_user,
input wire clk,       // Clock input
input wire rst,        // Reset input
output reg [5:0] user_grade     //显示当前用户的评级
    );
    reg [26:0] counter;    
    reg [4:0]  count;
        
    reg [5:0] previous_grade;
    reg [1:0] previous_select;
    
    reg [5:0] user1_grade;
    reg [5:0] user2_grade;
    reg [5:0] user3_grade;
    
    reg [0:0] flag1;
    reg [0:0] flag2;
    
always @(posedge clk or negedge rst) begin
           if (!rst) begin
             user1_grade <= 0;
             user2_grade <= 0;
             user3_grade <= 0;
             previous_grade <= 6'b000000;
             previous_select <= 2'b00;
             flag1 <= 0;
             flag2 <= 0;
end
           
           if(Select_user != previous_select)
             flag1 <= 0;
             flag2 <= 1;
             
           if((Select_user != previous_select) & counter == 5)
             previous_select <= Select_user;
             flag2 <=0;
end
         
        
        
always @(*) 
begin      //加载先前的grade，加载完成后将flag变为1阻止其继续赋值
if(!flag1)
   case(previous_grade)
    `LetterS: count = 0;  // Display 'S' for 6'b010010 
    `LetterA: count = 1;  // Display 'A' for 6'b000000
    `LetterB: count = 2;  // Display 'B' for 6'b000001
    `LetterC: count = 3;  // Display 'C' for 6'b000010
    `LetterD: count = 4;  // Display 'D' for 6'b000011
    
    `LetterS: counter = 0;  // Display 'S' for 6'b010010 
    `LetterA: counter = 0;  // Display 'A' for 6'b000000
    `LetterB: counter = 0;  // Display 'B' for 6'b000001
    `LetterC: counter = 0;  // Display 'C' for 6'b000010
    `LetterD: counter = 0;  // Display 'D' for 6'b000011  //重置计数器
                     
    `LetterS: flag1 = 1; 
    `LetterA: flag1 = 1;
    `LetterB: flag1 = 1; 
    `LetterC: flag1 = 1;  
    `LetterD: flag1 = 1; 
   default: count = count;    // 不符合时维持原样
  endcase
end       
                
       

always @(*) 
    begin        //根据当前状态赋值
    if(!flag2)
          case(Select_user)
          2'b00:user1_grade = user_grade;
          2'b01:user2_grade = user_grade;
          2'b10:user3_grade = user_grade;
          
          default:user_grade = user_grade;
          endcase
          end  


            
 always @(posedge clk or negedge rst) begin
         if (!rst) begin
           counter <= 0;
           count <= 0;
         end
                    
          if (counter < 100000 && store!= NOTE) 
           counter <= counter + 1;
          else 
           counter <= 0;                     //根据两者不一样的时间计算分数
           count <= count+1;
                    
          if(count == 5) 
           count <= 0;   
          end
                
 always @(*) begin      
         case(count)
                4'h0: user_grade = `LetterS;  // Display 'S' for 6'b010010 
                4'h1: user_grade = `LetterA;  // Display 'A' for 6'b000000
                4'h2: user_grade = `LetterB;  // Display 'B' for 6'b000001
                4'h3: user_grade = `LetterC;  // Display 'C' for 6'b000010
                4'h4: user_grade = `LetterD;  // Display 'D' for 6'b000011
                default: user_grade = 6'b000000;
          endcase
 end               
endmodule



