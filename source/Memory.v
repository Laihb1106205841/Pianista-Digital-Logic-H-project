`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: haibin + ?
// 
// Create Date: 2023/12/02 16:29:00
// Design Name: 
// Module Name: Memory
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


module Memory(
    input clk,
    input memWrite,
    input writeData,
    output readData
    );
    reg [15:2] address;
    // Ð¡ÐÇÐÇµÄÀÖÆ×: abcdefg
    reg[9:0] LittleStar[100:0];
        
    
    //Create a instance of RAM(IP core), binding the ports
    RAM ram (
    .clka(clk), // input wire clka
    .wea(memWrite), // input wire [0 : 0] wea
    .addra(address[15:2]), // input wire [13 : 0] addra
    .dina(writeData), // input wire [31 : 0] dina
    .douta(readData) // output wire [31 : 0] douta
    );

    initial begin
         
    end
    
endmodule
