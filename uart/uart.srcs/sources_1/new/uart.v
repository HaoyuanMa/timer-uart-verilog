`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 14:54:32
// Design Name: 
// Module Name: uart
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


module uart(
    input        clk,
    input        rst,
    //input        send_en,
    input        rxd,
    //input  [7:0] send_data,
    //output       txd,
    output       recv_done,
    output [7:0] recv_data
    );

    parameter CLK_FREQ = 100000000;
    parameter BPS      = 9600;

   

 
    recv _recv(
        .clk  (clk),
        .rst  (rst),
        .rxd  (rxd),
        .done (recv_done),
        .data (recv_data)
    );

    /*uart_send _send(
        .sys_clk  (clk),
        .sys_rst_n  (rst),
        .uart_en   (send_en),
        .uart_din (send_data),
        .uart_txd  (txd)
    );*/


endmodule
