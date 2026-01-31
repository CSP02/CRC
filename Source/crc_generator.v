`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NA
// Engineer: PILLA CHANDRA SEKHAR
// 
// Create Date: 10.07.2025 22:06:08
// Design Name: 
// Module Name: crc_generator
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


module crc_generator #(parameter CRC4 = 5'b10011) (
    input clk, rst, 
    input [7:0] raw_data_in,
    output reg done,
    output reg [11:0] data_out
);
    reg [3:0] shift_count;
    reg [11:0] data_in_z;
    reg crc_done;
    
    initial begin
        data_out <= 12'b0;
        shift_count <= 4'b0000;
        crc_done <= 1'b0;
        done <= 1'b0;
    end
    
    always @(posedge clk) begin
        if(rst | crc_done) begin
            //data_out <= 12'b0;
            data_in_z <= {raw_data_in, 4'b0};
            shift_count <= 4'b0000;
            done <= 1'b0;
            crc_done <= 1'b0;
        end
        else begin
            if(!data_in_z[11]) begin
                data_in_z <= data_in_z << 1;
                shift_count <= shift_count + 1;
            end
            else begin
                data_in_z[11:7] <= data_in_z[11:7] ^ CRC4;
            end
            if(shift_count > 7) begin
                crc_done <= 1'b1;
                done <= 1'b1;
                data_out <= {raw_data_in, 4'b0} | {7'b0, data_in_z[11:8]};
            end
        end
    end
endmodule