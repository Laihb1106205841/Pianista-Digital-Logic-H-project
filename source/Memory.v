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
`include "para.v"

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
        LittleStar[0] = `OneHotHIDO;
        LittleStar[1] = `OneHotHIDO;
        LittleStar[2] = `OneHotHISO;
        LittleStar[3] = `OneHotHISO;
        LittleStar[4] = `OneHotHILA;
        LittleStar[5] = `OneHotHILA;
        LittleStar[6] = `OneHotHISO;
        LittleStar[7] = `OneHotHIFA;
        LittleStar[8] = `OneHotHIFA;
        LittleStar[9] = `OneHotHIMI;
        LittleStar[10] = `OneHotHIMI;
        LittleStar[11] = `OneHotHIREI;
        LittleStar[12] = `OneHotHIREI;
        LittleStar[13] = `OneHotHIDO;
    end
    
endmodule
