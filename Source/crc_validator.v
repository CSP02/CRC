`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2025 22:06:08
// Design Name: 
// Module Name: crc_validator
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


module crc_validator #(parameter CRC4 = 5'b10011)(
    input clk, rst, 
    input [11:0] data_in,
    output reg done, valid
);
    reg [3:0] shift_count;
    reg [11:0] data_in_temp;
    reg crc_done;
    
    initial begin
        valid <= 1'b0;
        shift_count <= 4'b0000;
        crc_done <= 1'b0;
        done <= 1'b0;
    end
    
    always @(posedge clk) begin
        if(rst | crc_done) begin
            data_in_temp <= data_in;
            shift_count <= 4'b0000;
            done <= 1'b0;
            crc_done <= 1'b0;
            valid <= 1'b0;
        end
        else begin
            if(!data_in_temp[11]) begin
                data_in_temp <= data_in_temp << 1;
                shift_count <= shift_count + 1;
            end
            else begin
                data_in_temp[11:7] <= data_in_temp[11:7] ^ CRC4;
            end
            if(shift_count > 7) begin
                crc_done <= 1'b1;
                done <= 1'b1;
                
                if(data_in_temp == 0) valid <= 1'b1;
            end
        end
    end
endmodule
