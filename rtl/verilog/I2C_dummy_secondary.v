/**
 * Sample I2C secondary module meant to stand-in for an actual sensor for
 * simulation purposes.
 * @author Braeden Muller
 * @param sda Serial data line
 * @param scl Serial clock for data transfer synchronization
 */
module I2C_dummy_secondary (sda, scl);
    inout sda;      // Serial Data
    input scl;      // Serial Clock

    assign sda = 1'bZ;

    // TODO

endmodule // I2C_dummy_secondary
