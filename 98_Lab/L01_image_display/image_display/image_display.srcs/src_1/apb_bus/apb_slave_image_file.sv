`timescale 1ns / 1ps
`include "../cpu/rv32i_opcode.svh"

module apb_slave_image_file (
    //APB_bus
    input                 [31:0] PADDR,
    input                 [31:0] PWDATA,
    input                        PWRITE,
    input                        PENABLE,
          apb_if.slave_io        slv_I_FILE
);
    logic [31:0] rom[0:4799];
    //imagex size = 80x60
    //image0 : 0x0000
    //image1 : 0x04b0
    //image2 : 0x0960
    //image3 : 0x0e10


    initial begin
        $readmemh("image0.mem", rom, 0, 1199);
        $readmemh("image1.mem", rom, 1200, 2399);
        $readmemh("image2.mem", rom, 2400, 3599);
        $readmemh("image3.mem", rom, 3600, 4799);
    end

    //APB_bus
    assign slv_I_FILE.PREADY = (PENABLE && slv_I_FILE.PSEL);

    assign slv_I_FILE.PRDATA = rom[PADDR];



endmodule
