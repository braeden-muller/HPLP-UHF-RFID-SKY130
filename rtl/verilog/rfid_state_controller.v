module rfid_state_controller (
    // WISHBONE
    input  wire       clk_i,
    input  wire       rst_i,
    output reg        cyc_o,
    output reg  [1:0] stb_o,
    output wire [2:0] adr_o,
    output wire       we_o,
    output wire [7:0] dat_o,
    input  wire       dat_i,
    input  wire       ack_i,
    input  wire       inta_i,
    output wire       dat_i_sel,
    // SPI
    output wire [1:0] spi_cs,
    // DEBUG
    output reg  [7:0] debug_state
);

    // TODO Don't hardcode this, add ability to talk to other SPI devices
    assign spi_cs = 2'b01;

    reg [7:0] state;
    reg [15:0] command;

    // COMMAND FORMAT
    // [15:14] BLANK | [13] DAT_I_SEL | [12] STRB_TRGT | [11:9] ADDRESS | [8] WRITE_EN | [7:0] DATA
    assign dat_i_sel = command[13];
    assign adr_o = command [11:9];
    assign we_o = command [8];
    assign dat_o = command[7:0];

    always @ (posedge clk_i or negedge rst_i) begin
        debug_state <= command[7:0];

        if (rst_i == 1'b0) begin
            state <= 8'h00;
            command <= 16'h0000;
        end
        else begin
            if (ack_i == 1'b1 || state == 8'h00) begin
                case (state)
                    8'h00: begin
                        command <= 16'h00AA;
                        stb_o <= 2'b01;
                    end
                    default: begin
                        command <= 16'h0000;
                        stb_o <= 2'b00;
                    end
                endcase
                cyc_o <= 1'b1;
            end
            else begin
                stb_o <= 2'b00;
                cyc_o <= 1'b0;
            end
        end
    end


endmodule
