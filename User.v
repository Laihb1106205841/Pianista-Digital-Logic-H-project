`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 23:53:33
// Design Name: 
// Module Name: User
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

`include "para.v"
module User(
input [1:0] WhichUser,
input [1:0]state,
input clk,
input rst,
input [9:0] store,
input [9:0] NOTE,

output [5:0] grade
    );
     reg[5:0] sb_grade;
     reg[5:0] A_USER;
     reg[5:0] B_USER;
     reg[5:0] C_USER;
    
    always @(posedge clk) begin
        if (state == `LEARN_MODE) begin
             case(WhichUser)
             2'b01:      sb_grade <= A_USER;
             2'b10:     sb_grade <= B_USER;
              2'b11:     sb_grade <= C_USER;
             endcase
//             if (WhichUser == 3'b01) begin
//                sb_grade <= A_USER;
//             end
             
        end
    end
    //////////////////////////////////////////////////////////
       reg [26:0] counter;  
       always @(posedge clk or negedge rst) begin
        if (!rst) begin
          counter <= 0;
//          sb_grade <= 0;
        end else begin
//          if(WhichUser == 3'b001)begin
                
                if (counter < 3_0000_0000 && NOTE!=store)begin 
//             if (counter < 10000_0000)begin 
                counter <= counter + 1;
                end
                if (counter < 6_0000_0000 && NOTE==store)begin 
//             if (counter < 10000_0000)begin 
                counter <= counter - 1;
                end
                else begin
                counter <= 0;                     //根据两者不一样的时间计算分数
                sb_grade <= sb_grade+1;
          
                    if(sb_grade == 5) begin

                     end
                end
//            end
        end
      end
      
      wire [5:0] grades;
      
always @(*) begin      
//    case({grades})
//      7'b0000_001: grade = `LetterS;  // Display 'S' for 6'b010010 
//      7'b0001_001: grade = `LetterA;  // Display 'A' for 6'b000000
//      7'b0010_001: grade = `LetterB;  // Display 'B' for 6'b000001
//      7'b0011_001: grade = `LetterC;  // Display 'C' for 6'b000010
//      7'b0100_001: grade = `LetterD;  // Display 'D' for 6'b000011
//      7'b0101_001: grade = `LetterE;
//      default: grade = `LetterF;
//    endcase
 end  
    
    Grade1 g(.store(store),.NOTE(NOTE),.clk(clk),.rst(rst),.grade(grade));
    
//assign UserCount = outCount;
    
    
endmodule
