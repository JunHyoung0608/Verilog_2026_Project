`include "uvm_macros.svh"
`include "tb_seq.svh"
import uvm_pkg::*;

interface ram_if (
    input logic clk
);
    //write
    logic        write;
    logic [ 7:0] addr;
    logic [15:0] wdata;
    //read
    logic [15:0] rdata;
endinterface  //ram_if



class ram_driver extends uvm_driver #(ram_seq_item);
    `uvm_component_utils(ram_driver);

    virtual ram_if r_if;

    function new(string name = "DRV", uvm_component c);
        super.new(name, c);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ram_if)::get(this, "", "r_if", r_if)) begin
            `uvm_fatal(get_type_name(), "r_if를 찾을 수 없다 찾아라!");
        end
        `uvm_info(get_type_name(), "build_phase 실행 완료", UVM_HIGH);
    endfunction

    virtual task driver_item(ram_seq_item item);
        @(posedge r_if.clk);
        r_if.write <= item.write;
        r_if.addr  <= item.addr;
        r_if.wdata <= item.wdata;
    endtask


    virtual task run_phase(uvm_phase phase);
        ram_seq_item item;
        forever begin
            seq_item_port.get_next_item(item);
            driver_item(item);
            seq_item_port.item_done();
        end
    endtask
endclass  //ram_driver extends uvm_driver

class ram_monitor extends uvm_monitor;
    `uvm_component_utils(ram_monitor)

    virtual ram_if r_if;

    logic [7:0] raddr_past;
    logic read_done;

    logic [15:0] test_mem[0:(2**8)-1];

    function new(string name = "MON", uvm_component c);
        super.new(name, c);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ram_if)::get(this, "", "r_if", r_if)) begin
            `uvm_fatal(get_type_name(), "r_if를 찾을 수 없다 찾아라!");
        end
        //init
        raddr_past = 0;
        read_done  = 0;
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            `uvm_info(get_type_name(), "@(posedge) 대기 실행", UVM_DEBUG);
            @(posedge r_if.clk);
            #1;
            //scoreboard
            if (read_done) begin
                read_done = 0;
                if (test_mem[raddr_past] != r_if.rdata) begin
                    `uvm_error(get_type_name(), $sformatf(
                               "****불일치***** ADDR=%0d, 예상=%0d, 실제=%0d",
                               raddr_past,
                               test_mem[raddr_past],
                               r_if.rdata
                               ));
                end else begin
                    `uvm_info(get_type_name(), $sformatf("일치! rdata=%0d", r_if.rdata), UVM_LOW);
                end
            end
            //save raddr_past & write wdata
            if (r_if.write == 0) begin
                raddr_past = r_if.addr;
                read_done  = 1;
            end else begin
                test_mem[r_if.addr] = r_if.wdata;
            end
        end
    endtask  //run_phase
endclass  //ram_monitor extends uvm_monitor

class ram_agent extends uvm_agent;
    `uvm_component_utils(ram_agent);

    uvm_sequencer #(ram_seq_item) sqr;
    ram_driver drv;
    ram_monitor mon;

    function new(string name = "AGT", uvm_component c);
        super.new(name, c);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sqr = uvm_sequencer#(ram_seq_item)::type_id::create("sqr", this);
        drv = ram_driver::type_id::create("drv", this);
        mon = ram_monitor::type_id::create("mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass  //ram_agent extends uvm_agent

class ram_env extends uvm_env;
    `uvm_component_utils(ram_env);

    ram_agent agt;

    function new(string name = "ENV", uvm_component c);
        super.new(name, c);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = ram_agent::type_id::create("agt", this);
    endfunction

endclass  //ram_env extends uvm_env

class ram_test extends uvm_test;
    `uvm_component_utils(ram_test);

    ram_env env;

    function new(string name, uvm_component c);
        super.new(name, c);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = ram_env::type_id::create("env", this);
        `uvm_info(get_type_name(), "env 생성", UVM_DEBUG);
    endfunction

    virtual task run_phase(uvm_phase phase);
        ram_master_seq seq;

        phase.raise_objection(this);
        seq = ram_master_seq::type_id::create("seq");
        seq.start(env.agt.sqr);
        #100;
        phase.drop_objection(this);
    endtask

    virtual function void report_phase(uvm_phase phase);
        uvm_report_server svr = uvm_report_server::get_server();
        if (svr.get_severity_count(UVM_ERROR) == 0) begin
            `uvm_info(get_type_name(), "===== TEST PASS ! =====", UVM_LOW);
        end else begin
            `uvm_info(get_type_name(), "===== TEST FAIL ! =====", UVM_LOW);
        end
    endfunction
endclass  //ram_test extends uvm_test


module moduleName ();
    logic clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    ram_if r_if (clk);


    ram DUT (
        .clk  (clk),
        //write
        .write(r_if.write),
        .addr (r_if.addr),
        .wdata(r_if.wdata),
        //read
        .rdata(r_if.rdata)
    );


    initial begin
        $timeformat(-9, 3, "ns");
        uvm_config_db#(virtual ram_if)::set(null, "*", "r_if", r_if);
        run_test("ram_test");
    end
endmodule
