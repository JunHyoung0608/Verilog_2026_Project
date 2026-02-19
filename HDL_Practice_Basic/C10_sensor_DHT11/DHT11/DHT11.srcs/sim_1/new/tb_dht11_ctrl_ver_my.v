`timescale 1ns / 1ps


module tb_dht11_ctrl ();

    reg clk, rst, start, sw;
    reg dht11_sensor_io, sensor_io_sel;
    wire dhtio;
    // wire dht11_done, dht11_valid;
    // wire [15:0] humidity, temperature;

    // dht11_controller DUT (
    //     .clk        (clk),
    //     .rst        (rst),
    //     .start      (start),
    //     .humidity   (humidity),
    //     .temperature(temperature),
    //     .dht11_done (dht11_done),
    //     .dht11_valid(dht11_valid),
    //     .debug      (),
    //     .dhtio      (dhtio)
    // );

    reg [39:0] dht11_test_data;
    integer i = 0;

    assign dhtio = (sensor_io_sel) ? 1'bz : dht11_sensor_io;

    wire [7:0] fnd_data;
    wire [3:0] fnd_digit;
    top_dht11 DUT (
        .clk(clk),
        .rst(rst),
        .btn(start),
        .sw(sw),
        .dhtio(dhtio),
        .fnd_data(fnd_data),
        .fnd_digit(fnd_digit),
        .led()
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        #0;
        rst = 1;
        start = 0;
        sw = 0;
        dht11_sensor_io = 0;
        sensor_io_sel = 1;
        dht11_test_data = {
            8'd36, 8'd8, 8'd79, 8'd99, 8'd222
        };  //sum:222 hum:79.99 tem:36.8

        //reset
        #20;
        rst   = 0;

        //START + WAIT
        start = 1;
        #10;
        // #((100_000_000/100_000)*10+30000);
        start = 0;
        //19msec + 30usec
        #(1900 * 10 * 1000 + 30_000);
        sensor_io_sel   = 0;
        //SYNC_L
        dht11_sensor_io = 0;
        #(80_000);  //80us
        //SYNC_H
        dht11_sensor_io = 1;
        #(80_000);  //80us
        //DATA_SYNC
        dht11_sensor_io = 0;
        #(50_000);
        //DATA_C
        for (i = 0; i < 40; i = i + 1) begin
            dht11_sensor_io = 0;
            #(1000 * 50);  //50us
            dht11_sensor_io = 1;
            if (dht11_test_data[39-i] == 1) begin
                #(1000 * 70);  //70us
            end else begin
                #(1000 * 30);  //30us
            end
        end
        //STOP
        dht11_sensor_io = 0;
        #(1000 * 60);  //50us + more time(10us)
        sensor_io_sel = 1;
        #5000;
        $stop;
    end

endmodule
