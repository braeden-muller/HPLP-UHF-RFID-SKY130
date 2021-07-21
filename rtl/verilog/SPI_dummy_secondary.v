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
    reg [2:0] state;
    reg [3:0] bit_count;
    reg [7:0] shift_reg;
    reg [7:0] internal_regs [0:45]; // 0x45 = 2D
    reg [7:0] rw_addr;

    localparam  AWAIT      = 3'b000,
                WRITE_ADDR = 3'b101,
                READ_ADDR  = 3'b111,
                WRITE_DATA = 3'b100,
                READ_DATA  = 3'b110;

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

    assign miso = shift_reg[7];

    // Main clocked operation
    always @ (posedge sclk) begin
        // Chip-select pulled low means the main wants to communicate
        if (cs == 1'b0) begin
            // Check for state transition every 8 cycles
            if (bit_count == 4'h7) begin
                // Reset bit count so it can count up the next byte
                bit_count <= 4'h0;

                // Manage the state transition
                case (state)
                    // Check for a valid command
                    AWAIT: begin
                        case (shift_reg)
                            8'h0A: state <= WRITE_ADDR;
                            8'h0B: state <= READ_ADDR;
                            default: state <= AWAIT;
                        endcase
                        rw_addr <= rw_addr;
                        shift_reg <= {shift_reg[6:0], mosi};
                        end
                    // Load the specified write address
                    WRITE_ADDR: begin
                        state <= WRITE_DATA;
                        rw_addr <= shift_reg;
                        shift_reg <= {shift_reg[6:0], mosi};
                        end
                    // Load the specified read address
                    READ_ADDR: begin
                        state <= READ_DATA;
                        rw_addr <= shift_reg;
                        shift_reg <= {shift_reg[6:0], mosi};
                        end
                    // Write data to reg at address, and increment
                    WRITE_DATA: begin
                        state <= WRITE_DATA;
                        internal_regs[rw_addr] <= shift_reg; // Yes, I know it's an implied latch. No, I will not fix it.
                        rw_addr <= rw_addr + 8'h1;
                        shift_reg <= {shift_reg[6:0], mosi};
                        end
                    // Read data from reg at address, and increment
                    READ_DATA: begin
                        state <= READ_DATA;
                        rw_addr <= rw_addr + 8'h1;
                        shift_reg <= internal_regs[rw_addr];
                        end
                    default: begin
                        state <= AWAIT;
                        rw_addr <= rw_addr;
                        shift_reg <= {shift_reg[6:0], mosi};
                    end
                endcase
            end
            else begin
                shift_reg <= {shift_reg[6:0], mosi};
                rw_addr <= rw_addr;
                bit_count <= bit_count + 4'h1;
                state <= state;
            end
        end // !cs
        else begin
            state <= AWAIT;
            bit_count <= 4'h0;
            shift_reg <= 8'h0;
            rw_addr <= 8'h0;
        end
    end // always
endmodule // SPI_dummy_secondary
