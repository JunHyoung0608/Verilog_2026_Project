`timescale 1ns / 1ps

//0x0000_0000 ~ 0x0000_0FFF ROM
//0x1000_0000 ~ 0x1000_0FFF DATA_RAM
//0x1000_1000 ~ 0x1000_2FFF IMGAGE_FILE
//0x2000_0000 ~ 0x2000_1FFF GPIO
//0x2000_1000 ~ 0x2000_2FFF FND
//0x2000_2000 ~ 0x2000_3FFF UART

module apb_master #(
    parameter NUM_SLAVES = 5
) (
    input                          PCLK,
    input                          PRESET,
    //Soc Internal signal with CPU
    input                   [31:0] addr,
    input                   [31:0] Wdata,
    input                          Wreq,
    input                          Rreq,
    //APB Interface
    // output logic                  slvERR,
    output logic            [31:0] Rdata,
    output logic                   ready,
    //output -> salve
    output logic            [31:0] PADDR,
    output logic            [31:0] PWDATA,
    output logic                   PENABLE,
    output logic                   PWRITE,
           apb_if.master_io        slv_RAM,
           apb_if.master_io        slv_I_FILE,
           apb_if.master_io        slv_GPIO,
           apb_if.master_io        slv_FND,
           apb_if.master_io        slv_UART
);
    logic [31:0] PADDR_next, PWDATA_next;
    logic decode_en, PWRITE_next;

    typedef enum logic [1:0] {
        IDLE,
        SETUP,
        ACCESS
    } state_t;
    state_t c_state, n_state;

    always_ff @(posedge PCLK or posedge PRESET) begin : apb_dec_ff
        if (PRESET) begin
            c_state <= IDLE;
            PADDR   <= 0;
            PWDATA  <= 0;
            PWRITE  <= 0;
        end else begin
            c_state <= n_state;
            PADDR   <= PADDR_next;
            PWDATA  <= PWDATA_next;
            PWRITE  <= PWRITE_next;
        end
    end

    always_comb begin : apb_dec_state_comb
        n_state = c_state;
        case (c_state)
            IDLE: if (Wreq || Rreq) n_state = SETUP;
            SETUP: begin
                n_state = ACCESS;
            end
            ACCESS: begin
                if (ready) begin
                    n_state = IDLE;
                    // if (transfer) n_state = SETUP;
                    // else n_state = IDLE;
                end
            end
        endcase
    end

    always_comb begin : apb_dec_output_comb
        decode_en   = 0;
        PENABLE     = 0;
        PWRITE_next = PWRITE;
        PADDR_next  = PADDR;
        PWDATA_next = PWDATA;
        case (c_state)
            IDLE: begin
                decode_en   = 0;
                PENABLE     = 0;
                PWRITE_next = 0;
                PADDR_next  = 0;
                PWDATA_next = 0;
                if (Wreq || Rreq) begin
                    PADDR_next  = addr;
                    PWDATA_next = Wdata;
                    if (Wreq) begin
                        PWRITE_next = 1'b1;
                    end else begin
                        PWRITE_next = 1'b0;
                    end
                end
            end
            SETUP: begin
                decode_en = 1;
                PENABLE   = 0;
            end
            ACCESS: begin
                decode_en = 1;
                PENABLE   = 1;
                if (ready) begin
                    PWDATA_next = 0;
                end
            end
        endcase
    end


    addr_decoder U_ADDR_DEC (
        .addr     (PADDR),
        .decode_en(decode_en),
        .PSEL0    (slv_RAM.PSEL),
        .PSEL1    (slv_I_FILE.PSEL),
        .PSEL2    (slv_GPIO.PSEL),
        .PSEL3    (slv_FND.PSEL),
        .PSEL4    (slv_UART.PSEL)
    );

    logic [31:0] all_PRDATA[NUM_SLAVES];
    logic all_PREADY[NUM_SLAVES];
    assign all_PRDATA = '{
            slv_RAM.PRDATA,
            slv_I_FILE.PRDATA,
            slv_GPIO.PRDATA,
            slv_FND.PRDATA,
            slv_UART.PRDATA
        };
    assign all_PREADY = '{
            slv_RAM.PREADY,
            slv_I_FILE.PREADY,
            slv_GPIO.PREADY,
            slv_FND.PREADY,
            slv_UART.PREADY
        };


    mux_apb #(
        .NUM_SLAVES(NUM_SLAVES)
    ) U_MUX_APB (
        //input
        .PRDATA(all_PRDATA),
        .PREADY(all_PREADY),
        .sel   (PADDR),
        //output
        .Rdata (Rdata),
        .ready (ready)
    );
endmodule

module addr_decoder (
    input        [31:0] addr,
    input               decode_en,
    output logic        PSEL0,
    output logic        PSEL1,
    output logic        PSEL2,
    output logic        PSEL3,
    output logic        PSEL4
);

    always_comb begin
        PSEL0 = 0;
        PSEL1 = 0;
        PSEL2 = 0;
        PSEL3 = 0;
        PSEL4 = 0;
        if (decode_en) begin
            case ({
                addr[31:28], addr[15:12]
            })
                8'h10:        PSEL0 = 1;
                8'h11, 8'h12: PSEL1 = 1;
                8'h20:        PSEL2 = 1;
                8'h21:        PSEL3 = 1;
                8'h22:        PSEL4 = 1;
            endcase
        end
    end

endmodule


module mux_apb #(
    parameter int NUM_SLAVES = 6
) (
    input logic [31:0] PRDATA[NUM_SLAVES],
    input logic        PREADY[NUM_SLAVES],
    input logic [31:0] sel,

    output logic [31:0] Rdata,
    output logic        ready
);

    // 내부에서 사용할 인덱스
    int sel_idx;

    always_comb begin
        case ({
            sel[31:28], sel[15:12]
        })
            8'h10:        sel_idx = 0;
            8'h11, 8'h12: sel_idx = 1;
            8'h20:        sel_idx = 2;
            8'h21:        sel_idx = 3;
            8'h22:        sel_idx = 4;
            default:      sel_idx = -1;  // 유효하지 않은 선택
        endcase

        // 2. 인덱스에 따른 데이터 할당
        if (sel_idx >= 0 && sel_idx < NUM_SLAVES) begin
            Rdata = PRDATA[sel_idx];
            ready = PREADY[sel_idx];
        end else begin
            Rdata = 32'bx;
            ready = 1'bx;
        end
    end

endmodule
