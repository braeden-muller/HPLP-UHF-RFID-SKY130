module rfid_state_controller (
    // WISHBONE
    input  wire       clk_i,      // Wishbone clock input
    input  wire       rst_i,      // Wishbone active-low synchronous reset input
    output wire       cyc_o,      // Wishbone cycle indicator output
    output wire [1:0] stb_o,      // Wishbone strobe (chip select) output
    output wire [2:0] adr_o,      // Wishbone address (register) output
    output wire       we_o,       // Wishbone write-enable output
    output wire [7:0] dat_o,      // Wishbone data output
    input  wire [7:0] dat_i,      // Wishbone data input
    input  wire       ack_i,      // Wishbone acknowledgement input
    input  wire       inta_i,     // Wishbone interrupt input (ignored)
    output wire       dat_i_sel,  // Select signal for Wishbone data and ack inputs
    // SPI
    output wire [1:0] spi_cs,     // Chip selecty signal for SPI devices
    output reg  [7:0] debug_state // Debugging data to be passed upwards
);

    // COMMAND FORMAT
    // VALID | [15:14] SPI_CS | [13] DAT_I_SEL | [12] STRB_TRGT | [11:9] ADDRESS | [8] WRITE_EN | [7:0] DATA
    // 1       2                1                1                3                1              8
    reg [16:0] command; // Encoded current "instruction" being sent to the bus
    reg [3:0] state; // Equivalent to a program counter
    reg cycle;

    assign cyc_o = command[16] & cycle;
    assign spi_cs = command[15:14];
    assign dat_i_sel = command[13];
    assign stb_o = {cyc_o & command[12], cyc_o & ~command[12]};
    assign adr_o = command [11:9];
    assign we_o = command [8];
    assign dat_o = command[7:0];

    // Clocked area
    always @ (posedge clk_i) begin
        // This is just a way to reflect some sort of debugging-useful data back up the stack
        debug_state <= command[7:0];

        // Synchronous reset
        if (rst_i == 1'b0) begin
            state <= 4'h0;
            command <= 17'h00000;
            cycle <= 1'b0;
        end
        // Normal operation of state machine
        else begin
            // Only change states in response to initial conditions or acknowledge signal
            if (ack_i == 1'b1 || state == 8'h00) begin
                // Indicate that the next cycle has started
                cycle <= 1'b1;

                // Determine the command
                case (state)                       // SPI_CS DAT_I_SEL STRB_TRGT ADDRESS WRITE_EN DATA      | NOTES
                    4'h0:    command <= 17'h1C150; // 11     0         0         000     1        0101 0000 | Configure SPI master communication
                    4'h1:    command <= 17'h000FF; //
                    default: command <= 17'h00000;
                endcase
                // Determine next state
                case (state)
                    4'h0:    state <= 4'h1;
                    default: state <= state;
                endcase
            end
            // Without acknowledgement, end the cycle and hold the current states
            else begin
                cycle <= 1'b0;
                state <= state;
                command <= command;
            end
        end
    end


endmodule
