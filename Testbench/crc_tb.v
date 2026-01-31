`timescale 1ns/1ps

module tb_crc_generator;

    reg clk;
    reg rst;
    reg [7:0] raw_data_in;
    wire [11:0] data_out;
    wire done;

    // clock gen
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock
    end

    // UUT
    crc_generator uut (
        .clk(clk),
        .rst(rst),
        .raw_data_in(raw_data_in),
        .data_out(data_out),
        .done(done)
    );

    initial begin
        // init
        rst = 1;
        raw_data_in = 8'hCC;

        // apply reset
        #20;
        rst = 0;
        
        wait(done);
        raw_data_in = 8'hAA;
        #50;
        
        wait(done);
        #50;
        $stop;
    end

endmodule
