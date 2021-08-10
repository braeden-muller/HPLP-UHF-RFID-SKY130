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

	assign LED[0] = KEY[0];
	assign LED[1] = KEY[1];
	assign LED[2] = 1'b0;
	assign LED[3] = 1'b1;
	assign LED[4] = 1'b0;
	assign LED[5] = 1'b1;
	assign LED[6] = 1'b0;
	assign LED[7] = 1'b1;
	

endmodule
