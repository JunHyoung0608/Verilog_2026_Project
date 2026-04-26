`timescale 1ns / 1ps

module ram (
    input               PCLK,
    input               PRESET,
    //APB interface singals
    input        [ 7:0] PADDR,
    input               PWRITE,
    input               PENALBE,
    input        [31:0] PWDATA,
    input               PSEL,
    output logic [31:0] PRDATA,
    output logic        PREADY
);

    logic [31:0] mem[0:2*6-1];
    assign PREADY = 1;

    always_ff @(posedge PCLK) begin : ram_ff
        if (PSEL & PENALBE & PWRITE) begin
            mem[PADDR[7:2]] <= PWDATA;
        end
    end

    assign PRDATA = mem[PADDR[7:2]];

endmodule