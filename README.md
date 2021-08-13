# HPLP-UHF-RFID-SKY130
- XSchem circuit schematics for power-harvesting and demodulation for WISP-like ASIC in Skywater-130nm process
- Verilog for data processing and interacting with sensors

## To-Do
1. Complete command sequence in rfid_state_controller for writing the initial configuration to begin measurement to the ADXL362
    - Currently there is something wrong with how data is being added to the SPI master's write queue. The write-fifo-empty flag stays high even after things are very explicitly added to the write queue. Thus, it does not even attempt to begin SPI communications which stalls future progress. The best place to start on this would be to verify if the command at `4'h0` is actually the correct contents for the `SPCR`. (Check the SPI user guide in the `/docs` directory)
2. Verify the timings for the SPI chip-select bits in the rfid_state_controller. These aren't handled by the SPI master for some reason, so the timings will have to be manually adjusted. Check SPI timing diagrams of the ADXL362 user guide to see what I'm talking about. This particular bit needs to only be low for the length of the communication. The length of this should be able to be easily specified within the existing state machine command structure, but there may be a problem where there is a time offset "lag" between the state machine saying something over wishbone and the SPI master actually getting around to do it. If this is the case, I suggest adding a 2-bit-wide shift register of a specific length between the rfid_state_controller and the output pins to introduce a bit of delay.
3. Create a command sequence right after this for reading the data currently in a register on the ADXL362. I would suggest doing the 8 most significant bits of the x-axis register for simplicity. Loop this to constantly get up-to-date data.
4. Display this retrieved data on the LEDs for instantaneous feedback and verification that the system works.
5. Once this proof-of-concept is done, there should be a good enough base to move on to a system of a more complex operation.

## Device and Pinout
- Tested on DE0-Nano
    - Cyclone IV E - EP4CE22F17C6

![Photo of connected FPGA with wire labels](./doc/fpga_physical_diagram.webp)
![Cyclone IV GPIO Headers Image](./doc/cyclone_iv_io_headers.webp)

#### GPIO Configuration
|Use|Signal Name|Expansion Header|Pin|
--- | --- | --- | ---
|SPI MOSI|GPIO_01|GPIO-0|4|
|SPI MISO|GPIO_03|GPIO-0|4|
|SPI CS0|GPIO_05|GPIO-0|4|
|SPI CS1|GPIO_013|GPIO-0|4|
|SPI SCLK|GPIO_07|GPIO-0|4|
|I2C SDA|GPIO_09|GPIO-0|4|
|I2C SCL|GPIO_011|GPIO-0|4|

#### FPGA Specific Pinout Configuration
|Node Name|Direction|Location|I/O Standard|
--- | --- | --- | ---
|CLOCK_50|Input|PIN_R8|2.5 (Default)
|GPIO_01|Output|PIN_C3|2.5 (Default)
|GPIO_03|Input|PIN_A3|2.5 (Default)
|GPIO_05|Output|PIN_B4|2.5 (Default)
|GPIO_07|Output|PIN_B5|2.5 (Default)
|GPIO_09|Bidir|PIN_D5|2.5 (Default)
|GPIO_011|Output|PIN_A6|2.5 (Default)
|GPIO_013|Output|PIN_D6|2.5 (Default)
|KEY[1]|Input|PIN_E1|2.5 (Default)
|KEY[0]|Input|PIN_F15|2.5 (Default)
|LED[7]|Output|PIN_L3|2.5 (Default)
|LED[6]|Output|PIN_B1|2.5 (Default)
|LED[5]|Output|PIN_F3|2.5 (Default)
|LED[4]|Output|PIN_D1|2.5 (Default)
|LED[3]|Output|PIN_A11|2.5 (Default)
|LED[2]|Output|PIN_B13|2.5 (Default)
|LED[1]|Output|PIN_A13|2.5 (Default)
|LED[0]|Output|PIN_A15|2.5 (Default)
