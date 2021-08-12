module fpga_top (
    input wire CLOCK_50,    // Clock
    input wire [1:0] KEY,   // Reset and Control
    output wire [7:0] LED,  // Visual Output
    output wire GPIO_01,    // MOSI
    input wire GPIO_03,     // MISO
    output wire GPIO_05,    // CS0
    output wire GPIO_07,    // SCLK
    inout wire GPIO_09,     // SDA
    output wire GPIO_011,   // SCL
    output wire GPIO_013    // CS1
);
    wire [1:0] CHIPSEL;
    assign GPIO_05 = CHIPSEL[1];
    assign GPIO_013 = CHIPSEL[0];

    rfid_top main_module (
        .clk    ( CLOCK_50  ),
        .rst    ( KEY[0]    ),
        .sck    ( GPIO_07   ),
        .mosi   ( GPIO_01   ),
        .miso   ( GPIO_03   ),
        .cs     ( CHIPSEL   ),
        .scl    ( GPIO_011  ),
        .sda    ( GPIO_09   ),
        .debug_state ( LED  )
    );

endmodule
