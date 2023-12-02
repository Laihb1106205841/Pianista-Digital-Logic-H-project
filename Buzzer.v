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
// Revision:11/30 Simultaneous press functionality realized.
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
reg [31:0] notes[4:0][64:0]; // Frequency of notes.
initial 
begin
notes[1][1] = 381680;
notes[1][2] = 340136;
notes[1][3] = 360908;
notes[1][4] = 303030;
notes[1][5] = 342355;
notes[1][6] = 321583;
notes[1][7] = 341615;
notes[1][8] = 286368;
notes[1][9] = 334024;
notes[1][10] = 313252;
notes[1][11] = 336061;
notes[1][12] = 294699;
notes[1][13] = 323692;
notes[1][14] = 309844;
notes[1][15] = 327803;
notes[1][16] = 255102;
notes[1][17] = 318391;
notes[1][18] = 297619;
notes[1][19] = 325639;
notes[1][20] = 279066;
notes[1][21] = 313270;
notes[1][22] = 299422;
notes[1][23] = 319987;
notes[1][24] = 270735;
notes[1][25] = 307716;
notes[1][26] = 293868;
notes[1][27] = 315821;
notes[1][28] = 281500;
notes[1][29] = 306545;
notes[1][30] = 296159;
notes[1][31] = 313263;
notes[1][32] = 227273;
notes[1][33] = 304476;
notes[1][34] = 283704;
notes[1][35] = 316363;
notes[1][36] = 265151;
notes[1][37] = 303994;
notes[1][38] = 290146;
notes[1][39] = 313029;
notes[1][40] = 256820;
notes[1][41] = 298440;
notes[1][42] = 284592;
notes[1][43] = 308864;
notes[1][44] = 272223;
notes[1][45] = 299587;
notes[1][46] = 289201;
notes[1][47] = 307697;
notes[1][48] = 241187;
notes[1][49] = 288018;
notes[1][50] = 274170;
notes[1][51] = 301047;
notes[1][52] = 261801;
notes[1][53] = 291771;
notes[1][54] = 281385;
notes[1][55] = 301444;
notes[1][56] = 256247;
notes[1][57] = 287605;
notes[1][58] = 277219;
notes[1][59] = 298111;
notes[1][60] = 267943;
notes[1][61] = 290690;
notes[1][62] = 282381;
notes[1][63] = 298931;
notes[1][64] = 202429;
notes[2][1] = 191112;
notes[2][2] = 170068;
notes[2][3] = 180590;
notes[2][4] = 151515;
notes[2][5] = 171313;
notes[2][6] = 160791;
notes[2][7] = 170898;
notes[2][8] = 142857;
notes[2][9] = 166984;
notes[2][10] = 156462;
notes[2][11] = 168012;
notes[2][12] = 147186;
notes[2][13] = 161828;
notes[2][14] = 154813;
notes[2][15] = 163888;
notes[2][16] = 127551;
notes[2][17] = 159331;
notes[2][18] = 148809;
notes[2][19] = 162910;
notes[2][20] = 139533;
notes[2][21] = 156726;
notes[2][22] = 149711;
notes[2][23] = 160061;
notes[2][24] = 135204;
notes[2][25] = 153840;
notes[2][26] = 146825;
notes[2][27] = 157897;
notes[2][28] = 140641;
notes[2][29] = 153258;
notes[2][30] = 147997;
notes[2][31] = 156620;
notes[2][32] = 113636;
notes[2][33] = 152374;
notes[2][34] = 141852;
notes[2][35] = 158272;
notes[2][36] = 132575;
notes[2][37] = 152087;
notes[2][38] = 145073;
notes[2][39] = 156582;
notes[2][40] = 128246;
notes[2][41] = 149201;
notes[2][42] = 142187;
notes[2][43] = 154418;
notes[2][44] = 136002;
notes[2][45] = 149780;
notes[2][46] = 144519;
notes[2][47] = 153837;
notes[2][48] = 120593;
notes[2][49] = 144099;
notes[2][50] = 137085;
notes[2][51] = 150591;
notes[2][52] = 130900;
notes[2][53] = 145953;
notes[2][54] = 140692;
notes[2][55] = 150776;
notes[2][56] = 128014;
notes[2][57] = 143789;
notes[2][58] = 138528;
notes[2][59] = 149044;
notes[2][60] = 133889;
notes[2][61] = 145334;
notes[2][62] = 141125;
notes[2][63] = 149456;
notes[2][64] = 101215;
notes[4][1] = 95556;
notes[4][2] = 85034;
notes[4][3] = 90295;
notes[4][4] = 75757;
notes[4][5] = 85656;
notes[4][6] = 80395;
notes[4][7] = 85449;
notes[4][8] = 71429;
notes[4][9] = 83492;
notes[4][10] = 78231;
notes[4][11] = 84006;
notes[4][12] = 73593;
notes[4][13] = 80914;
notes[4][14] = 77406;
notes[4][15] = 81944;
notes[4][16] = 63776;
notes[4][17] = 79666;
notes[4][18] = 74405;
notes[4][19] = 81455;
notes[4][20] = 69766;
notes[4][21] = 78363;
notes[4][22] = 74855;
notes[4][23] = 80030;
notes[4][24] = 67602;
notes[4][25] = 76920;
notes[4][26] = 73413;
notes[4][27] = 78948;
notes[4][28] = 70320;
notes[4][29] = 76629;
notes[4][30] = 73999;
notes[4][31] = 78310;
notes[4][32] = 56818;
notes[4][33] = 76187;
notes[4][34] = 70926;
notes[4][35] = 79136;
notes[4][36] = 66287;
notes[4][37] = 76043;
notes[4][38] = 72536;
notes[4][39] = 78291;
notes[4][40] = 64123;
notes[4][41] = 74601;
notes[4][42] = 71093;
notes[4][43] = 77209;
notes[4][44] = 68001;
notes[4][45] = 74890;
notes[4][46] = 72259;
notes[4][47] = 76918;
notes[4][48] = 60297;
notes[4][49] = 72050;
notes[4][50] = 68542;
notes[4][51] = 75296;
notes[4][52] = 65450;
notes[4][53] = 72976;
notes[4][54] = 70346;
notes[4][55] = 75388;
notes[4][56] = 64007;
notes[4][57] = 71894;
notes[4][58] = 69264;
notes[4][59] = 74522;
notes[4][60] = 66945;
notes[4][61] = 72667;
notes[4][62] = 70562;
notes[4][63] = 74728;
notes[4][64] = 50607;
end 

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