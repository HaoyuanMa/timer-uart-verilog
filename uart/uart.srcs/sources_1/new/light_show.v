`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/23 12:06:12
// Design Name: 
// Module Name: segMsg
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


module light_show(
    input clk190hz,
    input [15:0] dataBus,
    output reg [5:0] pos,
    output reg[7:0]seg
    );

    reg[2:0]posC=0;
    reg[3:0]dataP=0;
    always@(posedge clk190hz)begin
        case(posC)
        0:begin
            pos<=6'b000001;
            dataP<=dataBus[3:0];
          end
        1:begin
            pos<=6'b000010;
            dataP<=dataBus[7:4];
          end
          2:begin
              pos<=6'b000100;
              dataP<=dataBus[11:8];
            end
          3:begin
                pos<=6'b001000;
                dataP<=dataBus[15:12];
             end
        endcase
		begin
			if(posC==5)
				posC<=0;
			else
				posC=posC+1;
		end
    end

    always@(dataP)
    case(dataP)
        0:seg=8'b0011_1111;
        1:seg=8'b0000_0110;
        2:seg=8'b0101_1011;
        3:seg=8'b0100_1111;
        4:seg=8'b0110_0110;
        5:seg=8'b0110_1101;
        6:seg=8'b0111_1101;
        7:seg=8'b0000_0111;
        8:seg=8'b0111_1111;
        9:seg=8'b0110_1111;
        10:seg=8'b0100_0000;
        11:seg=8'b0000_0000;
        default:seg=8'b0000_1000;
    endcase  
endmodule
