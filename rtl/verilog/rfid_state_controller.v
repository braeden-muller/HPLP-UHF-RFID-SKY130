module rfid_state_controller (
    // WISHBONE
    input  wire       clk_i,
    input  wire       rst_i,
    output reg        cyc_o,
    output reg  [1:0] stb_o,
    output reg  [2:0] adr_o,
    output reg        we_o,
    output reg        dat_o,
    input  wire       dat_i,
    input  wire       ack_i,
    input  wire       inta_i,
    output reg        dat_i_sel,
    // SPI
    output reg  [1:0] spi_cs
);

    reg [3:0] count;
    reg [3:0] state;

    always @ (posedge clk_i or negedge rst_i) begin
        if (rst_i == 1'b0) begin
            count <= 4'h0;
            state <= 4'h0;
        end
        else begin
            case (state)
                4'h00: begin

                end
            endcase

            // State transitions
            if (count == 4'h8) begin
                state <= state + 4'h1;
                count <= 4'h0;
            end
            else begin
                count <= count + 4'h1;
            end
        end
    end


endmodule
