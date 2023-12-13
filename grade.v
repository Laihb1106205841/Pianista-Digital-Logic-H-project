`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 梁杰林
//////////////////////////////////////////////////////////////////////////////////


module grade(
  input wire [9:0] store,
  input wire [9:0] NOTE,
  input wire clk,       // Clock input
  input wire rst,       // Reset input
  output reg [5:0] grade
    );
    
     reg [26:0] counter;    
     reg [4:0] count;
     
      always @(posedge clk or negedge rst) begin
        if (!rst) begin
          counter <= 0;
          count <= 0;
          
          
          if (counter < 100000 && store!= NOTE) counter <= counter + 1;
          else 
          counter <= 0;                     //根据两者不一样的时间计算分数
          count <= count+1;
          
          if(count == 5) count <= 0;
          
        end
      end
      
always @(*) begin      
      case(count)
      4'h0: grade = 6'b010010;  // Display 'S' for 6'b010010 
      4'h1: grade = 6'b000000;  // Display 'A' for 6'b000000
      4'h2: grade = 6'b000001;  // Display 'B' for 6'b000001
      4'h3: grade = 6'b000010;  // Display 'C' for 6'b000010
      4'h4: grade = 6'b000011;  // Display 'D' for 6'b000011
      default: grade = 6'b000000;
 endcase
 end  
      
endmodule
