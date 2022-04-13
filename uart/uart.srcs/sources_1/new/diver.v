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
    input clk100mhz,//100Mhz��ʽ��Ƶ����FPGA��ϵͳʱ��
    output clk190hz,//��Ƶ�õ���90hz
    output clk3hz//��Ƶ�õ���3hz
    );
    reg[25:0] count=0;//����һ��������
    assign clk190hz = count[18];//���ݼ������ĵ�19λ�仯�����µ�ʱ��
    assign clk3hz = count[25];//���ݼ������ĵ�26λ�仯�����µ�ʱ��
    always@(posedge clk100mhz)
        count<=count+1;
endmodule
