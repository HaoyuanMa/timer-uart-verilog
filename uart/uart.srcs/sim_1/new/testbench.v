`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 22:37:39
// Design Name: 
// Module Name: testbench
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

module testbench(
    
    );
   
    reg clk;
    reg rst;
    reg done;
    wire en;
    reg [7:0] data;
    wire [7:0] hour;
    wire [7:0] min;
    wire [7:0] sec;
    initial begin
        clk = 0;
        rst = 0;
        
        data = 8'b0;
        #20 
        rst = 1;  
       
        #30
        done = 1;
        data = 8'b00010001;
        #20
        done = 1;
        data = 8'b00100010;
        #20
        done = 1;
        data = 8'b00110011;
    end
    
   always #10  clk=~clk;

    
   
    buffer _buf(
    .clk    (clk),
    .rst    (rst),
    .done   (done),
    .data   (data),
    .hour (hour),
    .min (min),
    .sec (sec),
    .en (en)
    );
        
endmodule
