`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 20:16:44
// Design Name: 
// Module Name: timer
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


module timer(
    input clk,
    input rst,
    input en,
    input start,
    input pause,
    input [7:0] hour_in,
    input [7:0] min_in,
    input [7:0] sec_in,
    output reg led,
    output [3:0] pos_h,
	output [7:0] seg_h,
	output [3:0] pos_l,
	output [7:0] seg_l
    );
    
    parameter bps = 100000000;
    reg [ 7:0] sec;
    reg [ 7:0] min;
    reg [ 7:0] hour;
    reg        timing;
    reg [31:0] beats;
    reg pulse_sec;
   
    wire clk190hz;
    wire [3:0]	hour1;
    wire [3:0]	hour0;
    wire [3:0]	min1;
    wire [3:0]	min0;
    wire [3:0]	sec1;
    wire [3:0]	sec0;
    wire [15:0]	databus_h;
    wire [15:0]	databus_l;
    
    assign hour1 = hour / 4'd10;
    assign hour0 = hour % 4'd10;
    assign min1  = min / 4'd10;
    assign min0  = min % 4'd10;
    assign sec1  = sec / 4'd10;
    assign sec0  = sec % 4'd10;
   
    assign databus_h = {hour1,hour0,4'd10,min1};
    assign databus_l = {min0,4'd10,sec1,sec0};
   
    diver U1(clk,clk190hz,clk3hz);
   
    light_show ls_h(
	      .clk190hz	    (clk190hz),
	      .dataBus		(databus_h),
	      .pos			(pos_h),
	      .seg          (seg_h)
          );

    light_show ls_l(
	      .clk190hz	    (clk190hz),
	      .dataBus		(databus_l),
	      .pos			(pos_l),
	      .seg          (seg_l)
          );

    always@(posedge clk or negedge rst) begin
        if(!rst)
				timing <= 1'b0;
        else if(start /*&& ~(hour == 0 && min == 0 && sec == 0)*/)
                timing <= 1'b1;
        else if(pulse_sec && hour==0 && min==0 && sec==0) 
				timing <= 1'b0;
        else ;
    end
        
    always@(posedge clk or negedge rst) begin
	   if(!rst)
		  beats <= 0;
		else if(beats == bps-1)
				beats <= 0;
			else
				beats <= beats + 1;
		end
    
    always@(posedge clk or negedge rst) begin
		if(!rst)
			pulse_sec <= 0;
		else if(beats == bps - 1)
			pulse_sec <= 1;
		else
			pulse_sec <= 0;
	end
		
	always@(posedge clk or negedge rst) begin
		if(!rst)
			sec <= 0;
		else if(en)
            sec <= sec_in[7:4] * 4'd10 + sec_in[3:0];
		else if(timing && ~pause && pulse_sec && sec==0)
			sec <= 59;
		else if(timing && ~pause && pulse_sec)
			sec <= sec-1;
		else ;
	end
	
	always@(posedge clk or negedge rst) begin
		if(!rst)
			min <= 0;
		else if(en)
            min <= min_in[7:4] * 4'd10 + min_in[3:0];
		else if(timing && pulse_sec && min==0 && sec==0)
			min <= 59;
		else if(timing && ~pause && pulse_sec && sec==0)
			min <= min-1;
		else ;
	end
	
	always@(posedge clk or negedge rst) begin
		if(!rst)
			hour <= 0;
		else if(en)
			hour <= hour_in[7:4] * 4'd10 + hour_in[3:0];
		else if(timing && ~pause && pulse_sec && min==0 && sec==0)
			hour <= hour-1;
		else ;
	end
	
	always@(posedge clk or negedge rst) begin
	   if(!rst)
	       led <= 1'b0;
	   else if(~timing)
	       led <= 1'b1;
	end
	
endmodule
