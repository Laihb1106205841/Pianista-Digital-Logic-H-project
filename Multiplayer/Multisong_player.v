// @para: n_th_song, clk, rst_n
// @return: bus = {note, pitch}

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Wang Taojie
// 
// Create Date: 2023/12/13 23:07:45
// Design Name: 
// Module Name: Multisong_player
// Using Vivado IP core to implement storage.
// Description: this module is based on top module. Note that Buzzer module is moved to a upper level.
// New features: we can now play multiple songs, and the input and output change

//////////////////////////////////////////////////////////////////////////////////

module Multisong_player(
    input clk,
    input rst_n,
    input [1:0]n_th_song, // 00: don't play, 01: play little star, 10: play happy birthday, 11: play jingle bell
    output reg[9:0]note_and_pitch // note + pitch
);
    // variable declaration
    parameter duration_single_note = 50000000, pause_duration = 10000000;
    reg [6:0]index_LS; reg [6:0]index_HB; reg [6:0]index_JB;// noteBook[index] sould be the note to play. We need multiple index for multiple songs.
    wire [9:0]bus_LS; wire [9:0]bus_HB; wire [9:0]bus_JB;// note + pitch.
    reg [31:0]counter_LS; reg [31:0]counter_HB; reg [31:0]counter_JB;// counter for 1 second, each note play 1 sec.
    reg [31:0] delay_counter_LS; reg [31:0] delay_counter_HB; reg [31:0] delay_counter_JB;
    reg stop_LS; reg stop_HB; reg stop_JB;// indicating the space between two notes, act as an enable in Buzzer.
    wire[9:0] length_LS; wire[9:0] length_HB; wire[9:0] length_JB;// The number of notes in the song, stored in rom[0].
    reg [1:0]n_th_song_last;
    reg [1:0]n_th_song_current; // used to detect the change of song.

    // read from IP core logic
    LittleStar_Notes nt_LS(.addra(index_LS), .clka(clk), .douta(bus_LS)); 
    LittleStar_Notes getLength_LS(.addra(0), .clka(clk), .douta(length_LS)); // rom[0] stores the number of notes.
    HappyBirthday_Notes nt_HB(.addra(index_HB), .clka(clk), .douta(bus_HB));
    HappyBirthday_Notes getLength_HB(.addra(0), .clka(clk), .douta(length_HB));
    JingleBell_Notes nt_JB(.addra(index_JB), .clka(clk), .douta(bus_JB));
    JingleBell_Notes getLength_JB(.addra(0), .clka(clk), .douta(length_JB));

    // Little star index computation logic
    always @(posedge clk) begin
        if (!rst_n || n_th_song_current != n_th_song_last) begin
                note_and_pitch <= 0;
                index_LS <= 1;
                counter_LS <= 0;
                delay_counter_LS <= 0;
                stop_LS <= 0;
            end else begin
            if (counter_LS < duration_single_note) begin
                counter_LS <= counter_LS + 1; 
            end else begin
                if (delay_counter_LS < pause_duration) begin // space between notes.
                    delay_counter_LS <= delay_counter_LS + 1;
                    stop_LS <= 1;  // BETTER WAY TO INDICATE STOP? - we can compute in the final output.
                end else begin
                    delay_counter_LS <= 0; 
                    stop_LS <= 0;
                    counter_LS <= 0;
                    index_LS <= index_LS + 1; // change the note.
                    if (index_LS > length_LS) begin
                        //index_LS <= 1; // loop play little stars. 
                        stop_LS <= 1; // stop playing.
                    end
                end
            end
        end 
    end

    // Happy birthday index computation logic
    always @(posedge clk) begin
        if (!rst_n || n_th_song_current != n_th_song_last) begin
            note_and_pitch <= 0;
            index_HB <= 1;
            counter_HB <= 0;
            delay_counter_HB <= 0;
            stop_HB <= 0;
        end else begin
            if (counter_HB < duration_single_note) begin // play a note for assigned time
                counter_HB <= counter_HB + 1; 
            end else begin // have played a note for assigned time, pause
                if (delay_counter_HB < pause_duration) begin // space between notes.
                    delay_counter_HB <= delay_counter_HB + 1; // count the pause time.
                    stop_HB <= 1;  // BETTER WAY TO INDICATE STOP? - we can compute in the final output.
                end else begin // have paused for assigned time, play next note.
                    delay_counter_HB <= 0; 
                    stop_HB <= 0;
                    counter_HB <= 0;
                    index_HB <= index_HB + 1; // change the note.
                    if (index_HB > length_HB) begin // have played all notes, stop.
                        //index_HB <= 1; // loop play little stars. 
                        stop_HB <= 1; // stop playing.
                    end
                end
            end
        end
    end

    // Jingle bell index computation logic
    always @(posedge clk) begin
        if (!rst_n || n_th_song_current != n_th_song_last) begin
            note_and_pitch <= 0;
            index_JB <= 1;
            counter_JB <= 0;
            delay_counter_JB <= 0;
            stop_JB <= 0;
        end else begin
            if (counter_JB < duration_single_note) begin // play a note for assigned time
                counter_JB <= counter_JB + 1; 
            end else begin // have played a note for assigned time, pause
                if (delay_counter_JB < pause_duration) begin // space between notes.
                    delay_counter_JB <= delay_counter_JB + 1; // count the pause time.
                    stop_JB <= 1;  // BETTER WAY TO INDICATE STOP? - we can compute in the final output.
                end else begin // have paused for assigned time, play next note.
                    delay_counter_JB <= 0; 
                    stop_JB <= 0;
                    counter_JB <= 0;
                    index_JB <= index_JB + 1; // change the note.
                    if (index_JB > length_JB) begin // have played all notes, stop.
                        //index_JB <= 1; // loop play little stars. 
                        stop_JB <= 1; // stop playing.
                    end
                end
            end
        end
    end

    // state logic, compute the final output note_and_bus according to the state.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            note_and_pitch <= 0;
        end else begin
            case (n_th_song)
                2'b00: begin // don't play
                    note_and_pitch <= 0;
                end
                2'b01: begin // play little star
                    if (stop_LS == 1) begin // stop playing
                        note_and_pitch <= 0;
                    end else begin // play
                        note_and_pitch <= bus_LS;
                    end
                end
                2'b10: begin // play happy birthday
                    if (stop_HB == 1) begin // stop playing
                        note_and_pitch <= 0;
                    end else begin // play
                        note_and_pitch <= bus_HB;
                    end
                end
                2'b11: begin // play jingle bell
                    if (stop_JB == 1) begin // stop playing
                        note_and_pitch <= 0;
                    end else begin // play
                        note_and_pitch <= bus_JB;
                    end
                end
            endcase
        end
    end

    // change song logic: when we change the song, we need to reset the index and counter to its initial value.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            n_th_song_last <= n_th_song;
            n_th_song_current <= n_th_song;
        end else begin
            n_th_song_last <= n_th_song_current;
            n_th_song_current <= n_th_song;
        end
    end
    
endmodule
