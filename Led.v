`timescale 1ns / 1ps

///////////////////////////////
// Led module
//author Haibin Lai
//date 11/19

//input: 
//input [9:0] Busline 总线

//output:
//[6:0]lednote: 对应7个led 灯
//[2:0]HighLow: 对应升8降8

////////////////////////////////


module Led(
    input [9:0] Busline,
    output [6:0] lednote,
    output [2:0] HighLow
    );

    assign lednote = {Busline[9],Busline[8],Busline[7],Busline[6],Busline[5],Busline[4],Busline[3]};
    assign HighLow = {Busline[2],Busline[1],Busline[0]};

endmodule
