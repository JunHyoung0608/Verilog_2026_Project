verdiSetActWin -dock widgetDock_<Watch>
simSetSimulator "-vcssv" -exec "simv" -args \
           "+UVM_TESTNAME=SPI_write_read_test +UVM_VERBOSITY=UVM_DEBUG +ntb_random_seed=random -cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1"
debImport "-dbdir" "simv.daidir"
debLoadSimResult /home/hedu22/PROJECT/Verilog_2026_Project/vcs/C09_SPI/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_SPI"
verdiSetActWin -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_SPI/U_SPI_MM"
wvGetSignalSetScope -win $_nWave2 "/tb_SPI"
wvGetSignalSetScope -win $_nWave2 "/tb_SPI/U_SPI_MM"
srcHBSelect "tb_SPI.U_SPI_MM" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvGetSignalSetScope -win $_nWave2 "/tb_SPI"
verdiSetActWin -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_SPI/U_SPI_MM"
wvAddSignal -win $_nWave2 "/tb_SPI/U_SPI_MM/bit_cnt\[2:0\]" \
           "/tb_SPI/U_SPI_MM/busy" "/tb_SPI/U_SPI_MM/clk" \
           "/tb_SPI/U_SPI_MM/clk_div\[7:0\]" "/tb_SPI/U_SPI_MM/cpha" \
           "/tb_SPI/U_SPI_MM/cpol" "/tb_SPI/U_SPI_MM/cs_n" \
           "/tb_SPI/U_SPI_MM/div_cnt\[7:0\]" "/tb_SPI/U_SPI_MM/done" \
           "/tb_SPI/U_SPI_MM/half_tick" "/tb_SPI/U_SPI_MM/miso" \
           "/tb_SPI/U_SPI_MM/mosi" "/tb_SPI/U_SPI_MM/reset" \
           "/tb_SPI/U_SPI_MM/rx_data\[7:0\]" \
           "/tb_SPI/U_SPI_MM/rx_shift_reg\[7:0\]" "/tb_SPI/U_SPI_MM/sclk" \
           "/tb_SPI/U_SPI_MM/sclk_r" "/tb_SPI/U_SPI_MM/start" \
           "/tb_SPI/U_SPI_MM/state\[1:0\]" "/tb_SPI/U_SPI_MM/step" \
           "/tb_SPI/U_SPI_MM/tx_data\[7:0\]" \
           "/tb_SPI/U_SPI_MM/tx_shift_reg\[7:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 22)}
wvSetPosition -win $_nWave2 {("G1" 22)}
wvGetSignalSetScope -win $_nWave2 "/tb_SPI/U_SPI_SS"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/tb_SPI/U_SPI_SS/bit_cnt\[3:0\]" \
           "/tb_SPI/U_SPI_SS/clk" "/tb_SPI/U_SPI_SS/cs_n" \
           "/tb_SPI/U_SPI_SS/cs_n_ff1" "/tb_SPI/U_SPI_SS/cs_n_ff2" \
           "/tb_SPI/U_SPI_SS/done" "/tb_SPI/U_SPI_SS/miso" \
           "/tb_SPI/U_SPI_SS/mode_reg\[1:0\]" "/tb_SPI/U_SPI_SS/mosi" \
           "/tb_SPI/U_SPI_SS/rst" "/tb_SPI/U_SPI_SS/rx_shift_reg\[7:0\]" \
           "/tb_SPI/U_SPI_SS/sclk" "/tb_SPI/U_SPI_SS/sclk_ff1" \
           "/tb_SPI/U_SPI_SS/sclk_ff2" "/tb_SPI/U_SPI_SS/sclk_negedge" \
           "/tb_SPI/U_SPI_SS/sclk_posedge" \
           "/tb_SPI/U_SPI_SS/slv_rx_data\[7:0\]" \
           "/tb_SPI/U_SPI_SS/slv_tx_data\[7:0\]" "/tb_SPI/U_SPI_SS/start" \
           "/tb_SPI/U_SPI_SS/state\[2:0\]" \
           "/tb_SPI/U_SPI_SS/tx_shift_reg\[7:0\]"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 21)}
