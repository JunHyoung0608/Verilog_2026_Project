`timescale 1ns / 1ps
// 1. Interface: 신호 묶음
//신호 묶음
interface adder_interface;

    logic [31:0] a;
    logic [31:0] b;
    logic        mode;
    logic [31:0] s;
    logic        c;

endinterface  //adder_interface

//stimulus(vector)
//Transaction: 데이터 단위
class transaction;
    //랜덤할 변수 선언
    randc bit [31:0] a;
    randc bit [31:0] b;
    randc bit        mode;
    logic     [31:0] s;
    logic            c;

    task display(string name);
        $display("%t : [%s] a = %h, b =  %h, mode = %h, sum = %h, carry = %h",
                 $time, name, a, b, mode, s, c);
    endtask
    //제약 조건
    // constraint range {
    //     a > 10;
    //     b > 32'hffff_0000;
    // }
    // constraint dist_pattern{
    //     a dist {
    //         0: / 8,
    //         32'hffff_ffff: / 1,
    //         [1:32'hffff_fffe]: / 1
    //         };
    // }
    constraint list_pattern {a inside {[0 : 16]};}
endclass  //transaction

// genderator for randomize stimulus
// 값 생성
class generator;
    //handler
    transaction            tr;
    mailbox #(transaction) gen2drv_mbox;
    event                  gen_next_ev;

    function new(mailbox#(transaction) gen2drv_mbox, event gen_next_ev);
        this.gen2drv_mbox = gen2drv_mbox;
        this.gen_next_ev  = gen_next_ev;
    endfunction  //new()

    task run(int count);
        repeat (count) begin
            tr = new();
            tr.randomize();
            gen2drv_mbox.put(tr);
            tr.display("gen");
            @(gen_next_ev);
        end
    endtask

endclass  //generator

//transction 객체 전달 받음
//추상적인 데이터를 입력받아 interface의 시퀀스에 맞춰 대입
//Driver: 인터페이스에 신호 주입
class driver;
    transaction             tr;
    virtual adder_interface adder_if;
    mailbox #(transaction)  gen2drv_mbox;
    event                   mon_next_ev;

    function new(mailbox#(transaction) gen2drv_mbox, event mon_next_ev,
                 virtual adder_interface adder_if);
        this.gen2drv_mbox = gen2drv_mbox;
        this.mon_next_ev  = mon_next_ev;
        this.adder_if     = adder_if;
    endfunction  //new()

    task run();
        forever begin
            gen2drv_mbox.get(tr);
            adder_if.a    = tr.a;
            adder_if.b    = tr.b;
            adder_if.mode = tr.mode;
            tr.display("drv");
            #10;
            //event generation
            ->mon_next_ev;
        end

    endtask
endclass  //driver

class monitor;
    transaction             tr;
    mailbox #(transaction)  mon2scb_mbox;
    event                   mon_next_ev;
    virtual adder_interface adder_if;

    function new(mailbox#(transaction) mon2scb_mbox, event mon_next_ev,
                 virtual adder_interface adder_if);
        this.mon2scb_mbox = mon2scb_mbox;
        this.mon_next_ev  = mon_next_ev;
        this.adder_if     = adder_if;
    endfunction  //new()

    task run();
        forever begin
            @(mon_next_ev);
            tr      = new();
            tr.a    = adder_if.a;
            tr.b    = adder_if.b;
            tr.mode = adder_if.mode;
            tr.s    = adder_if.s;
            tr.c    = adder_if.c;
            mon2scb_mbox.put(tr);
            tr.display("mon");
        end
    endtask  //
endclass  //monitor

class scoreboard;
    transaction                   tr;
    mailbox #(transaction)        mon2scb_mbox;
    event                         gen_next_ev;
    bit                    [31:0] exected_sum;
    bit                           exected_carry;
    int                           pass_cnt       = 0, fail_cnt = 0;

    function new(mailbox#(transaction) mon2scb_mbox, event gen_next_ev);
        this.mon2scb_mbox = mon2scb_mbox;
        this.gen_next_ev  = gen_next_ev;
    endfunction  //new()

    task run();
        forever begin
            mon2scb_mbox.get(tr);
            tr.display("scb");
            //compare, pass, fail
            if (tr.mode == 0) begin
                {exected_carry, exected_sum} = tr.a + tr.b;
            end else begin
                {exected_carry, exected_sum} = tr.a - tr.b;
            end

            if ((exected_sum == tr.s) && (exected_carry == tr.c)) begin
                $display(
                    "[PASS] a = %h, b =  %h, mode = %h, sum = %h, carry = %h",
                    tr.a, tr.b, tr.mode, tr.s, tr.c);
                pass_cnt++;
            end else begin
                $display(
                    "[FAIL] a = %h, b =  %h, mode = %h, sum = %h, carry = %h",
                    tr.a, tr.b, tr.mode, tr.s, tr.c);
                fail_cnt++;
                $display("exected_sum = %h", exected_sum);
                $display("exected_carry = %h", exected_carry);
            end
            ->gen_next_ev;
        end
    endtask
endclass  //scoreboard

// generator와 driver를 생성 및 실행
// Environment: 컴포넌트 조립
class environment;
    generator               gen;
    driver                  drv;
    virtual adder_interface adder_if;
    monitor                 mon;
    scoreboard              scb;

    mailbox #(transaction)  gen2drv_mbox;  //gen -> drv
    mailbox #(transaction)  mon2scb_mbox;  //mon -> scb
    event                   gen_next_ev;  //scb to gen
    event                   mon_next_ev;  //drv to mon

    int                     i;

    function new(virtual adder_interface adder_if);
        gen2drv_mbox = new();
        mon2scb_mbox = new();
        gen          = new(gen2drv_mbox, gen_next_ev);
        drv          = new(gen2drv_mbox, mon_next_ev, adder_if);
        mon          = new(mon2scb_mbox, mon_next_ev, adder_if);
        scb          = new(mon2scb_mbox, gen_next_ev);
    endfunction  //new()

    task run();
        i = 100;
        fork
            gen.run(i);
            drv.run();
            mon.run();
            scb.run();
        join_any
        #10;
        $display("____________________________");
        $display("**32bit Adder Verification**");
        $display("----------------------------");
        $display("** Total test cnt = %3d   **", i);
        $display("** Total pass cnt = %3d   **", scb.pass_cnt);
        $display("** Total fail cnt = %3d   **", scb.fail_cnt);
        $display("----------------------------");


        $stop;
    endtask
endclass  //environment

module tb_adder_sv_verification ();

    adder_interface adder_if ();
    environment env;

    adder #(
        .BIT_WIDTH(32)
    ) DUT (
        .mode(adder_if.mode),
        .a   (adder_if.a),
        .b   (adder_if.b),
        .s   (adder_if.s),
        .c   (adder_if.c)
    );

    initial begin
        $timeformat(-9, 3, " ns");
        // constructor
        env = new(adder_if);

        // exe
        env.run();
    end
endmodule
