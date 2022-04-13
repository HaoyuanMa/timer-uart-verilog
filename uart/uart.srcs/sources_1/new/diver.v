`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 22:18:14
// Design Name: 
// Module Name: diver
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


module diver(
    input clk100mhz,//100Mhz的式中频率是FPGA的系统时钟
    output clk190hz,//分频得到的90hz
    output clk3hz//分频得到的3hz
    );
    reg[25:0] count=0;//定义一个计数器
    assign clk190hz = count[18];//根据计数器的第19位变化产生新的时钟
    assign clk3hz = count[25];//根据计数器的第26位变化产生新的时钟
    always@(posedge clk100mhz)
        count<=count+1;
endmodule
