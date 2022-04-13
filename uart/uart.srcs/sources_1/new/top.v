`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 21:23:56
// Design Name: 
// Module Name: top
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


module top(
    input        clk,
    input        rst,
    input        rxd,
    input        start,
    input        pause,
    output       led,
    output [3:0] pos_h,
	output [7:0] seg_h,
	output [3:0] pos_l,
	output [7:0] seg_l
    );
    
    wire done;
    wire en;
    wire [7:0] rdata;
    wire [7:0] hour;
    wire [7:0] min;
    wire [7:0] sec;

    uart _uart(
        .clk (clk),
        .rst (rst),
        .rxd (rxd),
        .recv_done (done),
        .recv_data (rdata)
    );
    
    buffer _buffer(
        .clk (clk),
        .rst (rst),
        .done (done),
        .data (rdata),
        .hour (hour),
        .min (min),
        .sec (sec),
        .en (en)
    );
    
    timer _timer(
        .clk (clk),
        .rst (rst),
        .en (en),
        .start (start),
        .pause (pause),
        .hour_in (hour),
        .min_in (min),
        .sec_in (sec),
        .led (led),
        .pos_h (pos_h),
	    .seg_h (seg_h),
	    .pos_l (pos_l),
	    .seg_l (seg_l)
    );
    
endmodule
