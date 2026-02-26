`timescale 1ns / 1ps `timescale 1ns / 1ps
`define ADDR 16
`define BIT_WIDTH 8

interface fifo_interface (
    input w_clk,
    input r_clk
);
    logic                  rst;
    logic                  we;
    logic [`BIT_WIDTH-1:0] wdata;
    logic                  re;
    logic [`BIT_WIDTH-1:0] rdata;
    logic                  full;
    logic                  empty;
endinterface  //fifo_interface

class transaction;
    rand bit                  we;
    rand bit                  re;
    rand bit [`BIT_WIDTH-1:0] wdata;
    logic    [`BIT_WIDTH-1:0] rdata;
    bit                       full;
    bit                       empty;

    function void display(string name);
        $display(
            "%t: [%s] we = %h, wdata = %h | re = %h, rdata = %2h | full = %h, empty = %h",
            $realtime, name, we, wdata, re, rdata, full, empty);
    endfunction
endclass  //transaction


class generator;
    transaction tr;

    mailbox #(transaction) gen2drv_mbox;
    event gen_next_ev;

    function new(mailbox#(transaction) gen2drv_mbox, event gen_next_ev);
        this.gen2drv_mbox = gen2drv_mbox;
        this.gen_next_ev  = gen_next_ev;
    endfunction  //new()

    task run(int run_cnt);
        repeat (run_cnt) begin
            tr = new();
            tr.randomize();
            gen2drv_mbox.put(tr);
            tr.display("gen");
            @(gen_next_ev);
        end
    endtask  //run
endclass  //generator

class driver;
    transaction tr;

    mailbox #(transaction) gen2drv_mbox;

    virtual fifo_interface fifo_if;

    function new(mailbox#(transaction) gen2drv_mbox,
                 virtual fifo_interface fifo_if);
        this.gen2drv_mbox = gen2drv_mbox;
        this.fifo_if = fifo_if;
    endfunction  //new()

    task preset();
        fifo_if.rst = 1;
        @(posedge fifo_if.w_clk);
        @(posedge fifo_if.w_clk);
        fifo_if.rst = 0;
        @(posedge fifo_if.w_clk);
    endtask

    task run();
        forever begin
            gen2drv_mbox.get(tr);
            @(negedge fifo_if.w_clk);
            fifo_if.we = tr.we;
            fifo_if.wdata = tr.wdata;
            fifo_if.re = tr.re;
            tr.display("drv");
        end
    endtask  //run
endclass  //driver

class monitor;
    transaction tr;

    mailbox #(transaction) mon2scb_mbox;

    virtual fifo_interface fifo_if;
    function new(mailbox#(transaction) mon2scb_mbox,
                 virtual fifo_interface fifo_if);
        this.mon2scb_mbox = mon2scb_mbox;
        this.fifo_if = fifo_if;
    endfunction  //new()

    task run();
        forever begin
            @(posedge fifo_if.w_clk);
            #1;
            tr       = new();
            tr.we    = fifo_if.we;
            tr.re    = fifo_if.re;
            tr.wdata = fifo_if.wdata;
            tr.rdata = fifo_if.rdata;
            tr.full  = fifo_if.full;
            tr.empty = fifo_if.empty;

            mon2scb_mbox.put(tr);
            tr.display("mon");
        end
    endtask  //run
endclass  //monitor

class scoreboard;
    transaction            tr;

    mailbox #(transaction) mon2scb_mbox;
    event                  gen_next_ev;

    int                    pass_cnt      = 0, fail_cnt = 0, try_cnt = 0;


    function new(mailbox#(transaction) mon2scb_mbox, event gen_next_ev);
        this.mon2scb_mbox = mon2scb_mbox;
        this.gen_next_ev  = gen_next_ev;
    endfunction  //new()

    task run();
        logic [`BIT_WIDTH-1:0] scb_mem[0:`ADDR-1];
        forever begin
            mon2scb_mbox.get(tr);
            tr.display("scb");



            ->gen_next_ev;
        end

    endtask  //run
endclass  //scoreboard

class environment;
    transaction            tr;
    generator              gen;
    driver                 drv;
    monitor                mon;
    scoreboard             scb;


    mailbox #(transaction) gen2drv_mbox;
    mailbox #(transaction) mon2scb_mbox;

    event                  gen_next_ev;


    function new(virtual fifo_interface fifo_if);
        gen2drv_mbox = new();
        mon2scb_mbox = new();
        gen = new(gen2drv_mbox, gen_next_ev);
        drv = new(gen2drv_mbox, fifo_if);
        mon = new(mon2scb_mbox, fifo_if);
        scb = new(mon2scb_mbox, gen_next_ev);
    endfunction  //new()

    task run();
        drv.preset();
        fork
            gen.run(100);
            drv.run();
            mon.run();
            scb.run();
        join_any
        #10;

        $display("\n============================================");
        $display("            VERIFICATION REPORT             ");
        $display("============================================");
        $display("  STATUS    |  DESCRIPTION       |  COUNT    ");
        $display("------------+--------------------+----------");
        $display("  TOTAL     |  Total Trials      |   %3d    ", scb.try_cnt);
        $display("  PASS      |  Success Matches   |   %3d    ", scb.pass_cnt);
        $display("  FAIL      |  Mismatch Errors   |   %3d    ", scb.fail_cnt);
        $display("============================================");
        $stop;
    endtask  //run

endclass  //environment


module tb_fifo ();
    logic w_clk, r_clk;
    fifo_interface fifo_if (
        w_clk,
        r_clk
    );

    environment env;

    fiforegister #(
        .ADDR(`ADDR),
        .BIT_WIDTH(`BIT_WIDTH)
    ) DUT (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .rst  (fifo_if.rst),
        .we   (fifo_if.we),
        .wdata(fifo_if.wdata),
        .re   (fifo_if.re),
        .rdata(fifo_if.rdata),
        .full (fifo_if.full),
        .empty(fifo_if.empty)
    );

    always #5 w_clk = ~w_clk;
    always #5 r_clk = ~r_clk;

    initial begin
        $timeformat(-9, 3, "ns");
        w_clk = 0;
        r_clk = 0;
        env   = new(fifo_if);
        env.run();
    end
endmodule
