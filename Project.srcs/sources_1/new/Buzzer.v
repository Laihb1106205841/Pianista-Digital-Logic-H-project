//////////////////////////////////////////////////////////////////////////////////
//00_AB_CDE_F 
//AB：音高 - 10 升八度 -01 降八度 -00原
//CDE：note, 001 - 111 依次代表do 到 si，000是空
// F：半音；0原，1加半音

// Engineer: Taojie
// Create Date: 2023/11/19 22:56:53
// Design Name: MiniPiano
// Module Name: Buzzer
// Project Name: MiniPiano
// Target Devices: xc7a35tcsg324-1
// Description:  This module aims to achieve such functionality: when the input represent "do", then the buzzer will let out "do" sound.
// 
// Dependencies: The controller will send notes, 音阶（半音），音高（高八度） to this module.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Buzzer(
input wire clk, // Clock signal
input wire[7:0] bus,
output wire speaker // Buzzer output signal
    );
    wire[31:0] notes[2:0][7:0];
    reg[31:0] counter;
    reg pwm;
    reg[1:0] pitch; // 音高
    reg[2:0] note; // 音符
// Frequencies of do, re, mi, fa, so, la, si
// Obtain the ratio of how long the buzzer should be active in one second
// 低音
assign notes[1][1] = 381680; // 高音1的频率
assign notes[1][2] = 340136;
assign notes[1][3] = 303030;
assign notes[1][4] = 285714;
assign notes[1][5] = 255102;
assign notes[1][6] = 227273;
assign notes[1][7] = 202429; // 高音7的频率

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

//00_AB_CDE_F 
//AB：音高 - 10 升八度 -01 降八度 -00原
//CDE：note, 001 - 111 依次代表do 到 si，000是空
// F：半音；0原，1加半音
initial
begin 
pwm = 0;
// set note
note[2] = bus[3];
note[1] = bus[2];
note[0] = bus[1];

// set pitch
pitch[0] = bus[4];
pitch[1] = bus[5];

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