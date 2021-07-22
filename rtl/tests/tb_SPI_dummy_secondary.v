`timescale 1ns/1ns

/**
 * Testbench for sample SPI secondary module
 */
module tb_SPI_dummy_secondary ();
    wire miso;
    reg clk, mosi, cs;
    reg [7:0] to_secondary, from_secondary;
    localparam  WRITE_CMD = 8'h0A,
                READ_CMD = 8'h0B;

    SPI_dummy_secondary sensor(mosi, miso, clk, cs);

    // Clear registers at the start
    initial begin
        clk <= 1'b0;
        mosi <= 1'b0;
        cs <= 1'b1;
        to_secondary <= 8'h00;
        from_secondary <= 8'h00;
        // Transmit a WRITE command, pull cs low so the sensor knows we're addressing it
        #2 to_secondary <= 8'h0A;
        #2 cs <= 1'b0;
        mosi <= to_secondary[7];
        #2 mosi <= to_secondary[6];
        #2 mosi <= to_secondary[5];
        #2 mosi <= to_secondary[4];
        #2 mosi <= to_secondary[3];
        #2 mosi <= to_secondary[2];
        #2 mosi <= to_secondary[1];
        #2 mosi <= to_secondary[0];
        // WRITE to register 0x2D
        to_secondary <= 8'h2D;
        #2 mosi <= to_secondary[7];
        #2 mosi <= to_secondary[6];
        #2 mosi <= to_secondary[5];
        #2 mosi <= to_secondary[4];
        #2 mosi <= to_secondary[3];
        #2 mosi <= to_secondary[2];
        #2 mosi <= to_secondary[1];
        #2 mosi <= to_secondary[0];
        // WRITE 0x02
        to_secondary <= 8'h02;
        #2 mosi <= to_secondary[7];
        #2 mosi <= to_secondary[6];
        #2 mosi <= to_secondary[5];
        #2 mosi <= to_secondary[4];
        #2 mosi <= to_secondary[3];
        #2 mosi <= to_secondary[2];
        #2 mosi <= to_secondary[1];
        #2 mosi <= to_secondary[0];
        // Pull CS high to terminate interaction
        #2 cs <= 1'b1;
        // Pull CS low again to address sensor. Initiate a READ operation.
        to_secondary <= 8'h0B;
        #4 cs <= 1'b0;
        mosi <= to_secondary[7];
        #2 mosi <= to_secondary[6];
        #2 mosi <= to_secondary[5];
        #2 mosi <= to_secondary[4];
        #2 mosi <= to_secondary[3];
        #2 mosi <= to_secondary[2];
        #2 mosi <= to_secondary[1];
        #2 mosi <= to_secondary[0];
        // Start a burst READ at register 0x0E
        to_secondary <= 8'h0E;
        #2 mosi <= to_secondary[7];
        #2 mosi <= to_secondary[6];
        #2 mosi <= to_secondary[5];
        #2 mosi <= to_secondary[4];
        #2 mosi <= to_secondary[3];
        #2 mosi <= to_secondary[2];
        #2 mosi <= to_secondary[1];
        #2 mosi <= to_secondary[0];
        #2 mosi <= 1'b0;
        #1000;
    end

    always @ (posedge clk) begin
        if (cs == 1'b0)
            from_secondary <= {from_secondary[6:0], miso};
    end

    // Mandatory clock ticking
    always begin
        #1 clk <= ~clk;
    end
endmodule // tb_SPI_dummy_secondary
