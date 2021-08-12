`timescale 1ns/1ns

module tb_rfid_top ();
    reg clk, rst;
    wire sck, mosi, miso, scl, sda;
    wire [1:0] cs;
    wire [7:0] debug_state;

    rfid_top rfid_main(clk, rst, sck, mosi, miso, cs, scl, sda, debug_state);

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        #2 rst <= 1'b1;
    end

    always begin
        #1 clk <= ~clk;
    end

endmodule
