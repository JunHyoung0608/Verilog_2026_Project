simSetSimulator "-vcssv" -exec "simv" -args \
           "+UVM_TESTNAME=AXI_SPI_write +UVM_VERBOSITY=UVM_DEBUG +ntb_random_seed=random -cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1"
debImport "-dbdir" "simv.daidir"
debLoadSimResult \
           /home/hedu22/PROJECT/Verilog_2026_Project/03_UVM/C11_AXI_SPI/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "845" "163" "1484" "1014"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_AXI_SPI.SPI_MASTER.SIP_master_v1_0_S00_AXI_inst" -win $_nTrace1
srcHBSelect "tb_AXI_SPI.SPI_MASTER" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("SPI_MASTER" 0)}
wvRenameGroup -win $_nWave2 {G1} {SPI_MASTER}
wvAddSignal -win $_nWave2 "/tb_AXI_SPI/SPI_MASTER/sclk" \
           "/tb_AXI_SPI/SPI_MASTER/mosi" "/tb_AXI_SPI/SPI_MASTER/miso" \
           "/tb_AXI_SPI/SPI_MASTER/cs_n" "/tb_AXI_SPI/SPI_MASTER/s00_axi_aclk" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_aresetn" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_awaddr\[3:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_awprot\[2:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_awvalid" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_awready" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_wdata\[31:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_wstrb\[3:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_wvalid" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_wready" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_bresp\[1:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_bvalid" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_bready" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_araddr\[3:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_arprot\[2:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_arvalid" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_arready" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_rdata\[31:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_rresp\[1:0\]" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_rvalid" \
           "/tb_AXI_SPI/SPI_MASTER/s00_axi_rready"
wvSetPosition -win $_nWave2 {("SPI_MASTER" 0)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 25)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 25)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
srcHBSelect "tb_AXI_SPI.SPI_SLV" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("SPI_MASTER" 2)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 1)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 2)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 3)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 25)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 22)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 23)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 24)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("SPI_MASTER" 25)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("SPI_SLV" 0)}
wvRenameGroup -win $_nWave2 {G2} {SPI_SLV}
wvAddSignal -win $_nWave2 "/tb_AXI_SPI/SPI_SLV/clk" "/tb_AXI_SPI/SPI_SLV/rst" \
           "/tb_AXI_SPI/SPI_SLV/sclk" "/tb_AXI_SPI/SPI_SLV/cs_n" \
           "/tb_AXI_SPI/SPI_SLV/mosi" "/tb_AXI_SPI/SPI_SLV/miso" \
           "/tb_AXI_SPI/SPI_SLV/slv_tx_data\[7:0\]" \
           "/tb_AXI_SPI/SPI_SLV/slv_rx_data\[7:0\]" "/tb_AXI_SPI/SPI_SLV/done"
