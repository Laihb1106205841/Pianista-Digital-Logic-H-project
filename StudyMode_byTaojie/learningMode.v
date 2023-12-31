///////////////////////////////////////////////////////////////////////
// Wang Taojie
// Goal: light the led when the user is about to play, when the user hit the note, then switch to the next
///////////////////////////////////////////////////////////////////////


module learningMode(
    input [9:0]note_and_pitch_user,
    input clk,
    input rst_n,
    output [9:0]note_and_pitch_out,
    output [9:0]led
    );

    // variable declaration
    reg [6:0]index;
    wire [9:0]note_and_pitch_from_rom;
    wire[9:0] length;
    wire[31:0] duration;
    reg [31:0] timing;
    reg finish;
    reg has_reset;

    // read the note and pitch from rom
    LittleStar_Notes nt_LS(.addra(index), .clka(clk), .douta(note_and_pitch_from_rom)); 
    LittleStar_Notes getLength_LS(.addra(0), .clka(clk), .douta(length)); // rom[0] stores the number of notes.
    LittleStar_Duration getDuration_LS( .addra(index), .clka(clk), .douta(duration)); 

    // state machine
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            index <= 1;
            finish <= 0;
            has_reset <= 1;
            timing <= 0;
        end else begin
            if (note_and_pitch_user[9:3] == 0) begin
                has_reset <= 1;
            end
            if (note_and_pitch_user == note_and_pitch_from_rom && has_reset) begin
                timing <= timing + 1;
                if (timing >= duration) begin
                    index <= index + 1;
                    has_reset <= 0;
                    timing <= 0;
                end
            end
            if (index > length) begin
                finish <= 1;
            end
        end
    end

    // output logic
    //wire [9:0]note_and_pitch_out;
    assign note_and_pitch_out = note_and_pitch_user;
    assign led = finish ? 0 : note_and_pitch_from_rom;

    // Buzzer logic
    /*wire markLED_useless,sel_useless; // LED not needed.
    wire [6:0]note;
    wire [2:0]pitch;
    assign note = note_and_pitch_out[9:3]; // seperate the note and pitch.
    assign pitch = note_and_pitch_out[2:0];
    assign sel = 1;
    Buzzer bz(0 ,clk, note, pitch, speaker, sel_useless, markLED_useless); // play!*/
endmodule