wvSetPosition -win $_nWave2 {("G2" 21)}
wvSetPosition -win $_nWave2 {("G2" 21)}
wvSetPosition -win $_nWave2 {("G2" 21)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_SPI/U_SPI_MM/bit_cnt\[2:0\]} \
{/tb_SPI/U_SPI_MM/busy} \
{/tb_SPI/U_SPI_MM/clk} \
{/tb_SPI/U_SPI_MM/clk_div\[7:0\]} \
{/tb_SPI/U_SPI_MM/cpha} \
{/tb_SPI/U_SPI_MM/cpol} \
{/tb_SPI/U_SPI_MM/cs_n} \
{/tb_SPI/U_SPI_MM/div_cnt\[7:0\]} \
{/tb_SPI/U_SPI_MM/done} \
{/tb_SPI/U_SPI_MM/half_tick} \
{/tb_SPI/U_SPI_MM/miso} \
{/tb_SPI/U_SPI_MM/mosi} \
{/tb_SPI/U_SPI_MM/reset} \
{/tb_SPI/U_SPI_MM/rx_data\[7:0\]} \
{/tb_SPI/U_SPI_MM/rx_shift_reg\[7:0\]} \
{/tb_SPI/U_SPI_MM/sclk} \
{/tb_SPI/U_SPI_MM/sclk_r} \
{/tb_SPI/U_SPI_MM/start} \
{/tb_SPI/U_SPI_MM/state\[1:0\]} \
{/tb_SPI/U_SPI_MM/step} \
{/tb_SPI/U_SPI_MM/tx_data\[7:0\]} \
{/tb_SPI/U_SPI_MM/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/tb_SPI/U_SPI_SS/bit_cnt\[3:0\]} \
{/tb_SPI/U_SPI_SS/clk} \
{/tb_SPI/U_SPI_SS/cs_n} \
{/tb_SPI/U_SPI_SS/cs_n_ff1} \
{/tb_SPI/U_SPI_SS/cs_n_ff2} \
{/tb_SPI/U_SPI_SS/done} \
{/tb_SPI/U_SPI_SS/miso} \
{/tb_SPI/U_SPI_SS/mode_reg\[1:0\]} \
{/tb_SPI/U_SPI_SS/mosi} \
{/tb_SPI/U_SPI_SS/rst} \
{/tb_SPI/U_SPI_SS/rx_shift_reg\[7:0\]} \
{/tb_SPI/U_SPI_SS/sclk} \
{/tb_SPI/U_SPI_SS/sclk_ff1} \
{/tb_SPI/U_SPI_SS/sclk_ff2} \
{/tb_SPI/U_SPI_SS/sclk_negedge} \
{/tb_SPI/U_SPI_SS/sclk_posedge} \
{/tb_SPI/U_SPI_SS/slv_rx_data\[7:0\]} \
{/tb_SPI/U_SPI_SS/slv_tx_data\[7:0\]} \
{/tb_SPI/U_SPI_SS/start} \
{/tb_SPI/U_SPI_SS/state\[2:0\]} \
{/tb_SPI/U_SPI_SS/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSetPosition -win $_nWave2 {("G2" 21)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G2" 7 )} 
wvSetCursor -win $_nWave2 502899.237626 -snap {("G2" 7)}
wvSetCursor -win $_nWave2 525625.854390 -snap {("G2" 6)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 515198.393277 -snap {("G2" 20)}
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
debReload
srcTBInvokeSim
verdiSetActWin -win $_InteractiveConsole_3
srcTBRunSim
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 10151118.708609 -snap {("G2" 5)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G1" 10 )} 
wvSelectSignal -win $_nWave2 {( "G1" 15 )} 
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G2" 18 )} 
wvSelectSignal -win $_nWave2 {( "G2" 17 18 )} 
verdiHighlightSignal -sigColor { "tb_SPI.U_SPI_SS.slv_rx_data" N/A } { \
           "tb_SPI.U_SPI_SS.slv_tx_data" N/A }
verdiHighlightSignal -sigColor { "tb_SPI.U_SPI_SS.slv_rx_data" ID_YELLOW5 } { \
           "tb_SPI.U_SPI_SS.slv_tx_data" ID_YELLOW5 }
verdiHighlightSignal -apply
wvSelectSignal -win $_nWave2 {( "G1" 14 )} 
wvSelectSignal -win $_nWave2 {( "G1" 14 21 )} 
verdiHighlightSignal -sigColor { "tb_SPI.U_SPI_MM.rx_data" N/A } { \
           "tb_SPI.U_SPI_MM.tx_data" N/A }
verdiHighlightSignal -sigColor { "tb_SPI.U_SPI_MM.rx_data" ID_YELLOW5 } { \
           "tb_SPI.U_SPI_MM.tx_data" ID_YELLOW5 }
verdiHighlightSignal -apply
wvSetCursor -win $_nWave2 31775569.923546 -snap {("G1" 21)}
wvSetCursor -win $_nWave2 31792972.409576 -snap {("G2" 19)}
wvSetCursor -win $_nWave2 31753692.512536 -snap {("G2" 10)}
wvSetCursor -win $_nWave2 506163.736548 -snap {("G2" 7)}
wvSetCursor -win $_nWave2 494230.603270 -snap {("G2" 11)}
wvSetCursor -win $_nWave2 335122.159561 -snap {("G1" 22)}
wvSetCursor -win $_nWave2 342083.153974 -snap {("G1" 22)}
wvSetCursor -win $_nWave2 356502.356685 -snap {("G1" 20)}
wvSelectSignal -win $_nWave2 {( "G2" 7 )} 
wvSetCursor -win $_nWave2 483291.897765 -snap {("G1" 22)}
wvSetCursor -win $_nWave2 493236.175497 -snap {("G1" 20)}
wvSetCursor -win $_nWave2 388324.045426 -snap {("G2" 21)}
wvSetCursor -win $_nWave2 384346.334334 -snap {("G2" 21)}
wvSetCursor -win $_nWave2 377882.553808 -snap {("G2" 15)}
wvSetCursor -win $_nWave2 384843.548220 -snap {("G2" 16)}
wvSetCursor -win $_nWave2 373904.842715 -snap {("G2" 12)}
debReload
srcTBInvokeSim
srcTBRunSim
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 64162404.761905 -snap {("G1" 1)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 66395090.476190 -snap {("G2" 5)}
wvSetCursor -win $_nWave2 66415814.285714 -snap {("G2" 11)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 66420690.476190 -snap {("G2" 21)}
debReload
srcTBInvokeSim
srcTBRunSim
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 24954356.166667 -snap {("G1" 19)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 33524157.376295 -snap {("G1" 17)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 364384.854167 -snap {("G2" 21)}
wvSetCursor -win $_nWave2 357377.453125 -snap {("G2" 21)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 880179.623698 -snap {("G1" 17)}
wvSetCursor -win $_nWave2 877426.716146 -snap {("G2" 12)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
debReload
srcTBInvokeSim
srcTBRunSim
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 23677251.424877 -snap {("G2" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 23495003.805830 -snap {("G2" 12)}
wvSetCursor -win $_nWave2 23505365.710591 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 23512679.996306 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 23504756.186782 -snap {("G2" 13)}
debReload
srcTBInvokeSim
srcTBRunSim
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 66395395.238095 -snap {("G2" 5)}
wvSelectSignal -win $_nWave2 {( "G2" 7 )} 
wvSetCursor -win $_nWave2 66544728.571429 -snap {("G2" 7)}
wvSetCursor -win $_nWave2 66397223.809524 -snap {("G1" 15)}
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 66556309.523810 -snap {("G1" 19)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
debReload
srcTBInvokeSim
srcTBRunSim
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 329385.052034 -snap {("G2" 10)}
wvSetCursor -win $_nWave2 312431.409650 -snap {("G2" 10)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 492866.603595 -snap {("G2" 9)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 748382.213813 -snap {("G1" 15)}
wvSetCursor -win $_nWave2 488022.705771 -snap {("G2" 9)}
wvSetCursor -win $_nWave2 481967.833491 -snap {("G2" 10)}
wvSetCursor -win $_nWave2 500132.450331 -snap {("G2" 9)}
wvSetCursor -win $_nWave2 494077.578051 -snap {("G2" 9)}
wvSelectSignal -win $_nWave2 {( "G2" 9 )} 
wvCreateWindow
verdiSetActWin -win $_nWave4
wvSetPosition -win $_nWave4 {("G1" 0)}
wvOpenFile -win $_nWave4 \
           {/home/hedu22/PROJECT/Verilog_2026_Project/vcs/C09_SPI/inter.fsdb}
wvOpenFile -win $_nWave4 \
           {/home/hedu22/PROJECT/Verilog_2026_Project/vcs/C09_SPI/novas.fsdb}
wvGetSignalOpen -win $_nWave4
wvGetSignalSetScope -win $_nWave4 "/tb_SPI"
wvGetSignalSetScope -win $_nWave4 "/tb_SPI/U_SPI_MM"
wvAddSignal -win $_nWave4 "/tb_SPI/U_SPI_MM/bit_cnt\[2:0\]" \
           "/tb_SPI/U_SPI_MM/busy" "/tb_SPI/U_SPI_MM/clk" \
           "/tb_SPI/U_SPI_MM/clk_div\[7:0\]" "/tb_SPI/U_SPI_MM/cpha" \
           "/tb_SPI/U_SPI_MM/cpol" "/tb_SPI/U_SPI_MM/cs_n" \
           "/tb_SPI/U_SPI_MM/div_cnt\[7:0\]" "/tb_SPI/U_SPI_MM/done" \
           "/tb_SPI/U_SPI_MM/half_tick" "/tb_SPI/U_SPI_MM/miso" \
           "/tb_SPI/U_SPI_MM/mosi" "/tb_SPI/U_SPI_MM/reset" \
           "/tb_SPI/U_SPI_MM/rx_data\[7:0\]" \
           "/tb_SPI/U_SPI_MM/rx_shift_reg\[7:0\]" "/tb_SPI/U_SPI_MM/sclk" \
           "/tb_SPI/U_SPI_MM/sclk_r" "/tb_SPI/U_SPI_MM/start" \
           "/tb_SPI/U_SPI_MM/state\[1:0\]" "/tb_SPI/U_SPI_MM/step" \
           "/tb_SPI/U_SPI_MM/tx_data\[7:0\]" \
           "/tb_SPI/U_SPI_MM/tx_shift_reg\[7:0\]"
wvSetPosition -win $_nWave4 {("G1" 0)}
wvSetPosition -win $_nWave4 {("G1" 22)}
wvSetPosition -win $_nWave4 {("G1" 22)}
wvGetSignalSetScope -win $_nWave4 "/tb_SPI/U_SPI_SS"
wvSetPosition -win $_nWave4 {("G1" 14)}
wvSetPosition -win $_nWave4 {("G1" 15)}
wvSetPosition -win $_nWave4 {("G1" 18)}
wvSetPosition -win $_nWave4 {("G1" 19)}
wvSetPosition -win $_nWave4 {("G1" 20)}
wvSetPosition -win $_nWave4 {("G2" 0)}
wvSetPosition -win $_nWave4 {("G1" 0)}
wvSetPosition -win $_nWave4 {("G2" 0)}
wvAddSignal -win $_nWave4 "/tb_SPI/U_SPI_SS/bit_cnt\[3:0\]" \
           "/tb_SPI/U_SPI_SS/clk" "/tb_SPI/U_SPI_SS/cs_n" \
           "/tb_SPI/U_SPI_SS/done" "/tb_SPI/U_SPI_SS/miso" \
           "/tb_SPI/U_SPI_SS/mosi" "/tb_SPI/U_SPI_SS/rst" \
           "/tb_SPI/U_SPI_SS/rx_sh\[7:0\]" "/tb_SPI/U_SPI_SS/sclk" \
           "/tb_SPI/U_SPI_SS/slv_rx_data\[7:0\]" \
           "/tb_SPI/U_SPI_SS/slv_tx_data\[7:0\]" \
           "/tb_SPI/U_SPI_SS/tx_sh\[7:0\]"
wvSetPosition -win $_nWave4 {("G2" 0)}
wvSetPosition -win $_nWave4 {("G2" 12)}
wvSetPosition -win $_nWave4 {("G2" 12)}
wvSetCursor -win $_nWave4 1594266.605960 -snap {("G3" 0)}
wvSelectSignal -win $_nWave4 {( "G2" 12 )} 
wvSetCursor -win $_nWave4 518693.526490 -snap {("G2" 12)}
wvZoomIn -win $_nWave4
wvSetCursor -win $_nWave4 760538.360927 -snap {("G2" 12)}
wvScrollDown -win $_nWave4 0
wvScrollDown -win $_nWave4 0
wvScrollDown -win $_nWave4 0
wvSetCursor -win $_nWave4 510738.104305 -snap {("G2" 12)}
wvSetCursor -win $_nWave4 318216.887417 -snap {("G2" 11)}
wvSetCursor -win $_nWave4 2498002.566225 -snap {("G1" 12)}
debExit
