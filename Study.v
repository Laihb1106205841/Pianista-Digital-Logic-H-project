// @para: n_th_song, clk, rst_n
// @return: bus = {note, pitch}

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Wang Taojie
// 
// Create Date: 2023/12/13 23:07:45
// Design Name: 
// Module Name: Multisong_varied_duration
// Using Vivado IP core to implement storage.
// Description: this module is based on Multisong_player.v
// New features: the notes of each song is supplemented, and the duration of each note varies. Achieved by a new memory module.

//////////////////////////////////////////////////////////////////////////////////

module STUDY_M(
    input clk,
    input [1:0]state,
    input rst_n,
    input [1:0]n_th_songs, // 00: don't play, 01: play little star, 10: play happy birthday, 11: play jingle bell

input [9:0] Pin_input,
    
//    input [6:0] inedx, 不要
    
    output [9:0]note_and_pitchs // note + pitch 给led
);

reg [9:0]note_and_pitch;

assign note_and_pitchs = note_and_pitch; // 存给led
wire [1:0] n_th_song;
assign n_th_song = n_th_songs;//存

//reg index_flag;
reg [6:0] index; //need!

    // variable declaration
    parameter duration_single_note = 50000000, pause_duration = 10000000;
    reg [6:0]index_LS; reg [6:0]index_HB; reg [6:0]index_JB;// noteBook[index] sould be the note to play. We need multiple index for multiple songs.
   
    wire [9:0]bus_LS; wire [9:0]bus_HB; wire [9:0]bus_JB;// note + pitch.
    reg [31:0]counter_LS; reg [31:0]counter_HB; reg [31:0]counter_JB;// counter for 1 second, each note play 1 sec.
    reg [31:0] delay_counter_LS; reg [31:0] delay_counter_HB; reg [31:0] delay_counter_JB;
//    reg stop_LS; 暂时
    reg stop_HB; reg stop_JB;// indicating the space between two notes, act as an enable in Buzzer.
    wire[9:0] length_LS; wire[9:0] length_HB; wire[9:0] length_JB;// The number of notes in the song, stored in rom[0].
 
    wire [31:0] dur_LS; wire [31:0] dur_HB; wire [31:0] dur_JB; // duration of note in different songs.
    reg [1:0]n_th_song_last;
    reg [1:0]n_th_song_current; // used to detect the change of song.

    // read from IP core logic
    LittleStar_Notes nt_LS(.addra(index), .clka(clk), .douta(bus_LS)); 
    LittleStar_Notes getLength_LS(.addra(0), .clka(clk), .douta(length_LS)); // rom[0] stores the number of notes.
    LittleStar_Duration getDuration_LS( .addra(index), .clka(clk), .douta(dur_LS)); 
    
    //index 
    always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin      //begin
       index <= 1;
//       index_flag <= 1;
      end
      else if (bus_LS == Pin_input) begin
//           if (index_flag) begin
             index <= index + 1;
//             index_flag <= 0;
           end
           else begin
             index <= index;
           end
       end
//       else begin
//           index_flag <= 1;
//       end

    
    
    
    

//    HappyBirthday_Notes nt_HB(.addra(index_HB), .clka(clk), .douta(bus_HB));
//    HappyBirthday_Notes getLength_HB(.addra(0), .clka(clk), .douta(length_HB));
//    HappyBirthday_Duration getDuration_HB( .addra(index_HB), .clka(clk), .douta(dur_HB));

//    JingleBell_Notes nt_JB(.addra(index_JB), .clka(clk), .douta(bus_JB));
//    JingleBell_Notes getLength_JB(.addra(0), .clka(clk), .douta(length_JB));
//    JingleBell_Duration getDuration_JB( .addra(index_JB), .clka(clk), .douta(dur_JB));



    // state logic, compute the final output note_and_bus according to the state.
    always @(posedge clk or negedge rst_n) begin
   
        if (!rst_n) begin
            note_and_pitch <= 0;
        end else begin
        
             if(
//             state == `PLAY_MODE ||
              state ==`LEARN_MODE) begin
            case (n_th_song)
                2'b00: begin // don't play
                    note_and_pitch <= 0;
                end
                2'b01: begin // play little star
//                    if (stop_LS == 1) begin // stop playing
//                        note_and_pitch <= 0;
//                    end else begin // play
                        note_and_pitch <= bus_LS;
                        
//                    end
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


//         end 
         end
    end

    // change song logic: when we change the song, we need to reset the index and counter to its initial value.
//    always @(posedge clk or negedge rst_n) begin
      always @(posedge clk ) begin
        if (!rst_n) begin
            n_th_song_last <= n_th_song;
            n_th_song_current <= n_th_song;
        end else begin
        
            n_th_song_last <= n_th_song_current;
            n_th_song_current <= n_th_song;
        end
    end
    
    

endmodule
