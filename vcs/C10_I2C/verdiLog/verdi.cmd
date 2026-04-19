verdiSetActWin -dock widgetDock_<Watch>
simSetSimulator "-vcssv" -exec "simv" -args \
           "+UVM_TESTNAME=I2C_write +UVM_VERBOSITY=UVM_DEBUG +ntb_random_seed=random -cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1"
debImport "-dbdir" "simv.daidir"
debLoadSimResult /home/hedu22/PROJECT/Verilog_2026_Project/vcs/C10_I2C/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "8" "31" "2560" "1369"
wvSetCursor -win $_nWave2 852845352.225799
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_I2C.U_MASTER.U_I2C_MASTER_CORE" -win $_nTrace1
srcHBDrag -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
wvRenameGroup -win $_nWave2 {G1} {U_I2C_MASTER_CORE}
wvAddSignal -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/clk" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/rst" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/cmd_start" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/cmd_write" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/cmd_read" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/cmd_stop" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/tx_data\[7:0\]" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/ack_in" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/rx_data\[7:0\]" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/done" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/ack_out" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/busy" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/scl" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/sda_o" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/sda_i"
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 15)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 15)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 9306844.121512 -snap {("U_I2C_MASTER_CORE" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "U_I2C_MASTER_CORE" 1 )} 
wvSelectSignal -win $_nWave2 {( "U_I2C_MASTER_CORE" 1 2 3 4 5 6 7 8 9 10 11 12 \
           13 14 15 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
srcHBSelect "tb_I2C.U_MASTER" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_MASTER}
wvAddSignal -win $_nWave2 "/tb_I2C/U_MASTER/clk" "/tb_I2C/U_MASTER/rst" \
           "/tb_I2C/U_MASTER/cmd_start" "/tb_I2C/U_MASTER/cmd_write" \
           "/tb_I2C/U_MASTER/cmd_read" "/tb_I2C/U_MASTER/cmd_stop" \
           "/tb_I2C/U_MASTER/tx_data\[7:0\]" "/tb_I2C/U_MASTER/ack_in" \
           "/tb_I2C/U_MASTER/rx_data\[7:0\]" "/tb_I2C/U_MASTER/done" \
           "/tb_I2C/U_MASTER/ack_out" "/tb_I2C/U_MASTER/busy" \
           "/tb_I2C/U_MASTER/scl" "/tb_I2C/U_MASTER/sda"
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvSetCursor -win $_nWave2 99625535.937091 -snap {("U_MASTER" 7)}
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 190155746.937250 -snap {("U_MASTER" 6)}
srcHBSelect "tb_I2C.U_SLAVE" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 1)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 2)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 3)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 5)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 6)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 8)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 9)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 10)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 11)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 13)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvRenameGroup -win $_nWave2 {G2} {U_SLAVE}
wvAddSignal -win $_nWave2 "/tb_I2C/U_SLAVE/clk" "/tb_I2C/U_SLAVE/rst" \
           "/tb_I2C/U_SLAVE/scl" "/tb_I2C/U_SLAVE/sda" \
           "/tb_I2C/U_SLAVE/tx_data\[7:0\]" "/tb_I2C/U_SLAVE/ack_in" \
           "/tb_I2C/U_SLAVE/rx_data\[7:0\]" "/tb_I2C/U_SLAVE/busy" \
           "/tb_I2C/U_SLAVE/done"
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_I2C_MASTER_CORE/U_MASTER" 6 )} 
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 241659687.829923 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 192986181.800575 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 207502841.493538 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 387680205.917969 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 391949811.710017 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 191334314.380731 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 297251524.127208 -snap {("U_MASTER" 4)}
wvSetCursor -win $_nWave2 191334314.380731 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 276751419.014986 -snap {("U_SLAVE" 7)}
wvSetCursor -win $_nWave2 657711705.683764 -snap {("U_SLAVE" 7)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 276751419.014986 -snap {("U_SLAVE" 7)}
wvSetCursor -win $_nWave2 298959866.219893 -snap {("U_MASTER" 4)}
wvSetCursor -win $_nWave2 278459761.107671 -snap {("U_SLAVE" 7)}
wvSetCursor -win $_nWave2 184500946.009991 -snap {("U_MASTER" 6)}
wvSetCursor -win $_nWave2 210126077.400267 -snap {("U_MASTER" 10)}
wvSetCursor -win $_nWave2 278459761.107671 -snap {("U_SLAVE" 7)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 298959866.219893 -snap {("U_MASTER" 4)}
wvSetCursor -win $_nWave2 196459340.658787 -snap {("U_MASTER" 3)}
wvSetCursor -win $_nWave2 184500946.009991 -snap {("U_MASTER" 11)}
wvSetCursor -win $_nWave2 99083841.375736 -snap {("U_SLAVE" 8)}
wvSetCursor -win $_nWave2 90542130.912310 -snap {("U_SLAVE" 8)}
wvSetCursor -win $_nWave2 97375499.283051 -snap {("U_SLAVE" 8)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_I2C"
verdiSetActWin -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE/i2c_salve"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE/blockName"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 6)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 8)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 9)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 10)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 11)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvAddSignal -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/state\[2:0\]"
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 15)}
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE"
wvScrollDown -win $_nWave2 1
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 9)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 15)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 2)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 3)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 4)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 5)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 6)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 7)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvAddSignal -win $_nWave2 "/tb_I2C/U_SLAVE/state\[2:0\]"
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetCursor -win $_nWave2 91396301.958653 -snap {("U_SLAVE" 10)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 82641048.733642 -snap {("U_SLAVE" 10)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 92303858.695386 -snap {("U_SLAVE" 10)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 5)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 13)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 15)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 1)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 2)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 3)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 4)}
wvSetPosition -win $_nWave2 {("U_I2C_MASTER_CORE/U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvAddSignal -win $_nWave2 "/tb_I2C/U_SLAVE/rx_shift_reg\[7:0\]"
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetCursor -win $_nWave2 82000420.448885 -snap {("U_SLAVE" 11)}
wvSetCursor -win $_nWave2 4270855.231713 -snap {("U_SLAVE" 4)}
wvSetCursor -win $_nWave2 8541710.463425 -snap {("U_SLAVE" 11)}
wvSetCursor -win $_nWave2 95240071.667194 -snap {("U_MASTER" 11)}
wvSetCursor -win $_nWave2 181938432.870963 -snap {("U_MASTER" 11)}
wvSetCursor -win $_nWave2 272480563.783273 -snap {("U_SLAVE" 7)}
wvSetCursor -win $_nWave2 187490544.672190 -snap {("U_SLAVE" 10)}
wvSetCursor -win $_nWave2 272907649.306445 -snap {("U_SLAVE" 7)}
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 677357639.749642 -snap {("U_SLAVE" 7)}
wvSetCursor -win $_nWave2 262230511.227163 -snap {("U_SLAVE" 7)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 210980248.446610 -snap {("U_MASTER" 7)}
wvSetCursor -win $_nWave2 101646354.514763 -snap {("U_MASTER" 7)}
wvSetCursor -win $_nWave2 91823387.481824 -snap {("U_SLAVE" 4)}
wvSetCursor -win $_nWave2 4270855.231713 -snap {("U_SLAVE" 4)}
wvSetCursor -win $_nWave2 99938012.422078 -snap {("U_MASTER" 10)}
wvSetCursor -win $_nWave2 10677138.079282 -snap {("U_MASTER" 10)}
wvSetCursor -win $_nWave2 99938012.422078 -snap {("U_MASTER" 15)}
wvSetCursor -win $_nWave2 182365518.394134 -snap {("U_MASTER" 14)}
wvSetCursor -win $_nWave2 187917630.195361 -snap {("U_MASTER" 15)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 5125026.278055 -snap {("U_MASTER" 11)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 418543812.707851 -snap {("U_MASTER" 11)}
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 10 )} 
wvFitSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 10 )} 
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 10 )} 
wvFitSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 31259554219.605171 -snap {("G3" 0)}
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
wvSetCursor -win $_nWave2 91032891004.390732
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 9574998589.788971 -snap {("U_MASTER" 5)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 18164335560.040844 -snap {("U_MASTER" 7)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSetCursor -win $_nWave2 27739334149.829815 -snap {("U_SLAVE" 0)}
wvZoomIn -win $_nWave2
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 45710580410.993866 -snap {("U_MASTER" 13)}
debExit
