`timescale 1ns / 1ps

module Test(
    input clk,
    input rst_n,
    input switch,
    input[6:0] note,
    input[2:0] pitch,
    output speaker,
    output sel,
    output[9:0]led

    // below are testbench ports
    // output reg [1:0] state,
    // output reg [1:0] next_state,
    //output [9:0] note_play,
    //output [31:0] duration_play
    // output reg [9:0] index,
    // output reg [31:0] duration,
    // output reg [31:0] timing
    );

    // Variable declaration
    parameter idle = 2'b11, recording = 2'b10, play = 2'b01;
    parameter max = 100000000;
    reg [9:0] note_memory [255:0];
    reg [31:0] duration_memory [255:0];
    reg [1:0] state; reg [1:0] next_state;
    reg [9:0] index;
    reg [31:0] duration;
    reg init;
    reg [9:0] length;
    reg [31:0] timing; // TESTBENCH TEST: drag it to output
    wire [9:0]note_play;
    wire [31:0] duration_play;
    reg stop; // control the buzzer


    // debounce logic
    wire switch_stable;
    //Debounce debounce(clk, rst_n, switch, switch_stable); TESTBENCH
    assign switch_stable = switch;

    // ff state logic
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state <= idle;
            index <= 1;
            duration <= 1;
            init <= 0;
            stop <= 0;
        end else begin
            state <= next_state;
            // Wish to initialize index the instant state changes to play
            if (state == play) begin
                if (!init) begin
                    index <= 1;
                    init <= 1;
                    length <= note_memory[0];
                    //duration <= duration_memory[index]; 
                    timing <= 1;
                    //duration <= duration_memory[0]; // TESETBENCH TEST: nothing written into
                end
            end
        end
    end

    // Combinational logic: next state
    always @(*) begin
        if (switch_stable) begin
            case (state)
                idle: next_state = recording;
                recording: next_state = recording; 
                play: next_state = play;
                default: next_state = idle;
            endcase
        end else if (!switch_stable) begin
            case (state)
                idle: next_state = idle;
                recording: next_state = play;
                play: next_state = play; 
                default: next_state = idle;
            endcase
        end

    end

    // Write computation logic
    reg [9:0] last_play;
    reg [9:0] now_play;
    always @(posedge clk) begin
        if (state == recording) begin
            duration <= duration + 1;
            last_play <= now_play;
            now_play <= {note,pitch};
            if (last_play != now_play || duration == max) begin
                index <= index + 1;
                // duration <= 0; // TESTBENCH TEST:
                duration <= 1; 
            end
        end
    end

        // Write logic
    always @(posedge clk) begin
        if (state == recording) begin
            note_memory[index] <= {note,pitch};
            duration_memory[index] <= duration - 1;
            note_memory[0] <= index;
        end
    end

    // Read computation logic
    always @(posedge clk) begin
        if (state == play) begin
            if (!init) begin
                index <= 1;
                init <= 1;
                length <= note_memory[0];
                //duration <= duration_memory[index]; 
                timing <= 1;
                //duration <= duration_memory[0]; // TESETBENCH TEST: nothing written into
            end else begin
                timing <= timing + 1;
                if (timing > duration_play) begin
                    index <= index + 1;
                    //duration <= duration_memory[index];
                    timing <= 1;
                end
                if (index > length) begin
                    index <= 1;
                    stop <= 1;
                    //init <= 0;  ??reset init?
                end
            end
        end
    end

    // Buzzer computation logic
    assign note_play = (state != play) ? {note, pitch} : note_memory[index];
    //assign note_play = 0;
    assign duration_play = (state == play) ? duration_memory[index] : 0;

    // Buzzer sound logic
    wire[6:0] useless_led;
    Buzzer buzzer (stop, clk, note_play[9:3], note_play[2:0], speaker, sel, useless_led);

    // LED logic
    assign led = {switch_stable, note_play[9:3], state};

endmodule
