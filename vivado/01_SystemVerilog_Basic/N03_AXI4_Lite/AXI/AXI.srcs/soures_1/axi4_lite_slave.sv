`timescale 1 ns / 1 ps

module axi4_lite_slave (
    // Global Signals
    input  logic        ACLK,
    input  logic        ARESETn,
    // AW channel
    input  logic [31:0] AWADDR,
    input  logic        AWVALID,
    output logic        AWREADY,
    // W channel
    input  logic [31:0] WDATA,
    input  logic        WVALID,
    output logic        WREADY,
    // B channel
    output logic [ 1:0] BRESP,
    output logic        BVALID,
    input  logic        BREADY,
    // AR channel
    input  logic [31:0] ARADDR,
    input  logic        ARVALID,
    output logic        ARREADY,
    // R channel
    output logic [31:0] RDATA,
    output logic        RVALID,
    input  logic        RREADY,
    output logic [ 1:0] RRESP
);

    logic [31:0] slv_reg0, slv_reg1, slv_reg2, slv_reg3;

    /********************** WRITE TRANSACTION **************************/

    // AW Channel transfer
    typedef enum logic {
        AW_IDLE,
        AW_READY
    } aw_state_e;

    aw_state_e aw_state, aw_state_next;

    always_ff @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            aw_state <= AW_IDLE;
        end else begin
            aw_state <= aw_state_next;
        end
    end

    always_comb begin
        aw_state_next = aw_state;
        ;
        case (aw_state)
            AW_IDLE: begin
                AWREADY = 1'b0;
                if (AWVALID) begin
                    aw_state_next = AW_READY;
                end
            end
            AW_READY: begin
                AWREADY = 1'b1;
                aw_state_next = AW_IDLE;
            end
            default: begin
                aw_state_next = AW_IDLE;
            end
        endcase
    end

    // W Channel transfer
    typedef enum logic {
        W_IDLE,
        W_READY
    } w_state_e;

    w_state_e w_state, w_state_next;

    always_ff @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            w_state <= W_IDLE;
        end else begin
            w_state <= w_state_next;
        end
    end

    always_comb begin
        w_state_next = w_state;
        case (w_state)
            W_IDLE: begin
                WREADY = 1'b0;
                if (WVALID) begin
                    w_state_next = W_READY;
                end
            end
            W_READY: begin
                WREADY = 1'b1;
                case (AWADDR[3:2])
                    2'h0: slv_reg0 = WDATA;
                    2'h1: slv_reg1 = WDATA;
                    2'h2: slv_reg2 = WDATA;
                    2'h3: slv_reg3 = WDATA;
                endcase
                w_state_next = W_IDLE;
            end
            default: begin
                w_state_next = W_IDLE;
            end
        endcase
    end

    // B Channel transfer
    typedef enum logic {
        B_IDLE,
        B_VALID
    } b_state_e;

    b_state_e b_state, b_state_next;

    always_ff @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            b_state <= B_IDLE;
        end else begin
            b_state <= b_state_next;
        end
    end

    always_comb begin
        b_state_next = b_state;
        case (b_state)
            B_IDLE: begin
                BVALID = 1'b0;
                if (BREADY) begin
                    b_state_next = B_VALID;
                end
            end
            B_VALID: begin
                BVALID = 1'b1;
                b_state_next = B_IDLE;
            end
            default: begin
                b_state_next = B_IDLE;
            end
        endcase
    end

    // AR Channel transfer
    typedef enum logic {
        AR_IDLE,
        AR_READY
    } ar_state_e;

    ar_state_e ar_state, ar_state_next;

    always_ff @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            ar_state <= AR_IDLE;
        end else begin
            ar_state <= ar_state_next;
        end
    end

    always_comb begin
        ar_state_next = ar_state;
        case (ar_state)
            AR_IDLE: begin
                ARREADY = 1'b0;
                if (ARVALID) begin
                    ar_state_next = AR_READY;
                end
            end
            AR_READY: begin
                ARREADY = 1'b1;
                ar_state_next = AR_IDLE;
            end
            default: begin
                ar_state_next = AR_IDLE;
            end
        endcase
    end

    // R Channel transfer
    typedef enum logic {
        R_IDLE,
        R_READY
    } r_state_e;

    r_state_e r_state, r_state_next;

    always_ff @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            r_state <= R_IDLE;
        end else begin
            r_state <= r_state_next;
        end
    end

    always_comb begin
        r_state_next = r_state;
        case (r_state)
            R_IDLE: begin
                RDATA = 0;
                RVALID = 1'b0;
                if (RREADY) begin
                    r_state_next = R_READY;
                end
            end
            R_READY: begin
                RVALID = 1'b1;
                case (AWADDR[3:2])
                    2'h0: RDATA = slv_reg0;
                    2'h1: RDATA = slv_reg1;
                    2'h2: RDATA = slv_reg2;
                    2'h3: RDATA = slv_reg3;
                endcase
                r_state_next = R_IDLE;
            end
            default: begin
                r_state_next = R_IDLE;
            end
        endcase
    end

endmodule