wvSetPosition -win $_nWave2 {("SPI_SLV" 0)}
wvSetPosition -win $_nWave2 {("SPI_SLV" 9)}
wvSetPosition -win $_nWave2 {("SPI_SLV" 9)}
wvScrollDown -win $_nWave2 1
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("SPI_SLV" 0)}
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 25 )} 
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 4
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 3 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 2 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
srcHBSelect "tb_AXI_SPI.SPI_MASTER.U_SPI" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_AXI_SPI.SPI_MASTER.U_SPI" -win $_nTrace1
srcSetScope "tb_AXI_SPI.SPI_MASTER.U_SPI" -delim "." -win $_nTrace1
srcHBSelect "tb_AXI_SPI.SPI_MASTER.U_SPI" -win $_nTrace1
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_AXI_SPI"
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("SPI_SLV" 19)}
wvSetPosition -win $_nWave2 {("SPI_SLV" 19)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"SPI_MASTER" \
{/tb_AXI_SPI/SPI_MASTER/sclk} \
{/tb_AXI_SPI/SPI_MASTER/mosi} \
{/tb_AXI_SPI/SPI_MASTER/miso} \
{/tb_AXI_SPI/SPI_MASTER/cs_n} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_aclk} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_aresetn} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awaddr\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awprot\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wdata\[31:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wstrb\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bresp\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_araddr\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arprot\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rdata\[31:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rresp\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rready} \
}
wvAddSignal -win $_nWave2 -group {"SPI_SLV" \
{/tb_AXI_SPI/SPI_SLV/bit_cnt\[2:0\]} \
{/tb_AXI_SPI/SPI_SLV/clk} \
{/tb_AXI_SPI/SPI_SLV/cs_n} \
{/tb_AXI_SPI/SPI_SLV/cs_n_ff1} \
{/tb_AXI_SPI/SPI_SLV/done} \
{/tb_AXI_SPI/SPI_SLV/miso} \
{/tb_AXI_SPI/SPI_SLV/mode_reg\[1:0\]} \
{/tb_AXI_SPI/SPI_SLV/mosi} \
{/tb_AXI_SPI/SPI_SLV/rst} \
{/tb_AXI_SPI/SPI_SLV/rx_shift_reg\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/sclk} \
{/tb_AXI_SPI/SPI_SLV/sclk_ff1} \
{/tb_AXI_SPI/SPI_SLV/sclk_negedge} \
{/tb_AXI_SPI/SPI_SLV/sclk_posedge} \
{/tb_AXI_SPI/SPI_SLV/slv_rx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/slv_tx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/start} \
{/tb_AXI_SPI/SPI_SLV/state\[1:0\]} \
{/tb_AXI_SPI/SPI_SLV/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSelectSignal -win $_nWave2 {( "SPI_SLV" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 \
           16 17 18 19 )} 
wvSetPosition -win $_nWave2 {("SPI_SLV" 19)}
wvSetCursor -win $_nWave2 540392.335329 -snap {("SPI_SLV" 16)}
wvSetCursor -win $_nWave2 1525813.652695 -snap {("SPI_SLV" 15)}
wvSetCursor -win $_nWave2 890057.964072 -snap {("SPI_SLV" 16)}
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvSetWindowTimeUnit -win $_nWave2 1.000000 ns
wvSetCursor -win $_nWave2 927.143713 -snap {("SPI_SLV" 19)}
wvSetCursor -win $_nWave2 789.396647 -snap {("SPI_SLV" 18)}
wvSetCursor -win $_nWave2 863.568144 -snap {("SPI_SLV" 16)}
wvSetCursor -win $_nWave2 1531.111617 -snap {("SPI_SLV" 15)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 1403.960479 -snap {("SPI_MASTER" 3)}
wvSetCursor -win $_nWave2 1462.238084 -snap {("SPI_MASTER" 3)}
wvSetCursor -win $_nWave2 1573.495329 -snap {("SPI_MASTER" 4)}
wvScrollDown -win $_nWave2 6
wvScrollUp -win $_nWave2 6
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 6 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 4 )} 
wvScrollDown -win $_nWave2 3
wvScrollUp -win $_nWave2 3
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_AXI_SPI/SPI_MASTER"
wvScrollDown -win $_nWave2 8
wvSetPosition -win $_nWave2 {("G3" 22)}
wvSetPosition -win $_nWave2 {("G3" 22)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"SPI_MASTER" \
{/tb_AXI_SPI/SPI_MASTER/sclk} \
{/tb_AXI_SPI/SPI_MASTER/mosi} \
{/tb_AXI_SPI/SPI_MASTER/miso} \
{/tb_AXI_SPI/SPI_MASTER/cs_n} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_aclk} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_aresetn} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awaddr\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awprot\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wdata\[31:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wstrb\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bresp\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_araddr\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arprot\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rdata\[31:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rresp\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rready} \
}
wvAddSignal -win $_nWave2 -group {"SPI_SLV" \
{/tb_AXI_SPI/SPI_SLV/bit_cnt\[2:0\]} \
{/tb_AXI_SPI/SPI_SLV/clk} \
{/tb_AXI_SPI/SPI_SLV/cs_n} \
{/tb_AXI_SPI/SPI_SLV/cs_n_ff1} \
{/tb_AXI_SPI/SPI_SLV/done} \
{/tb_AXI_SPI/SPI_SLV/miso} \
{/tb_AXI_SPI/SPI_SLV/mode_reg\[1:0\]} \
{/tb_AXI_SPI/SPI_SLV/mosi} \
{/tb_AXI_SPI/SPI_SLV/rst} \
{/tb_AXI_SPI/SPI_SLV/rx_shift_reg\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/sclk} \
{/tb_AXI_SPI/SPI_SLV/sclk_ff1} \
{/tb_AXI_SPI/SPI_SLV/sclk_negedge} \
{/tb_AXI_SPI/SPI_SLV/sclk_posedge} \
{/tb_AXI_SPI/SPI_SLV/slv_rx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/slv_tx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/start} \
{/tb_AXI_SPI/SPI_SLV/state\[1:0\]} \
{/tb_AXI_SPI/SPI_SLV/tx_shift_reg\[7:0\]} \
}
wvCollapseGroup -win $_nWave2 "SPI_SLV"
wvAddSignal -win $_nWave2 -group {"G3" \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/bit_cnt\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/busy} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/clk} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/clk_div\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/cpha} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/cpol} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/cs_n} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/div_cnt\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/done} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/half_tick} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/miso} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/mosi} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/reset} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/rx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/rx_shift_reg\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/sclk} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/sclk_r} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/start} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/state\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/step} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/tx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSelectSignal -win $_nWave2 {( "G3" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 )} 
wvSetPosition -win $_nWave2 {("G3" 22)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 900.653892 -snap {("G3" 8)}
wvSelectSignal -win $_nWave2 {( "G3" 6 )} 
wvSelectSignal -win $_nWave2 {( "G3" 4 )} 
wvSetCursor -win $_nWave2 111.257246 -snap {("G3" 4)}
wvSetCursor -win $_nWave2 116.555210 -snap {("G3" 4)}
wvSetCursor -win $_nWave2 148.342994 -snap {("G3" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 2405.937934 -snap {("G3" 4)}
debReload
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 20
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 120.396493 -snap {("G3" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 20
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 20
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
debReload
debReload
wvSetCursor -win $_nWave2 954.129332 -snap {("G3" 7)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 20
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 1794.391378 -snap {("G3" 12)}
wvSetCursor -win $_nWave2 1684.450549 -snap {("G3" 11)}
wvSetCursor -win $_nWave2 1782.612003 -snap {("G3" 11)}
wvSetCursor -win $_nWave2 133.499577 -snap {("G3" 12)}
wvSetCursor -win $_nWave2 1692.303466 -snap {("G3" 11)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 20
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 7 )} 
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 6 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 5 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 4 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 8 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 9 10 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 12 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 14 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 17 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 14 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 16 )} 
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 18 )} 
wvScrollDown -win $_nWave2 4
wvScrollDown -win $_nWave2 5
wvScrollDown -win $_nWave2 17
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 3 )} 
wvSelectSignal -win $_nWave2 {( "G3" 5 )} 
wvSelectSignal -win $_nWave2 {( "G3" 6 )} 
wvSelectSignal -win $_nWave2 {( "G3" 9 )} 
wvSelectSignal -win $_nWave2 {( "G3" 12 )} 
wvSelectSignal -win $_nWave2 {( "G3" 16 )} 
wvScrollDown -win $_nWave2 20
wvSelectSignal -win $_nWave2 {( "G3" 19 )} 
wvSelectSignal -win $_nWave2 {( "G3" 21 )} 
wvSelectSignal -win $_nWave2 {( "G3" 18 )} 
wvSelectSignal -win $_nWave2 {( "G3" 19 )} 
wvSelectSignal -win $_nWave2 {( "G3" 21 )} 
wvSelectSignal -win $_nWave2 {( "G3" 22 )} 
wvSelectSignal -win $_nWave2 {( "G3" 20 )} 
wvSelectSignal -win $_nWave2 {( "G3" 13 )} 
wvSelectSignal -win $_nWave2 {( "G3" 14 )} 
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 1891.377246 -snap {("G3" 14)}
wvScrollUp -win $_nWave2 20
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 1 )} 
wvScrollDown -win $_nWave2 9
wvSelectSignal -win $_nWave2 {( "SPI_MASTER" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 \
           15 16 17 18 19 20 21 22 23 24 25 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 22)}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 22 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSelectGroup -win $_nWave2 {SPI_SLV}
