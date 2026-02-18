`timescale 1ns / 1ps


module top_dht11 (
    input        clk,
    input        rst,
    input        btn,
    input        sw,
    inout        dhtio,
    output [7:0] fnd_data,
    output [3:0] fnd_digit,
    output       led
);
    wire w_db_btn;
    wire [15:0] temperature, humidity;
    wire [27:0] fnd_in_data;

    assign led = dht11_valid;

    btn_debounce bd (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn),
        .o_btn(w_db_btn)
    );


    dht11_controller u_dht11 (
        .clk        (clk),
        .rst        (rst),
        .start      (w_db_btn),
        .humidity   (humidity),
        .temperature(temperature),
        .dht11_done (dht11_done),
        .dht11_valid(dht11_valid),
        .debug      (),
        .dhtio      (dhtio)
    );

    assign fnd_in_data = {
        humidity[14:8], humidity[6:0], temperature[14:8], temperature[6:0]
    };


    fnd_controller U_FND (
        .clk        (clk),
        .reset      (rst),
        .sel_display(sw),
        .fnd_in_data(fnd_in_data),
        .fnd_data   (fnd_data),
        .fnd_digit  (fnd_digit),
        .send_data  ()
    );
endmodule
