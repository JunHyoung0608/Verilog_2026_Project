module user_board (
    input              clk,
    input              rst,
    input              btn_r,
    //SPI
    input              sclk,
    input              mosi,
    output             miso,
    input              cs_n,
    //I2C
    output logic       scl,
    inout  wire        sda,
    //FND
    output logic [7:0] fnd_data,
    output logic [3:0] fnd_digit,
    //LED
    output logic [9:0] led
);

    // command port
    logic       cmd_start;
    logic       cmd_write;
    logic       cmd_read;
    logic       cmd_stop;
    logic [7:0] tx_data;
    logic       ack_in;
    // internal output
    logic [7:0] rx_data;
    logic       done;
    logic       ack_out;
    logic       busy;
    //
    logic [7:0] soc_data;
    logic [7:0] v_batt;
    logic       start, read_done;

    btn_debounce U_BD (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn_r),
        .o_btn(start)
    );


    battery_ctrl U_BATTER_CTRL (
        //uesr
        .start   (start),
        .soc_data(soc_data),
        .read_done(read_done),
        //SPI interface
        .*
    );

    I2C_Master U_I2C_MASTER (.*);

    spi_slave U_SPI_SLAVE (
        .clk    (clk),
        .reset  (rst),
        .tx_data(),
        .rx_data(v_batt),
        .done   (),
        .busy   (),
        .*
    );
    //FND-------------------------------------
    fnd_controller U_FND (
        .clk      (clk),
        .reset    (rst),
        .num      (v_batt),
        .fnd_data (fnd_data),
        .fnd_digit(fnd_digit)
    );
    //LED-------------------------------------
    led_spead U_LED (
        .clk  (clk),
        .rst  (rst),
        .done (read_done),
        .d_in (soc_data),
        .d_out(led)
    );


endmodule