wvSelectGroup -win $_nWave2 {SPI_MASTER} {SPI_SLV}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {G4}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSelectGroup -win $_nWave2 {G3}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvGetSignalOpen -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 19)}
wvSetPosition -win $_nWave2 {("G3" 19)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_AXI_SPI/SPI_MASTER/busy} \
{/tb_AXI_SPI/SPI_MASTER/clk_div\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/cpha} \
{/tb_AXI_SPI/SPI_MASTER/cpol} \
{/tb_AXI_SPI/SPI_MASTER/cs_n} \
{/tb_AXI_SPI/SPI_MASTER/done} \
{/tb_AXI_SPI/SPI_MASTER/miso} \
{/tb_AXI_SPI/SPI_MASTER/mosi} \
{/tb_AXI_SPI/SPI_MASTER/rx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_aclk} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_araddr\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_aresetn} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arprot\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_arvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awaddr\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awprot\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_awvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bresp\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_bvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rdata\[31:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rresp\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_rvalid} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wdata\[31:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wready} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wstrb\[3:0\]} \
{/tb_AXI_SPI/SPI_MASTER/s00_axi_wvalid} \
{/tb_AXI_SPI/SPI_MASTER/sclk} \
{/tb_AXI_SPI/SPI_MASTER/start} \
{/tb_AXI_SPI/SPI_MASTER/tx_data\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/bit_cnt\[2:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/busy} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/clk} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/clk_div\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/cpha} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/cpol} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/cs_n} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/div_cnt\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/done} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/half_tick} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/miso} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/mosi} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/reset} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/rx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/rx_shift_reg\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/sclk} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/sclk_r} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/start} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/state\[1:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/step} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/tx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_MASTER/U_SPI/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/tb_AXI_SPI/SPI_SLV/bit_cnt\[2:0\]} \
{/tb_AXI_SPI/SPI_SLV/clk} \
{/tb_AXI_SPI/SPI_SLV/cs_n} \
{/tb_AXI_SPI/SPI_SLV/cs_n_ff1} \
{/tb_AXI_SPI/SPI_SLV/done} \
{/tb_AXI_SPI/SPI_SLV/miso} \
{/tb_AXI_SPI/SPI_SLV/mode_reg\[1:0\]} \
{/tb_AXI_SPI/SPI_SLV/mosi} \
{/tb_AXI_SPI/SPI_SLV/rst} \
{/tb_AXI_SPI/SPI_SLV/rx_shift_reg\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/sclk} \
{/tb_AXI_SPI/SPI_SLV/sclk_ff1} \
{/tb_AXI_SPI/SPI_SLV/sclk_negedge} \
{/tb_AXI_SPI/SPI_SLV/sclk_posedge} \
{/tb_AXI_SPI/SPI_SLV/slv_rx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/slv_tx_data\[7:0\]} \
{/tb_AXI_SPI/SPI_SLV/start} \
{/tb_AXI_SPI/SPI_SLV/state\[1:0\]} \
{/tb_AXI_SPI/SPI_SLV/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSelectSignal -win $_nWave2 {( "G3" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 )} 
wvSetPosition -win $_nWave2 {("G3" 19)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {G3}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {G3}
wvRenameGroup -win $_nWave2 {G3} {SLV}
wvScrollUp -win $_nWave2 4
wvRenameSignal -win $_nWave2 {/tb_AXI_SPI/SPI_MASTER/U_SPI/state[1:0]} {SLV}
wvSelectGroup -win $_nWave2 {G2}
wvRenameGroup -win $_nWave2 {G2} {MST}
wvSelectSignal -win $_nWave2 {( "MST" 3 )} 
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 3
wvScrollDown -win $_nWave2 5
wvSelectSignal -win $_nWave2 {( "MST" 14 )} 
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 1883.430282 -snap {("MST" 9)}
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G1" 11 )} 
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "MST" 9 )} 
wvSelectSignal -win $_nWave2 {( "MST" 7 )} 
wvSelectSignal -win $_nWave2 {( "MST" 2 )} 
wvSelectSignal -win $_nWave2 {( "MST" 5 )} 
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "MST" 17 )} 
wvSetCursor -win $_nWave2 1048.999145 -snap {("MST" 18)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 1888.397134 -snap {("MST" 7)}
wvSetCursor -win $_nWave2 3024.812874 -snap {("MST" 5)}
debReload
wvSetCursor -win $_nWave2 954.129332 -snap {("MST" 12)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 1683.762831 -snap {("MST" 11)}
wvSetCursor -win $_nWave2 1773.166168 -snap {("MST" 11)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 1754.590141 -snap {("MST" 1)}
wvSetCursor -win $_nWave2 1055.257378 -snap {("MST" 1)}
wvSetCursor -win $_nWave2 1158.567900 -snap {("MST" 1)}
wvSetCursor -win $_nWave2 1116.846343 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1112.872861 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1102.939157 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1160.554641 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1224.130346 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1263.865163 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1116.846343 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1166.514863 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1124.793306 -snap {("MST" 10)}
wvSelectSignal -win $_nWave2 {( "MST" 10 )} 
wvSetCursor -win $_nWave2 1156.581159 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1206.249679 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1257.904940 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1303.599979 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1353.268499 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1402.937019 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1454.592280 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1510.221022 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1563.863024 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1609.558062 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1657.239842 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1706.908362 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1756.576882 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1808.232143 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1104.925898 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1156.581159 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1202.276198 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1255.918199 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1301.613238 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1355.255240 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1398.963537 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1450.618798 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1508.234281 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1559.889542 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1599.624358 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1655.253101 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1712.868584 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1704.921621 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1754.590141 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1796.311698 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1855.913922 -snap {("MST" 10)}
wvSetCursor -win $_nWave2 1802.271920 -snap {("MST" 10)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 1114.859602 -snap {("SLV" 14)}
wvSetCursor -win $_nWave2 1710.881843 -snap {("SLV" 11)}
