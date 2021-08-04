`timescale 1ns/1ns

module tb_rfid_top ();
    reg clk, rst;
    wire sck, mosi, miso, scl, sda;
    wire [1:0] cs;

    rfid_top rfid_main(clk, rst, sck, mosi, miso, cs, scl, sda);

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        #20 rst <= 1'b1;
    end

    always begin
        #10 clk <= ~clk;
    end

endmodule
