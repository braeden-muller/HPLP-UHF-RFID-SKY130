module tb_rfid_top ();
    reg clk, rst;
    wire sck, mosi, miso, scl, sda;
    wire [1:0] cs;

    rfid_top rfid_main(clk, rst, sck, mosi, miso, cs, scl, sda);

endmodule
