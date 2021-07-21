/**
 * Sample SPI secondary module meant to stand-in for an actual sensor for
 * simulation purposes. This will operate in SPI Mode 0 (CPOL = CPHA = 0).
 * @author Braeden Muller
 * @param mosi Main-Out Secondary-In serial data line
 * @param miso Main-In Secondary-Out serial data line
 * @param sclk Serial clock for data transfer synchronization
 * @param cs Active-low chip select line
 */
module SPI_dummy_secondary (mosi, miso, sclk, cs);
    input  mosi;    // Main-Out Secondary-In
    output miso;    // Main-In Secondary-Out
    input  sclk;    // Serial Clock
    input  cs;      // Chip Select (Active low)

    assign miso = 1'bZ;

    // TODO

endmodule // SPI_dummy_secondary
