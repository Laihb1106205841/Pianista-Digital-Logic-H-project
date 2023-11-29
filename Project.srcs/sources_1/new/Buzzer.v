//////////////////////////////////////////////////////////////////////////////////
// Three 7-bit string: low, mid, high.

// Engineer: Taojie
// Create Date: 2023/11/19 22:56:53
// Design Name: MiniPiano
// Module Name: Buzzer
// Project Name: MiniPiano
// Target Devices: xc7a35tcsg324-1
// Description:  This module aims to achieve such functionality: when the input represent "do", then the buzzer will let out "do" sound.
// 
// Dependencies: The CONTROLLER will send clk and 3 notes strings to this module.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Buzzer(
input wire clk, // Clock signal
input wire[6:0] low, // 低音
input wire[6:0] middle, // 中音
input wire[6:0] high, // 高音
output wire speaker, // Buzzer output signal
output wire audio_sd_o 
    );
    wire[31:0] notes[2:0][7:0];
    reg[31:0] counter;
    reg pwm;
    reg[1:0] pitch; // 音高
    reg[2:0] note; // 音符

// Frequencies of do, re, mi, fa, so, la, si
// Obtain the ratio of how long the buzzer should be active in one second
// 低音
assign notes[1][1] = 381680; // 低音1的频率
assign notes[1][2] = 340136;
assign notes[1][3] = 303030;
assign notes[1][4] = 285714;
assign notes[1][5] = 255102;
assign notes[1][6] = 227273;
assign notes[1][7] = 202429; // 低音7的频率

// 中音
assign notes[0][1] = 191112; // 中音1的频率
assign notes[0][2] = 170068;
assign notes[0][3] = 151515;
assign notes[0][4] = 142857;
assign notes[0][5] = 127551;
assign notes[0][6] = 113636;
assign notes[0][7] = 101215; // 中音7的频率

// 高音
assign notes[2][1] = 95556; // 高音1的频率
assign notes[2][2] = 85034;
assign notes[2][3] = 75757;
assign notes[2][4] = 71429;
assign notes[2][5] = 63776;
assign notes[2][6] = 56818;
assign notes[2][7] = 50607; // 高音7的频率

// Set audio sd port
assign audio_sd_o = 1;

initial 
begin 
pwm = 0;
    
    case (low)
            // do.
            7'b0000001: begin
                pitch = 2'b01; // Set pitch for low input
                note = 3'b001; // Set note for low input
            end
            // re.
            7'b0000010: begin
                        pitch = 2'b01; // Set pitch for low input
                        note = 3'b010; // Set note for low input
            end
            // mi.
            7'b0000100: begin
                        pitch = 2'b01; // Set pitch for low input
                        note = 3'b011; // Set note for low input
            end
            // fa
            7'b0001000: begin
                        pitch = 2'b01; // Set pitch for low input
                        note = 3'b100; // Set note for low input
            end
            // so
            7'b0010000: begin
                        pitch = 2'b01; // Set pitch for low input
                        note = 3'b101; // Set note for low input
           end
           // la
           7'b0100000: begin
                        pitch = 2'b01; // Set pitch for low input
                        note = 3'b110; // Set note for low input
            end
            // si
            7'b1000000: begin
                         pitch = 2'b01; // Set pitch for low input
                         note = 3'b111; // Set note for low input
            end
    endcase
    
    case (middle)
                // do.
                7'b0000001: begin
                    pitch = 2'b00; // Set pitch for low input
                    note = 3'b001; // Set note for low input
                end
                // re.
                7'b0000010: begin
                            pitch = 2'b00; // Set pitch for low input
                            note = 3'b010; // Set note for low input
                end
                // mi.
                7'b0000100: begin
                            pitch = 2'b00; // Set pitch for low input
                            note = 3'b011; // Set note for low input
                end
                // fa
                7'b0001000: begin
                            pitch = 2'b00; // Set pitch for low input
                            note = 3'b100; // Set note for low input
                end
                // so
                7'b0010000: begin
                            pitch = 2'b00; // Set pitch for low input
                            note = 3'b101; // Set note for low input
               end
               // la
               7'b0100000: begin
                            pitch = 2'b00; // Set pitch for low input
                            note = 3'b110; // Set note for low input
                end
                // si
                7'b1000000: begin
                             pitch = 2'b00; // Set pitch for low input
                             note = 3'b111; // Set note for low input
                end
        endcase
        
    case (high)
                        // do.
                        7'b0000001: begin
                            pitch = 2'b10; // Set pitch for low input
                            note = 3'b001; // Set note for low input
                        end
                        // re.
                        7'b0000010: begin
                                    pitch = 2'b10; // Set pitch for low input
                                    note = 3'b010; // Set note for low input
                        end
                        // mi.
                        7'b0000100: begin
                                    pitch = 2'b10; // Set pitch for low input
                                    note = 3'b011; // Set note for low input
                        end
                        // fa
                        7'b0001000: begin
                                    pitch = 2'b10; // Set pitch for low input
                                    note = 3'b100; // Set note for low input
                        end
                        // so
                        7'b0010000: begin
                                    pitch = 2'b10; // Set pitch for low input
                                    note = 3'b101; // Set note for low input
                       end
                       // la
                       7'b0100000: begin
                                    pitch = 2'b10; // Set pitch for low input
                                    note = 3'b110; // Set note for low input
                        end
                        // si
                        7'b1000000: begin
                                     pitch = 2'b10; // Set pitch for low input
                                     note = 3'b111; // Set note for low input
                        end
                endcase
end

always @(posedge clk) begin
    if (counter < notes[pitch][note] || note==1'b0) 
    begin
        counter <= counter + 1'b1;
    end 
    
    else 
    begin
        pwm=~pwm;   
        counter <= 0;
    end
end


assign speaker = pwm; // Output a PWM signal to the buzzer
endmodule