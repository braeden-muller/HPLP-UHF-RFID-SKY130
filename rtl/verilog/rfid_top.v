module rfid_top (clk, rst, sck, mosi, miso, cs, scl, sda);
    // WISHBONE CONNECTIONS
    input        clk;            // System Clock
    input        rst;            // System Async Active-Low Reset
    wire         cyc;            // Cycle
    wire [1:0]   stb;            // Strobe(s)
    wire [2:0]   adr;            // Address
    wire         we;             // Write enable
    wire [7:0]   dat;            // Data input from rfid_controller

    wire [7:0]   dat_o_spi;      // Data output from spi
    wire         ack_o_spi;      // Normal bus termination from spi
    wire         inta_o_spi;     // Interrupt output from spi

    wire [7:0]   dat_o_i2c;      // Data output from i2c
    wire         ack_o_i2c;      // Normal bus termination from i2c
    wire         inta_o_i2c;     // Interrupt output from i2c

    // SPI CONNECTIONS
    output       sck;
    output       mosi;
    output       miso;
    output [1:0] cs;

    // I2C CONNECTIONS
    output       scl;
    output       sda;
    wire         scl_pad_i;
    wire         scl_pad_o;
    wire         scl_padoen_oe;
    wire         sda_pad_i;
    wire         sda_pad_o;
    wire         sda_padoen_oe;

    // Force compiler to insert tri-state buffers
    assign scl = scl_padoen_oe ? 1'bz : scl_pad_o;
    assign sda = sda_padoen_oe ? 1'bz: sda_pad_o;
    assign scl_pad_i = scl;
    assign sda_pad_i = sda;

    simple_spi_top spi_controller (
        .clk_i          ( clk           ), // clock
        .rst_i          ( rst           ), // reset (asynchronous active low)
        .cyc_i          ( cyc           ), // cycle
        .stb_i          ( stb[0]        ), // strobe
        .adr_i          ( adr[1:0]      ), // address
        .we_i           ( we            ), // write enable
        .dat_i          ( dat           ), // data input
        .dat_o          ( dat_o_spi     ), // data output
        .ack_o          ( ack_o_spi     ), // normal bus termination
        .inta_o         ( inta_o_spi    ), // interrupt output
        .sck_o          ( sck           ), // serial clock output
        .mosi_o         ( mosi          ), // MasterOut SlaveIN
        .miso_i         ( miso          )  // MasterIn SlaveOut
    );

    i2c_master_top i2c_controller (
        .wb_clk_i       ( clk           ), // master clock input
        .wb_rst_i       ( ~rst          ), // synchronous active high reset
        .arst_i         ( rst           ), // asynchronous reset
        .wb_adr_i       ( adr           ), // lower address bits
        .wb_dat_i       ( dat           ), // databus input
        .wb_dat_o       ( dat_o_i2c     ), // databus output
        .wb_we_i        ( we            ), // write enable input
        .wb_stb_i       ( stb[1]        ), // stobe/core select signal
        .wb_cyc_i       ( cyc           ), // valid bus cycle input
        .wb_ack_o       ( ack_o_i2c     ), // bus cycle acknowledge output
        .wb_inta_o      ( ack_o_inta    ), // interrupt request signal output
        .scl_pad_i      ( scl_pad_i     ), // SCL-line input
        .scl_pad_o      ( scl_pad_o     ), // SCL-line output (always 1'b0)
        .scl_padoen_o   ( scl_padoen_oe ), // SCL-line output enable (active low)
        .sda_pad_i      ( sda_pad_i     ), // SDA-line input
        .sda_pad_o      ( sda_pad_o     ), // SDA-line output (always 1'b0)
        .sda_padoen_o   ( sda_padoen_oe )  // SDA-line output enable (active low)
    );
endmodule
