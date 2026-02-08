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


module tb_uart_stopwatch ();

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
    reg  [2:0] sw;
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
        sw = 3'b0;
        test_data = 8'h52;

        #10;
        rst = 0;
        #50;
        sw[0] = 1;
        #(BAUD_REPIOD);

        sw[0] = 0;

        #(BAUD_REPIOD);
        uart_rx = 0;
        uart_sender();      //ascii = R
        #(BAUD_REPIOD);
        
        #(100_000_000);
        test_data = 8'h44;  //ascii = D
        uart_rx = 0;
        uart_sender();
        #(BAUD_REPIOD);

        #(100_000_000);
        test_data = 8'h55; //ascii = U
        uart_rx = 0;
        uart_sender();
        #(BAUD_REPIOD);

        #(100_000_000);
        test_data = 8'h4c; //ascii = L
        uart_rx = 0;
        uart_sender();
        #(BAUD_REPIOD);

        #(BAUD_REPIOD);
        $stop;
    end
endmodule


// `timescale 1ns / 1ps

// module tb_uart_loop_back ();

//     parameter BAUD = 9600;
//     parameter BAUD_REPIOD = (100_000_000 / BAUD) * 10;  //104_160
//     integer i = 0, j = 0;


//     reg clk, rst, rx;
//     wire tx;
//     reg [7:0] test_data;


//     uart_top U_DUT (
//         .clk(clk),
//         .rst(rst),
//         .uart_rx(rx),
//         .uart_tx(tx)
//     );


//     initial clk = 1'b0;
//     always #5 clk = ~clk;


//     task uart_sender();
//         begin
//             #(BAUD_REPIOD);
//             for (i = 0; i < 8; i = i + 1) begin
//                 rx = test_data[i];
//                 #(BAUD_REPIOD);
//             end
//             //stop
//             rx = 1'b1;
//             #(BAUD_REPIOD);
//         end
//     endtask

//     initial begin
//         rst       = 1;
//         rx        = 1;
//         test_data = 8'h30;  //ascii = 0
//         repeat (5) @(posedge clk);
//         rst = 0;
//         //uart test pattern
//         //start
//         rx  = 0;
//         //data
//         for (j = 0; j < 10; j = j + 1) begin
//             test_data = 8'h30 + j;
//             uart_sender();
//         end

//         //hold uart tx output
//         for (j = 0; j < 8; j = j + 1) begin
//             rx = test_data[j];
//             #(BAUD_REPIOD);
//         end

//         // stop
//         #(BAUD_REPIOD);
//         $stop;
//     end
// endmodule
