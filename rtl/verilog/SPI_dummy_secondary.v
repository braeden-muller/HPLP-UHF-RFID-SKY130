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
    //reg miso;
    reg [2:0] state;
    reg [3:0] bit_count;
    reg [7:0] incoming;
    reg [7:0] outgoing;
    reg [7:0] internal_regs [0:45]; // 0x45 = 2D
    reg [7:0] rw_addr;

    localparam  AWAIT = 4'h0,
                READ_CMD = 4'h1,
                READ_ADDR = 4'h2,
                WRITE_CMD = 4'h3,
                WRITE_ADDR = 4'h4;

    // Very simplified ADXL362 register layout
    // 0x0E, 0x0F - X-Axis registers
    // 0x10, 0x11 - Y-Axis registers
    // 0x12, 0x13 - Z-Axis registers
    // 0x14, 0x15 - Temperature registers
    // 0x2D - Power control register, [1:0] needs to be 10 to measure

    // Not realistic, but assume that the device is in a valid state
    // Only going to specify a state for the "important" registers
    initial begin
        state <= AWAIT;
        rw_addr <= 8'h00;
        bit_count <= 4'h0;
        incoming <= 8'h00;
        outgoing <= 8'h00;
        internal_regs[14] <= 8'hDE; // [0x0E]
        internal_regs[15] <= 8'hAD; // [0x0F]
        internal_regs[16] <= 8'hBE; // [0x10]
        internal_regs[17] <= 8'hEF; // [0x11]
        internal_regs[18] <= 8'hBA; // [0x12]
        internal_regs[19] <= 8'hAD; // [0x13]
        internal_regs[20] <= 8'hC0; // [0x14]
        internal_regs[21] <= 8'hDE; // [0x15]
        internal_regs[45] <= 8'h00; // [0x2D]
    end

    // Very simplified ADXL362 commands
    // 0x0A - Write register
    // 0x0B - Read register
    wire [7:0] next_incoming;
    assign next_incoming = {incoming[6:0], mosi};

    assign miso = (cs == 1'b1) ? 1'bz : outgoing[7];

    // Main clocked operation
    always @ (posedge sclk) begin
        // Not selected
        if (cs == 1'b1) begin
            state <= AWAIT;
            bit_count <= 4'h0;
            incoming <= 8'h00;
            outgoing <= 8'h00;
            rw_addr <= 8'h00;
        end
        // Selected
        else begin
            incoming <= next_incoming;

            if (bit_count == 4'h7) begin
                bit_count <= 4'h0;
                case(state)
                    AWAIT: begin
                        outgoing <= 8'h00;
                        rw_addr <= 8'h00;
                        if (next_incoming == 8'h0A)
                            state <= WRITE_CMD;
                        else if (next_incoming == 8'h0B)
                            state <= READ_CMD;
                        else
                            state <= AWAIT;
                    end
                    READ_CMD: begin
                        outgoing <= internal_regs[next_incoming];
                        rw_addr <= next_incoming + 8'h01;
                        state <= READ_ADDR;
                    end
                    READ_ADDR: begin
                        outgoing <= internal_regs[rw_addr];
                        rw_addr <= rw_addr + 8'h01;
                        state <= READ_ADDR;
                    end
                    WRITE_CMD: begin
                        outgoing <= 8'h00;
                        rw_addr <= next_incoming;
                        state <= WRITE_ADDR;
                    end
                    WRITE_ADDR: begin
                        internal_regs[rw_addr] <= next_incoming;
                        outgoing <= 8'h00;
                        rw_addr <= 8'h00;
                        state <= AWAIT;
                    end
                    default: begin
                        outgoing <= 8'h00;
                        rw_addr <= 8'h00;
                        state <= AWAIT;
                    end
                endcase
            end
            else begin
                bit_count <= bit_count + 4'h1;
                outgoing <= {outgoing[6:0], 1'b0};
            end
        end
    end
endmodule // SPI_dummy_secondary
