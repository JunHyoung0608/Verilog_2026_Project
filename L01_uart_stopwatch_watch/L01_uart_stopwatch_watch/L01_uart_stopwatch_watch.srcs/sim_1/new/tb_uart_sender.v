`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/08 16:08:37
// Design Name: 
// Module Name: tb_uart_stopwatch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_uart_sender ();

    parameter BAUD = 9600;
    parameter BAUD_REPIOD = (100_000_000 / BAUD) * 10;  //104_160
    integer i = 0, j = 0;
    reg  [7:0] test_data;

    reg        clk;
    reg        rst;
    reg        btn_r;
    reg        btn_l;
    reg        btn_u;
    reg        btn_d;
    reg  [1:0] sw;
    reg        uart_rx;
    wire [3:0] fnd_digit;
    wire [7:0] fnd_data;
    wire [2:0] led;
    wire       uart_tx;

    task uart_sender();
        begin
            #(BAUD_REPIOD);
            for (i = 0; i < 8; i = i + 1) begin
                uart_rx = test_data[i];
                #(BAUD_REPIOD);
            end
            //stop
            uart_rx = 1'b1;
            #(BAUD_REPIOD);
        end
    endtask

    top_uart_stopwatch_watch U_DUT (
        .clk(clk),
        .rst(rst),
        .btn_r(btn_r),
        .btn_l(btn_l),
        .btn_u(btn_u),
        .btn_d(btn_d),
        .sw(sw),
        .uart_rx(uart_rx),
        .fnd_digit(fnd_digit),
        .fnd_data(fnd_data),
        .led(led),
        .uart_tx(uart_tx)
    );


    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst       = 1;
        uart_rx   = 1;
        btn_r =0;
        btn_l = 0;
        btn_u = 0;
        btn_d = 0;
        sw = 2'b0;          //watch
        test_data = 8'h53;

        #10;
        rst = 0;
        #50;
        sw[0] = 1;          //watch
        #(BAUD_REPIOD);

        #(100_000_000);
        //stopwatch
        #(BAUD_REPIOD);
        uart_rx = 0;
        uart_sender();      //ascii = S
        #(BAUD_REPIOD);
        
        #(100_000_000);



        #(BAUD_REPIOD);
        $stop;
    end
endmodule
