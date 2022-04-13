`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 14:59:41
// Design Name: 
// Module Name: recv
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


module recv(
    input            clk,
    input            rst,
    input            rxd,
    output reg [7:0] data,
    output reg       done
    );

    parameter  CLK_FREQ = 100000000;
    parameter  BPS      = 9600;
    localparam BPS_CNT  = CLK_FREQ / BPS;

    reg        rxd_d0;
    reg        rxd_d1;
    reg        rx_flag;
    reg [15:0] clk_cnt;
    reg [ 3:0] rx_cnt;
    reg [ 7:0] rxdata;

    wire is_start;

    assign is_start = rxd_d1 & (~rxd_d0);

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            rxd_d0 <= 1'b0;
            rxd_d1 <= 1'b0;
        end
        else begin
            rxd_d0 <= rxd;
            rxd_d1 <= rxd_d0;
        end
    end

     always @(posedge clk or negedge rst) begin
        if(!rst) 
            rx_flag <= 1'b0;
        else begin
            if(is_start)
                rx_flag <= 1'b1;
            else if ((rx_cnt == 4'd9) && (clk_cnt == BPS_CNT / 2))
                rx_flag <= 1'b0;
            else
                rx_flag <= rx_flag;
        end
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            clk_cnt <= 16'd0;
            rx_cnt <= 4'd0;
        end
        else if(rx_flag) begin
            if(clk_cnt < BPS_CNT - 1) begin
                clk_cnt <= clk_cnt +1'b1;
                rx_cnt <= rx_cnt;
            end
            else begin
               clk_cnt <= 16'd0; 
               rx_cnt <= rx_cnt +1'b1;
            end
        end
        else begin
            clk_cnt <= 16'd0;
            rx_cnt <= 4'd0;
        end
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) 
            rxdata <= 8'd0;
        else if(rx_flag)
            if(clk_cnt == BPS_CNT/2) begin
                case (rx_cnt)
                  4'd1 : rxdata[0] <= rxd_d1;
                  4'd2 : rxdata[1] <= rxd_d1;
                  4'd3 : rxdata[2] <= rxd_d1;
                  4'd4 : rxdata[3] <= rxd_d1;
                  4'd5 : rxdata[4] <= rxd_d1;
                  4'd6 : rxdata[5] <= rxd_d1;
                  4'd7 : rxdata[6] <= rxd_d1;
                  4'd8 : rxdata[7] <= rxd_d1;
                  default : ;
                endcase
            end
            else
                rxdata <= rxdata;
        else
            rxdata <= 8'd0;
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            data <= 8'd0;
        end
        else if(rx_cnt == 4'd9) begin
            data <= rxdata;
        end
        else begin
            data <= 8'd0;
        end
    end

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            done <= 1'b0;
        end
        else if(rx_cnt == 4'd9) begin
            done <= 1'b1;
        end
        else begin
            done <= 1'b0;
        end
    end
    
endmodule
