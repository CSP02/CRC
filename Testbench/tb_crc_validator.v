`timescale 1ns/1ps

module tb_crc_validator;

    reg clk;
    reg rst;
    reg [11:0] data_in;
    wire valid;
    wire done;

    // clock gen
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock
    end

    // UUT
    crc_validator uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .valid(valid),
        .done(done)
    );

    initial begin
        // init
        rst = 1;
        data_in = 12'hCCE;

        // apply reset
        #20;
        rst = 0;
        
        wait(done);
        #10;
        rst = 1;
        data_in = 12'hAA8;
        
        #20;
        rst = 0;
        #50;
        
        wait(done);
        #50;
        $stop;
    end

endmodule
