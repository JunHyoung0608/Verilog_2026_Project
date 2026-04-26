`timescale 1ns / 1ps


module tb_dht11_ctrl ();

    reg clk, rst, start, sw;
    reg dht11_sensor_io, sensor_io_sel;
    wire dhtio;

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

    task test_dht11();
        begin
            //START + WAIT
            start = 1;
            #((100_000_000 / 100_000) * 100);
            start = 0;
            //19msec + 30usec
            #(1900 * 10 * 1000 + 30_000);

            sensor_io_sel   = 0;
            //SYNC_L
            dht11_sensor_io = 0;
            #(80_000);  //10us
            //SYNC_H
            dht11_sensor_io = 1;
            #(80_000);  //10us

            //DATA_C
            for (i = 39; i >= 0; i = i - 1) begin
                dht11_sensor_io = 0;
                #(50_000);
                if (dht11_test_data[i] == 0) begin
                    dht11_sensor_io = 1'b1;
                    #(28_000);
                end else begin
                    dht11_sensor_io = 1'b1;
                    #(70_000);
                end
            end
            //STOP
            dht11_sensor_io = 0;
            #(50_000);  //50us
            sensor_io_sel = 1;
        end
    endtask

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

        test_dht11();
        dht11_test_data = {
            8'd40, 8'd77, 8'd20, 8'd88, 8'd225
        };  //sum:222 hum:79.99 tem:36.8
        test_dht11();


        #(100_000);
        $stop;
    end

endmodule
