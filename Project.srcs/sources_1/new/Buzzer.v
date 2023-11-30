`timescale 1ns / 1ps
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
// Revision: 11/30 Buzzer first version functionality complete.
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Buzzer(
input wire clk, // Clock signal
input wire[6:0] low, // Note
input [2:0] pitch, 
output speaker, // Buzzer output signal
output sel,
output mark1,mark2,mark3,mark4,mark5,mark6,mark0
);
assign sel = 1; // Set M6 to 1.
assign mark0 = low[0];
assign mark1 = low[1];
assign mark2 = low[2];
assign mark3 = low[3];
assign mark4 = low[4];
assign mark5 = low[5];
assign mark6 = low[6];


//wire [6:0]note;
wire[31:0] notes[4:0][64:0]; // Frequency of notes.
assign notes[1][1] = 381680; 
assign notes[1][2] = 340136;
assign notes[1][4] = 303030;
assign notes[1][8] = 286368;
assign notes[1][16] = 255102;
assign notes[1][32] = 227273;
assign notes[1][64] = 202429; 
assign notes[2][1] = 191112; 
assign notes[2][2] = 170068;
assign notes[2][4] = 151515;
assign notes[2][8] = 142857;
assign notes[2][16] = 127551;
assign notes[2][32] = 113636;
assign notes[2][64] = 101215; 
assign notes[4][1] = 95556; 
assign notes[4][2] = 85034;
assign notes[4][4] = 75757;
assign notes[4][8] = 71429;
assign notes[4][16] = 63776;
assign notes[4][32] = 56818;
assign notes[4][64] = 50607;

/*initial begin
    case(low)
        7'b0000001,7'b0000010,7'b0000100,7'b0001000,7'b0010000,7'b0100000,7'b1000000 : pitch = 0;
    endcase
end*/


reg [31:0] counter;
reg pwm;
initial pwm = 0;

always @(posedge clk) begin
    if (counter < notes[pitch][low]|| low == 0) begin // Remember to modify here!
        counter <= counter + 1'b1;
    end 
    else begin
        pwm=~pwm;
        counter <= 0;
    end
end

assign speaker = pwm;

endmodule