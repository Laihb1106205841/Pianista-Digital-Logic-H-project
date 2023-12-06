    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // input: clk, note, pitch;
    // output: pwm, sel, mrakLED
    
    // module Buzzer(clk, note, pitch) // PARAMETER: clk时钟信号， note为7位的vector，pitch为3位的vector。
    // note说明： 音符的编码为one-hot. 0000001为do，0000010为re，以此类推。如需在同一八度内发多个音，则将对应音符的bit设为1。如1000001为同时发do和si。暂不支持跨多八度发多个音。
    // pitch说明：编码为one-hot(暂定)，001为低八度，010为原八度，100为高八度。
    // constraint文件：Buzzer_constraint.xdc
    // FPGA使用说明：开发板上左下拨码开关SW7-P5向右及其右侧6个分别代表do到si七个音符。U3、U2、V2为调整八度的拨码开关（必须且只能打开其中一个拨码开关，否则不会发声）
    // 备注：FPGA板上拨码开关存在接触不良的情况，故调试时为确认开关是否打开，设置了相应的LED显示，后续开发时可进行相应调整。
    
    // Engineer: Taojie
    // Create Date: 2023/11/19 22:56:53
    // Design Name: MiniPiano
    // Module Name: Buzzer
    // Project Name: MiniPiano
    // Target Devices: xc7a35tcsg324-1
    // Description:  This module aims to achieve such functionality: when the input represent "do", then the buzzer will let out "do" sound.
    // 
    // Dependencies: The CONTROLLER will send clk,notes and pitch to this module.
    // 
    // Revision:11/30 Simultaneous press functionality realized.
    // Revision 0.01 - File Created
    // Additional Comments:
    // 
    //////////////////////////////////////////////////////////////////////////////////
    
    
    module Buzzer(
    input wire clk, // Clock signal
    input wire[6:0] note, // Note
    input [2:0] pitch, 
    output speaker, // Buzzer output signal
    output sel,
    output [6:0] markLED
    );
    assign sel = 1; // Set M6 pin to 1.
    assign markLED[0] = note[0]; // Set the input of LED marks.
    assign markLED[1] = note[1];
    assign markLED[2] = note[2];
    assign markLED[3] = note[3];
    assign markLED[4] = note[4];
    assign markLED[5] = note[5];
    assign markLED[6] = note[6]; // Remember to modify corresponding constraint file for markLED!
    
    
    //wire [6:0]note;
    reg [31:0] notes[4:0][127:0]; // Frequency of notes.
    initial // The calculation of frequency: refer to Frequency.java in directory "ref".
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
    notes[1][65] = 292054;
    notes[1][66] = 271282;
    notes[1][67] = 308081;
    notes[1][68] = 252729;
    notes[1][69] = 295713;
    notes[1][70] = 281865;
    notes[1][71] = 306818;
    notes[1][72] = 244398;
    notes[1][73] = 290159;
    notes[1][74] = 276311;
    notes[1][75] = 302653;
    notes[1][76] = 263942;
    notes[1][77] = 293376;
    notes[1][78] = 282990;
    notes[1][79] = 302728;
    notes[1][80] = 228765;
    notes[1][81] = 279737;
    notes[1][82] = 265889;
    notes[1][83] = 294836;
    notes[1][84] = 253520;
    notes[1][85] = 285560;
    notes[1][86] = 275174;
    notes[1][87] = 296475;
    notes[1][88] = 247966;
    notes[1][89] = 281394;
    notes[1][90] = 271008;
    notes[1][91] = 293143;
    notes[1][92] = 261732;
    notes[1][93] = 285721;
    notes[1][94] = 277413;
    notes[1][95] = 294790;
    notes[1][96] = 214851;
    notes[1][97] = 270460;
    notes[1][98] = 256612;
    notes[1][99] = 287879;
    notes[1][100] = 244244;
    notes[1][101] = 278603;
    notes[1][102] = 268217;
    notes[1][103] = 290909;
    notes[1][104] = 238690;
    notes[1][105] = 274437;
    notes[1][106] = 264051;
    notes[1][107] = 287577;
    notes[1][108] = 254775;
    notes[1][109] = 280156;
    notes[1][110] = 271847;
    notes[1][111] = 290152;
    notes[1][112] = 228268;
    notes[1][113] = 266621;
    notes[1][114] = 256235;
    notes[1][115] = 281324;
    notes[1][116] = 246958;
    notes[1][117] = 273902;
    notes[1][118] = 265594;
    notes[1][119] = 284941;
    notes[1][120] = 242793;
    notes[1][121] = 270570;
    notes[1][122] = 262261;
    notes[1][123] = 282164;
    notes[1][124] = 254840;
    notes[1][125] = 275980;
    notes[1][126] = 269056;
    notes[1][127] = 285145;
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
    notes[2][65] = 146163;
    notes[2][66] = 135641;
    notes[2][67] = 154131;
    notes[2][68] = 126365;
    notes[2][69] = 147947;
    notes[2][70] = 140932;
    notes[2][71] = 153477;
    notes[2][72] = 122036;
    notes[2][73] = 145061;
    notes[2][74] = 138046;
    notes[2][75] = 151313;
    notes[2][76] = 131862;
    notes[2][77] = 146674;
    notes[2][78] = 141413;
    notes[2][79] = 151353;
    notes[2][80] = 114383;
    notes[2][81] = 139959;
    notes[2][82] = 132944;
    notes[2][83] = 147486;
    notes[2][84] = 126760;
    notes[2][85] = 142848;
    notes[2][86] = 137587;
    notes[2][87] = 148292;
    notes[2][88] = 123874;
    notes[2][89] = 140683;
    notes[2][90] = 135422;
    notes[2][91] = 146560;
    notes[2][92] = 130784;
    notes[2][93] = 142850;
    notes[2][94] = 138641;
    notes[2][95] = 147386;
    notes[2][96] = 107425;
    notes[2][97] = 135321;
    notes[2][98] = 128306;
    notes[2][99] = 144007;
    notes[2][100] = 122122;
    notes[2][101] = 139369;
    notes[2][102] = 134108;
    notes[2][103] = 145509;
    notes[2][104] = 119236;
    notes[2][105] = 137205;
    notes[2][106] = 131944;
    notes[2][107] = 143777;
    notes[2][108] = 127305;
    notes[2][109] = 140067;
    notes[2][110] = 135858;
    notes[2][111] = 145067;
    notes[2][112] = 114134;
    notes[2][113] = 133378;
    notes[2][114] = 128117;
    notes[2][115] = 140716;
    notes[2][116] = 123479;
    notes[2][117] = 137005;
    notes[2][118] = 132797;
    notes[2][119] = 142516;
    notes[2][120] = 121314;
    notes[2][121] = 135274;
    notes[2][122] = 131065;
    notes[2][123] = 141073;
    notes[2][124] = 127354;
    notes[2][125] = 137981;
    notes[2][126] = 134473;
    notes[2][127] = 142564;
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
    notes[4][65] = 73081;
    notes[4][66] = 67820;
    notes[4][67] = 77065;
    notes[4][68] = 63182;
    notes[4][69] = 73973;
    notes[4][70] = 70466;
    notes[4][71] = 76738;
    notes[4][72] = 61018;
    notes[4][73] = 72530;
    notes[4][74] = 69023;
    notes[4][75] = 75656;
    notes[4][76] = 65931;
    notes[4][77] = 73337;
    notes[4][78] = 70706;
    notes[4][79] = 75676;
    notes[4][80] = 57191;
    notes[4][81] = 69979;
    notes[4][82] = 66472;
    notes[4][83] = 73743;
    notes[4][84] = 63380;
    notes[4][85] = 71424;
    notes[4][86] = 68793;
    notes[4][87] = 74146;
    notes[4][88] = 61937;
    notes[4][89] = 70342;
    notes[4][90] = 67711;
    notes[4][91] = 73280;
    notes[4][92] = 65392;
    notes[4][93] = 71425;
    notes[4][94] = 69320;
    notes[4][95] = 73693;
    notes[4][96] = 53712;
    notes[4][97] = 67660;
    notes[4][98] = 64153;
    notes[4][99] = 72003;
    notes[4][100] = 61060;
    notes[4][101] = 69684;
    notes[4][102] = 67054;
    notes[4][103] = 72754;
    notes[4][104] = 59618;
    notes[4][105] = 68602;
    notes[4][106] = 65972;
    notes[4][107] = 71888;
    notes[4][108] = 63652;
    notes[4][109] = 70033;
    notes[4][110] = 67929;
    notes[4][111] = 72533;
    notes[4][112] = 57067;
    notes[4][113] = 66689;
    notes[4][114] = 64058;
    notes[4][115] = 70358;
    notes[4][116] = 61739;
    notes[4][117] = 68502;
    notes[4][118] = 66398;
    notes[4][119] = 71258;
    notes[4][120] = 60657;
    notes[4][121] = 67637;
    notes[4][122] = 65532;
    notes[4][123] = 70536;
    notes[4][124] = 63677;
    notes[4][125] = 68990;
    notes[4][126] = 67236;
    notes[4][127] = 71282;
    end 
    
    reg [31:0] counter;
    reg pwm;
    initial pwm = 0;
    
    always @(posedge clk) begin
        if (counter < notes[pitch][note]|| note == 0) begin 
            counter <= counter + 1'b1;
        end 
        else begin
            pwm=~pwm;
            counter <= 0;
        end
    end
    
    assign speaker = pwm;
    
    endmodule