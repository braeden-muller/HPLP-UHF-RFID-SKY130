`timescale 1ns/1ns

/**
 * Testbench for sample SPI secondary module
 */
module tb_SPI_dummy_secondary ();
    wire miso;
    reg clk, mosi, sclk, cs1, cs2;

    SPI_dummy_secondary sensor1(mosi, miso, sclk, cs1);
    SPI_dummy_secondary sensor2(mosi, miso, sclk, cs2);

    initial begin
        clk <= 1'b0;
        mosi <= 1'b0;
        sclk <= 1'b0;
        cs1 <= 1'b1;
        cs2 <= 1'b1;
    end

    always begin
        #1 clk <= ~clk;
    end
endmodule // tb_SPI_dummy_secondary
