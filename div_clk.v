`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/27 16:37:26
// Design Name: 
// Module Name: div_clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module div_clk(

//    );
//endmodule

module div_clk(
    input    wire    sclk,
    input    wire    rst_n,
    output    wire    po_div_clk
);
 
parameter    DIV_END = 8'd3;
reg        [7:0]    div_cnt;
reg                div_clk_o;
    
//div_cnt
always @ (posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        div_cnt <= 'd0;
    else if(div_cnt == DIV_END)
        div_cnt <= 'd0;
    else 
        div_cnt <= div_cnt + 1'b1;
        
always @ (posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        div_clk_o <= 1'b0;
    else if(div_cnt == 'd1)
        div_clk_o <= 1'b1;
    else if(div_cnt == 'd3)
        div_clk_o <= 1'b0;
 
assign po_div_clk = div_clk_o;
 
endmodule

