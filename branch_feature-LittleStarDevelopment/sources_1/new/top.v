`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Wang Taojie
// 
// Create Date: 2023/12/13 23:07:45
// Design Name: 
// Module Name: top
// Using Vivado IP core to implement storage.
// Achieved: Store a piece of notes of Little Star in rom. Functinality verified.
// Todo next:
// 1. Complete the whole pieces for Little Star. 
// 2. Implement recording - write functionality. 
// 3.* Store the duration for each playing note, instaed of all lasting ```duration_single_note```. 

//////////////////////////////////////////////////////////////////////////////////

`include "para.v"


module top(
    input clk,
    output speaker,
    output sel
);
    assign sel = 1;
    parameter duration_single_note = 50000000, pause_duration = 10000000;

    reg [6:0]index; // noteBook[index] sould be the note to play.
    wire [9:0]bus; // note + pitch.
    reg [31:0]counter; // counter for 1 second, each note play 1 sec.
    reg [31:0] delay_counter;
    reg stop; // indicating the space between two notes, act as an enable in Buzzer.
    wire[9:0] length; // The number of notes in the song, stored in rom[0].

    initial begin // initialization
        index = 1;
        counter = 0;
        delay_counter = 0;
        stop = 0;
    end

    // Testing: output the note of index 1
     LittleStar_Notes nt(.addra(index), .clka(clk), .douta(bus)); 
     LittleStar_Notes getLength(.addra(0), .clka(clk), .douta(length)); // rom[0] stores the number of notes.
     // Remark: if you write IP core, note that declare the ports.
     // LittleStar_Notes nt(index, clk, .bus);  - > this will not work. 

    // Space are added between two notes.
    always @(posedge clk) begin
        if (counter < duration_single_note) begin
            counter <= counter + 1; 
        end else begin
            if (delay_counter < pause_duration) begin // space between notes.
                delay_counter <= delay_counter + 1;
                stop <= 1;
            end else begin
                delay_counter <= 0; 
                stop <= 0;
                counter <= 0;
                index <= index + 1; // change the note.
                if (index > length) begin
                    index <= 1; // loop play little stars.
                end
            end
        end
    end

     wire sel_uselss, markLED_useless; // LED not needed.
     wire [6:0]note;
     wire [2:0]pitch;
     assign note = bus[9:3]; // seperate the note and pitch.
     assign pitch = bus[2:0];
    Buzzer bz(stop ,clk, note, pitch, speaker, sel_uselss, markLED_useless); // play!
    
endmodule