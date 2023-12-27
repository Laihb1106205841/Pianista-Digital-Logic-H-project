`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: liang jie lin
// 
// Create Date: 2023/12/23 23:32:14
// Design Name: 
// Module Name: Indexgiver_STUDY_MODE
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

module Indexgiver_STUDY_MODE(
input [9:0] NoteAndPitch,
input [9:0] Pin_input,
input [1:0] state,
input clk,rst,
output reg [6:0] index
    );
 
reg index_flag;
always @(posedge clk)begin
//if(state== `LEARN_MODE)begin
//    index_flag <=1;
    
//end
end

//DBNT();
reg [0:27] Summ; 
   
always @(posedge clk or negedge rst) begin
      if (!rst) begin      //begin
       index <= 1;
       index_flag <= 1;
      end
      else if (NoteAndPitch == Pin_input) begin
           if (index_flag) begin
             index <= index + 1;
             index_flag <= 0;
           end
           else begin
             index <= index;
           end
       end
       else begin
           index_flag <= 1;
       end
end
endmodule
