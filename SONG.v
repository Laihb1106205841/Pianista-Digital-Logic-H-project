`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/27 04:33:38
// Design Name: 
// Module Name: SONG
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

`include "n_tube.v"
module SONG(
input [1:0] song,
output reg [0:47] SONG_NAME
    );
    always @(*)begin
    case(song)
    2'b00:begin
     SONG_NAME[0:5] = `LetterP;
    SONG_NAME[6:11] = `LetterL;
    SONG_NAME[12:17] = `LetterA;    
     SONG_NAME[18:23] = `Number0;    
    end
    
    2'b01:begin
    SONG_NAME[0:5] = `LetterS;
    SONG_NAME[6:11] = `LetterT;
    SONG_NAME[12:17] = `LetterA;   
    SONG_NAME[18:23] = `LetterR;            
        SONG_NAME[24:31] = `Number1;  
    end
    
    2'b10:begin
    SONG_NAME[0:5] = `LetterH;
    SONG_NAME[6:11] = `LetterA;
    SONG_NAME[12:17] = `LetterP;   
    SONG_NAME[18:23] = `LetterP    ;
      SONG_NAME[24:31] = `LetterY;
        SONG_NAME[32:39] = `Number2;    
    end
    
    
    2'b11:begin
    SONG_NAME[0:5] = `LetterB;
    SONG_NAME[6:11] = `LetterE;
    SONG_NAME[12:17] = `LetterL;
 
    SONG_NAME[18:23] = `LetterL;    
         SONG_NAME[24:31] = `Number3;         
    end
    endcase
    end
    
    
    
endmodule
