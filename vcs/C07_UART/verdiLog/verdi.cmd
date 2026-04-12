simSetSimulator "-vcssv" -exec "simv" -args "+UVM_TESTNAME=uart_tx_test"
debImport "-dbdir" "simv.daidir"
debLoadSimResult \
           /home/hedu22/PROJECT/Verilog_2026_Project/vcs/C07_UART/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "1330" "373" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
debReload
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_uart.DUT" -win $_nTrace1
srcSetScope "tb_uart.DUT" -delim "." -win $_nTrace1
srcHBSelect "tb_uart.DUT" -win $_nTrace1
srcHBSelect "tb_uart.DUT" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvRenameGroup -win $_nWave2 {G1} {DUT}
wvAddSignal -win $_nWave2 "/tb_uart/DUT/clk" "/tb_uart/DUT/rst" \
           "/tb_uart/DUT/tx_start" "/tb_uart/DUT/tx_data\[7:0\]" \
           "/tb_uart/DUT/uart_tx" "/tb_uart/DUT/tx_done" \
           "/tb_uart/DUT/tx_busy" "/tb_uart/DUT/uart_rx" \
           "/tb_uart/DUT/rx_data\[7:0\]" "/tb_uart/DUT/rx_done"
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvSetPosition -win $_nWave2 {("DUT" 10)}
wvSetPosition -win $_nWave2 {("DUT" 10)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvZoomAll -win $_nWave2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 99648549.643307 -snap {("DUT" 5)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 298945648.929920 -snap {("DUT" 5)}
wvSetCursor -win $_nWave2 387917568.254301 -snap {("DUT" 5)}
wvSetCursor -win $_nWave2 423506335.984054 -snap {("DUT" 4)}
wvSetCursor -win $_nWave2 466212857.259757 -snap {("DUT" 4)}
wvSetCursor -win $_nWave2 484007241.124633 -snap {("DUT" 4)}
wvSetCursor -win $_nWave2 537390392.719261 -snap {("DUT" 4)}
wvSetCursor -win $_nWave2 558743653.357113 -snap {("DUT" 4)}
wvSetCursor -win $_nWave2 640597819.135543 -snap {("DUT" 4)}
wvSetCursor -win $_nWave2 106766303.189257 -snap {("DUT" 5)}
wvSetCursor -win $_nWave2 53383151.594629 -snap {("DUT" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
debExit
