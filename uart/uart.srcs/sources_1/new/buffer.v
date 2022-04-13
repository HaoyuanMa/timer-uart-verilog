`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 19:55:14
// Design Name: 
// Module Name: buffer
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


module buffer(
    input  clk,
    input  rst,
    input  done,
    input  [7:0] data,
    output reg [7:0] hour/*_out*/,
    output reg [7:0] min/*_out*/,
    output reg [7:0] sec/*_out*/,
    output reg   en
    );
    
    wire delay_over;
    reg [2:0] cnt;
    /*reg [7:0] hour;
    reg [7:0] min;
    reg [7:0] sec;*/
    
    always @(posedge done or negedge rst) begin
        if(!rst) begin
            cnt <= 3'b000;
            hour <= 8'b0;
            min <= 8'b0;
            sec <= 8'b0;
        end
        else begin
            case (cnt)
                3'b000 : begin    
                            //en <= 1'b0;
                            hour <= data;
                            cnt <= cnt + 3'b001;
                         end
                3'b001 : begin
                            min <= data;
                            cnt <= cnt + 3'b001;
                         end
                3'b010 : begin
                            sec <= data;
                            en  <= 1'b1;
                            cnt <= cnt + 3'b001;
                         end
                3'b011 : begin
                            cnt <= cnt + 3'b001;
                            en <= 1'b0;
                         end    
                3'b100 : begin
                            cnt <= 3'b000;  
                         end 
            endcase 
        end
    end
    /*
    delay_10ms _delay(
        .clk (clk),
        .rst (rst),
        .dly_sig (en),
        .dly_over (delay_over)
    );
    
    always @(posedge clk) begin
        if(delay_over)
            en <= 1'b0;
    end

    assign hour_out = hour;
    assign min_out  = min;
    assign sec_out  = sec; */
    
endmodule
