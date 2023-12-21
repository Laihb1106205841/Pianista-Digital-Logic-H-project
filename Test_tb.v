`timescale 1ns / 1ps

module Test_tb();
    // Declare the signals
    reg clk;
    reg rst_n;
    reg switch;
    reg [6:0] note;
    reg [2:0] pitch;
    wire speaker;
    wire sel;
    wire [9:0] led;
    wire [9:0] note_play;
    wire [31:0] duration_play;

    // Instantiate the Test module
    Test uut (
        .clk(clk),
        .rst_n(rst_n),
        .switch(switch),
        .note(note),
        .pitch(pitch),
        .speaker(speaker),
        .sel(sel),
        .led(led),
        .note_play(note_play),
        .duration_play(duration_play)
    );

    // Initialize the signals
    initial begin
        clk = 0;
        rst_n = 0;
        switch = 0;
        note = 7'b0;
        pitch = 3'b100;
    end

    // Clock generation
    always begin
        #2 clk = ~clk;
    end

    // Test cases
    initial begin
        #10 rst_n = 1;
        #10 switch = 1;
        #283 switch = 0;
        #500 $finish;
    end

    initial begin
        forever begin
            #10 note <= note + 1;
        end
    end
endmodule
