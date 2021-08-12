module rfid_state_controller (
    // WISHBONE
    input  wire       clk_i,
    input  wire       rst_i,
    output reg        cyc_o,
    output wire [1:0] stb_o,
    output wire [2:0] adr_o,
    output wire       we_o,
    output wire [7:0] dat_o,
    input  wire [7:0] dat_i,
    input  wire       ack_i,
    input  wire       inta_i,
    output wire       dat_i_sel,
    // SPI
    output wire [1:0] spi_cs,
    output reg  [7:0] debug_state // DEBUG
);

    // COMMAND FORMAT
    // [15:14] SPI_CS | [13] DAT_I_SEL | [12] STRB_TRGT | [11:9] ADDRESS | [8] WRITE_EN | [7:0] DATA
    // 2                1                1                3                1              8
    reg [15:0] command; // Encoded current "instruction" being sent to the bus
    reg [3:0] state; // Equivalent to a program counter

    assign spi_cs = command [15:14];
    assign dat_i_sel = command[13];
    assign stb_o = {cyc_o & ~command[12], cyc_o & command[12]};
    assign adr_o = command [11:9];
    assign we_o = command [8];
    assign dat_o = command[7:0];

    always @ (posedge clk_i) begin
        debug_state <= command[7:0];

        if (rst_i == 1'b0) begin
            state <= 4'h0;
            command <= 16'h0000;
            cyc_o <= 1'b0;
        end
        else begin
            if (ack_i == 1'b1 || state == 8'h00) begin
                cyc_o <= 1'b1;
                state <= state + 4'h1;
                case (state)                      // SPI_CS DAT_I_SEL STRB_TRGT ADDRESS WRITE_EN DATA      | NOTES
                    4'h0:    command <= 16'hC150; // 11     0         0         000     1        0101 0000 | Configure SPI master communication
                    4'h1:    command <= 16'h00FF; //
                    default: command <= 16'h0000;
                endcase

            end
            else begin
                cyc_o <= 1'b0;
                state <= state;
                command <= command;
            end
        end
    end


endmodule
