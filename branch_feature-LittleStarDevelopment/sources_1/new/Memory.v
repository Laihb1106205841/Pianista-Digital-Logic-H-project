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
    // width of input and output must be properly set.
    input [7:0]index,
    output [9:0]out
);
    assign out = LittleStar[index];
    
    reg [15:2] address;
    reg[9:0] LittleStar[100:0];
        
    
    //Create a instance of RAM(IP core), binding the ports
    /*RAM ram (
    .clka(clk), // input wire clka
    .wea(memWrite), // input wire [0 : 0] wea
    .addra(address[15:2]), // input wire [13 : 0] addra
    .dina(writeData), // input wire [31 : 0] dina
    .douta(readData) // output wire [31 : 0] douta
    );*/

    initial begin
        LittleStar[0] = `OneHotHIDO;
        LittleStar[1] = `OneHotHIDO;
        LittleStar[2] = `OneHotHISO;
        LittleStar[3] = `OneHotHISO;
        LittleStar[4] = `OneHotHILA;
        LittleStar[5] = `OneHotHILA;
        LittleStar[6] = `OneHotHISO;
        LittleStar[7] = `OneHotHISO;
        LittleStar[8] = `OneHotHIFA;
        LittleStar[9] = `OneHotHIFA;
        LittleStar[10] = `OneHotHIMI;
        LittleStar[11] = `OneHotHIMI;
        LittleStar[12] = `OneHotHIREI;
        LittleStar[13] = `OneHotHIREI;
        LittleStar[14] = `OneHotHIDO;
        LittleStar[15] = `OneHotHIDO;
        LittleStar[16] = `OneHotHISO;
        LittleStar[17] = `OneHotHISO;
        LittleStar[18] = `OneHotHIFA;
        LittleStar[19] = `OneHotHIFA;
        LittleStar[20] = `OneHotHIMI;
        LittleStar[21] = `OneHotHIMI;
        LittleStar[22] = `OneHotHIREI;
        LittleStar[23] = `OneHotHIREI;
        LittleStar[24] = `OneHotHISO;
        LittleStar[25] = `OneHotHISO;
        LittleStar[26] = `OneHotHIFA;
        LittleStar[27] = `OneHotHIFA;
        LittleStar[28] = `OneHotHIMI;
        LittleStar[29] = `OneHotHIMI;
        LittleStar[30] = `OneHotHIREI;
    end
    
endmodule