`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/13 23:07:45
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    output speaker,
    output sel
);
    assign sel = 1; // TEST ARE CONDUCTED ON EARPHONE, NOT BUZZER.

    reg [7:0]index; // noteBook[index] sould be the note to play.
    wire [9:0]bus; // note + pitch. The output from Memory module.
    reg [31:0]counter; // counter for 1 second, each note play 1 sec.
    reg [31:0] delay_counter; // counter for the spcace between two  consecutive notes.
    reg stop; // indicating the space between two notes, act as an enable in Buzzer.

    initial begin
        index = 0;
        counter = 0;
        delay_counter = 0;
        stop = 0;
    end

     Memory mem(index, bus); // Get the note and pitch from the memory module.

    always @(posedge clk) begin
        if (counter < 50000000) begin
            counter <= counter + 1; 
        end else begin
            if (delay_counter < 10000000) begin // space between notes.
                delay_counter <= delay_counter + 1;
                stop <= 1;
            end else begin
                delay_counter <= 0; 
                stop <= 0;
                counter <= 0;
                index <= index + 1; // change the note.
                if (index > 30) begin
                    index <= 0; // loop play little stars.
                end
            end
            
        end
    end

     wire sel_uselss, markLED_useless; // We don't need LED this time.
     wire [6:0]note;
     wire [2:0]pitch;
     assign note = bus[9:3]; // seperate the note and pitch.
     assign pitch = bus[2:0];
    Buzzer bz(stop ,clk, note, pitch, speaker, sel_uselss, markLED_useless); // play!
    
endmodule