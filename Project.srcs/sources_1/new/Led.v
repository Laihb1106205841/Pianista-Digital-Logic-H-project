`timescale 1ns / 1ps

// Led module
//author Haibin Lai
//date 11/19
///////////////////////////////
//input: 
//input [7:0] Busline 总线
//Busline[0] Busline[1] 保留位
//Busline[2] Busline[3] 升降调
//Busline[4] Busline[5] Busline[6] Note音符
//Busline[7] 升降调

//output:
//[6:0]lednote: 对应7个led 灯
//[1:0]HighLow: 对应升8降8
//sharp:对应升降调
////////////////////////////////


module Led(
    input [7:0] Busline,
    output reg [6:0] lednote,
    output [1:0] HighLow,
    output sharp
    );
    
    assign HighLow = {Busline[2],Busline[3]};
    assign sharp = Busline[7];
    
    always @* begin
    case({Busline[4], Busline[5] ,Busline[6]})
     3'b001://do
        lednote = 7'b1000_000;
     3'b010://rei
        lednote = 7'b0100_000;
     3'b011://mi
        lednote = 7'b0010_000;
     3'b100://fa
        lednote = 7'b0001_000;
     3'b101://so
        lednote = 7'b0000_100;           
     3'b110://la
        lednote = 7'b0000_010;           
     3'b111://xi
        lednote = 7'b0000_001;           
           
    default:
        lednote = 7'b0000_000;
    endcase
    end
endmodule
