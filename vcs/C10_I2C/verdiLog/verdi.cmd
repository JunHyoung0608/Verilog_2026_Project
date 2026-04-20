verdiSetActWin -dock widgetDock_<Watch>
simSetSimulator "-vcssv" -exec "simv" -args \
           "+UVM_TESTNAME=I2C_write +UVM_VERBOSITY=UVM_DEBUG +ntb_random_seed=random -cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1"
debImport "-dbdir" "simv.daidir"
debLoadSimResult /home/hedu22/PROJECT/Verilog_2026_Project/vcs/C10_I2C/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "8" "31" "2560" "1369"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_I2C.U_MASTER" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_MASTER" 0)}
wvRenameGroup -win $_nWave2 {G1} {U_MASTER}
wvAddSignal -win $_nWave2 "/tb_I2C/U_MASTER/clk" "/tb_I2C/U_MASTER/rst" \
           "/tb_I2C/U_MASTER/cmd_start" "/tb_I2C/U_MASTER/cmd_write" \
           "/tb_I2C/U_MASTER/cmd_read" "/tb_I2C/U_MASTER/cmd_stop" \
           "/tb_I2C/U_MASTER/tx_data\[7:0\]" "/tb_I2C/U_MASTER/ack_in" \
           "/tb_I2C/U_MASTER/rx_data\[7:0\]" "/tb_I2C/U_MASTER/done" \
           "/tb_I2C/U_MASTER/ack_out" "/tb_I2C/U_MASTER/busy" \
           "/tb_I2C/U_MASTER/scl" "/tb_I2C/U_MASTER/sda"
wvSetPosition -win $_nWave2 {("U_MASTER" 0)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
srcHBSelect "tb_I2C.U_SLAVE" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_MASTER" 1)}
wvSetPosition -win $_nWave2 {("U_MASTER" 2)}
wvSetPosition -win $_nWave2 {("U_MASTER" 3)}
wvSetPosition -win $_nWave2 {("U_MASTER" 4)}
wvSetPosition -win $_nWave2 {("U_MASTER" 5)}
wvSetPosition -win $_nWave2 {("U_MASTER" 6)}
wvSetPosition -win $_nWave2 {("U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_MASTER" 8)}
wvSetPosition -win $_nWave2 {("U_MASTER" 9)}
wvSetPosition -win $_nWave2 {("U_MASTER" 10)}
wvSetPosition -win $_nWave2 {("U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_MASTER" 13)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
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
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 7 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 9 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 13 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 14 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 9 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 10 )} 
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvGoToTime -win $_nWave2 -marker 190065
wvGoToTime -win $_nWave2 -marker 190065
wvGoToTime -win $_nWave2 -marker 190065
wvGoToTime -win $_nWave2 -marker 190065
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 90115045.389144 -snap {("U_MASTER" 5)}
wvSetCursor -win $_nWave2 107198466.315996 -snap {("U_MASTER" 5)}
wvSetCursor -win $_nWave2 153323702.818496 -snap {("U_MASTER" 5)}
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 150334104.156297 -snap {("U_MASTER" 1)}
wvSetCursor -win $_nWave2 150335000.000000
wvSetCursor -win $_nWave2 50823177.257384
wvSetCursor -win $_nWave2 29041815.575648
wvSetCursor -win $_nWave2 11531309.125625 -snap {("U_MASTER" 7)}
wvGoToTime -win $_nWave2 -marker 190065
wvGoToTime -win $_nWave2 -marker 190065
wvGoToTime -win $_nWave2 -marker 190065
wvGoToTime -win $_nWave2 -marker 190065
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 28614730.052477 -snap {("U_MASTER" 10)}
wvSetCursor -win $_nWave2 60005516.005567 -snap {("U_MASTER" 11)}
wvSetCursor -win $_nWave2 11104223.602454 -snap {("U_MASTER" 4)}
wvSetCursor -win $_nWave2 23916789.297593 -snap {("U_MASTER" 4)}
wvSetCursor -win $_nWave2 21140733.396979 -snap {("U_MASTER" 5)}
wvSetCursor -win $_nWave2 11317766.364039 -snap {("U_MASTER" 4)}
wvSelectSignal -win $_nWave2 {( "U_MASTER" 6 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 7 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 9 )} 
wvSelectSignal -win $_nWave2 {( "U_MASTER" 10 )} 
wvSetCursor -win $_nWave2 60646144.290324 -snap {("U_MASTER" 7)}
wvSetCursor -win $_nWave2 9182338.748183 -snap {("U_MASTER" 9)}
wvSetCursor -win $_nWave2 10250052.556111 -snap {("U_MASTER" 10)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 100792183.468426 -snap {("U_MASTER" 10)}
wvSetCursor -win $_nWave2 190693686.095984 -snap {("U_MASTER" 10)}
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_I2C"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE"
wvSetPosition -win $_nWave2 {("U_MASTER" 6)}
wvSetPosition -win $_nWave2 {("U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_MASTER" 9)}
wvSetPosition -win $_nWave2 {("U_MASTER" 10)}
wvSetPosition -win $_nWave2 {("U_MASTER" 11)}
wvSetPosition -win $_nWave2 {("U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_MASTER" 13)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 1)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 2)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 3)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 4)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 8)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"U_MASTER" \
{/tb_I2C/U_MASTER/clk} \
{/tb_I2C/U_MASTER/rst} \
{/tb_I2C/U_MASTER/cmd_start} \
{/tb_I2C/U_MASTER/cmd_write} \
{/tb_I2C/U_MASTER/cmd_read} \
{/tb_I2C/U_MASTER/cmd_stop} \
{/tb_I2C/U_MASTER/tx_data\[7:0\]} \
{/tb_I2C/U_MASTER/ack_in} \
{/tb_I2C/U_MASTER/rx_data\[7:0\]} \
{/tb_I2C/U_MASTER/done} \
{/tb_I2C/U_MASTER/ack_out} \
{/tb_I2C/U_MASTER/busy} \
{/tb_I2C/U_MASTER/scl} \
{/tb_I2C/U_MASTER/sda} \
}
wvAddSignal -win $_nWave2 -group {"U_SLAVE" \
{/tb_I2C/U_SLAVE/clk} \
{/tb_I2C/U_SLAVE/rst} \
{/tb_I2C/U_SLAVE/scl} \
{/tb_I2C/U_SLAVE/sda} \
{/tb_I2C/U_SLAVE/tx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/ack_in} \
{/tb_I2C/U_SLAVE/rx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/busy} \
{/tb_I2C/U_SLAVE/done} \
{/tb_I2C/U_SLAVE/state\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 10 )} 
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER"
wvGetSignalSetScope -win $_nWave2 \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/i2c_master_ff"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER"
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"U_MASTER" \
{/tb_I2C/U_MASTER/clk} \
{/tb_I2C/U_MASTER/rst} \
{/tb_I2C/U_MASTER/cmd_start} \
{/tb_I2C/U_MASTER/cmd_write} \
{/tb_I2C/U_MASTER/cmd_read} \
{/tb_I2C/U_MASTER/cmd_stop} \
{/tb_I2C/U_MASTER/tx_data\[7:0\]} \
{/tb_I2C/U_MASTER/ack_in} \
{/tb_I2C/U_MASTER/rx_data\[7:0\]} \
{/tb_I2C/U_MASTER/done} \
{/tb_I2C/U_MASTER/ack_out} \
{/tb_I2C/U_MASTER/busy} \
{/tb_I2C/U_MASTER/scl} \
{/tb_I2C/U_MASTER/sda} \
}
wvAddSignal -win $_nWave2 -group {"U_SLAVE" \
{/tb_I2C/U_SLAVE/clk} \
{/tb_I2C/U_SLAVE/rst} \
{/tb_I2C/U_SLAVE/scl} \
{/tb_I2C/U_SLAVE/sda} \
{/tb_I2C/U_SLAVE/tx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/ack_in} \
{/tb_I2C/U_SLAVE/rx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/busy} \
{/tb_I2C/U_SLAVE/done} \
{/tb_I2C/U_SLAVE/state\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 10 )} 
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
debReload
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvSetPosition -win $_nWave2 {("U_MASTER" 1)}
wvSetPosition -win $_nWave2 {("U_MASTER" 0)}
wvSetPosition -win $_nWave2 {("U_MASTER" 1)}
wvSetPosition -win $_nWave2 {("U_MASTER" 3)}
wvSetPosition -win $_nWave2 {("U_MASTER" 4)}
wvSetPosition -win $_nWave2 {("U_MASTER" 5)}
wvSetPosition -win $_nWave2 {("U_MASTER" 6)}
wvSetPosition -win $_nWave2 {("U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_MASTER" 8)}
wvSetPosition -win $_nWave2 {("U_MASTER" 9)}
wvSetPosition -win $_nWave2 {("U_MASTER" 10)}
wvSetPosition -win $_nWave2 {("U_MASTER" 11)}
wvSetPosition -win $_nWave2 {("U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_MASTER" 13)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 1)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvAddSignal -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/state\[2:0\]"
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_MASTER" 15)}
wvSetCursor -win $_nWave2 161818039.331442 -snap {("U_SLAVE" 4)}
wvSetPosition -win $_nWave2 {("U_MASTER" 15)}
wvSetPosition -win $_nWave2 {("U_MASTER" 15)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"U_MASTER" \
{/tb_I2C/U_MASTER/clk} \
{/tb_I2C/U_MASTER/rst} \
{/tb_I2C/U_MASTER/cmd_start} \
{/tb_I2C/U_MASTER/cmd_write} \
{/tb_I2C/U_MASTER/cmd_read} \
{/tb_I2C/U_MASTER/cmd_stop} \
{/tb_I2C/U_MASTER/tx_data\[7:0\]} \
{/tb_I2C/U_MASTER/ack_in} \
{/tb_I2C/U_MASTER/rx_data\[7:0\]} \
{/tb_I2C/U_MASTER/done} \
{/tb_I2C/U_MASTER/ack_out} \
{/tb_I2C/U_MASTER/busy} \
{/tb_I2C/U_MASTER/scl} \
{/tb_I2C/U_MASTER/sda} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/state\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"U_SLAVE" \
{/tb_I2C/U_SLAVE/clk} \
{/tb_I2C/U_SLAVE/rst} \
{/tb_I2C/U_SLAVE/scl} \
{/tb_I2C/U_SLAVE/sda} \
{/tb_I2C/U_SLAVE/tx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/ack_in} \
{/tb_I2C/U_SLAVE/rx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/busy} \
{/tb_I2C/U_SLAVE/done} \
{/tb_I2C/U_SLAVE/state\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSetPosition -win $_nWave2 {("U_MASTER" 15)}
wvSetCursor -win $_nWave2 90110437.588489 -snap {("U_MASTER" 15)}
wvSetCursor -win $_nWave2 101109833.726051 -snap {("U_MASTER" 15)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvZoomIn -win $_nWave2
srcHBSelect "tb_I2C.U_SLAVE" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvSetPosition -win $_nWave2 {("U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_MASTER" 8)}
wvSetPosition -win $_nWave2 {("U_MASTER" 10)}
wvSetPosition -win $_nWave2 {("U_MASTER" 11)}
wvSetPosition -win $_nWave2 {("U_MASTER" 12)}
wvSetPosition -win $_nWave2 {("U_MASTER" 13)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_MASTER" 15)}
wvAddSignal -win $_nWave2 \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/rx_shift_reg\[7:0\]" \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/tx_shift_reg\[7:0\]"
wvSetPosition -win $_nWave2 {("U_MASTER" 15)}
wvSetPosition -win $_nWave2 {("U_MASTER" 17)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
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
wvSetPosition -win $_nWave2 {("U_MASTER" 17)}
wvSetPosition -win $_nWave2 {("U_MASTER" 17)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"U_MASTER" \
{/tb_I2C/U_MASTER/clk} \
{/tb_I2C/U_MASTER/rst} \
{/tb_I2C/U_MASTER/cmd_start} \
{/tb_I2C/U_MASTER/cmd_write} \
{/tb_I2C/U_MASTER/cmd_read} \
{/tb_I2C/U_MASTER/cmd_stop} \
{/tb_I2C/U_MASTER/tx_data\[7:0\]} \
{/tb_I2C/U_MASTER/ack_in} \
{/tb_I2C/U_MASTER/rx_data\[7:0\]} \
{/tb_I2C/U_MASTER/done} \
{/tb_I2C/U_MASTER/ack_out} \
{/tb_I2C/U_MASTER/busy} \
{/tb_I2C/U_MASTER/scl} \
{/tb_I2C/U_MASTER/sda} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/state\[2:0\]} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/rx_shift_reg\[7:0\]} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"U_SLAVE" \
{/tb_I2C/U_SLAVE/clk} \
{/tb_I2C/U_SLAVE/rst} \
{/tb_I2C/U_SLAVE/scl} \
{/tb_I2C/U_SLAVE/sda} \
{/tb_I2C/U_SLAVE/tx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/ack_in} \
{/tb_I2C/U_SLAVE/rx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/busy} \
{/tb_I2C/U_SLAVE/done} \
{/tb_I2C/U_SLAVE/state\[2:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSetPosition -win $_nWave2 {("U_MASTER" 17)}
wvGetSignalClose -win $_nWave2
debReload
wvSetCursor -win $_nWave2 226756781.912818 -snap {("U_SLAVE" 7)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 119583946.487963 -snap {("U_MASTER" 17)}
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE"
wvSetPosition -win $_nWave2 {("U_MASTER" 7)}
wvSetPosition -win $_nWave2 {("U_MASTER" 8)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 1)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 3)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvAddSignal -win $_nWave2 "/tb_I2C/U_SLAVE/rx_shift_reg\[7:0\]" \
           "/tb_I2C/U_SLAVE/tx_shift_reg\[7:0\]"
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 12)}
wvSetCursor -win $_nWave2 142646564.739213 -snap {("U_SLAVE" 11)}
wvSetCursor -win $_nWave2 231907439.082014 -snap {("U_SLAVE" 11)}
wvSetCursor -win $_nWave2 360460181.556575 -snap {("U_SLAVE" 11)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetPosition -win $_nWave2 {("U_SLAVE" 12)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 12)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"U_MASTER" \
{/tb_I2C/U_MASTER/clk} \
{/tb_I2C/U_MASTER/rst} \
{/tb_I2C/U_MASTER/cmd_start} \
{/tb_I2C/U_MASTER/cmd_write} \
{/tb_I2C/U_MASTER/cmd_read} \
{/tb_I2C/U_MASTER/cmd_stop} \
{/tb_I2C/U_MASTER/tx_data\[7:0\]} \
{/tb_I2C/U_MASTER/ack_in} \
{/tb_I2C/U_MASTER/rx_data\[7:0\]} \
{/tb_I2C/U_MASTER/done} \
{/tb_I2C/U_MASTER/ack_out} \
{/tb_I2C/U_MASTER/busy} \
{/tb_I2C/U_MASTER/scl} \
{/tb_I2C/U_MASTER/sda} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/state\[2:0\]} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/rx_shift_reg\[7:0\]} \
{/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"U_SLAVE" \
{/tb_I2C/U_SLAVE/clk} \
{/tb_I2C/U_SLAVE/rst} \
{/tb_I2C/U_SLAVE/scl} \
{/tb_I2C/U_SLAVE/sda} \
{/tb_I2C/U_SLAVE/tx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/ack_in} \
{/tb_I2C/U_SLAVE/rx_data\[7:0\]} \
{/tb_I2C/U_SLAVE/busy} \
{/tb_I2C/U_SLAVE/done} \
{/tb_I2C/U_SLAVE/state\[2:0\]} \
{/tb_I2C/U_SLAVE/rx_shift_reg\[7:0\]} \
{/tb_I2C/U_SLAVE/tx_shift_reg\[7:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
}
wvSetPosition -win $_nWave2 {("U_SLAVE" 12)}
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 96521328.236713 -snap {("U_SLAVE" 11)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 176386321.069746 -snap {("U_MASTER" 17)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 91396301.958658 -snap {("U_MASTER" 15)}
wvZoomIn -win $_nWave2
debReload
srcTBInvokeSim
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
srcTBRunSim
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
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
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 25582684710.687542 -snap {("U_MASTER" 7)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
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
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 25800696409.516792 -snap {("U_MASTER" 7)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 25702548553.832657 -snap {("U_SLAVE" 11)}
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 11 )} 
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 6 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 5 )} 
wvSelectSignal -win $_nWave2 {( "U_SLAVE" 4 )} 
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 25702437022.178467 -snap {("U_SLAVE" 4)}
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
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
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
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
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
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvGetSignalSetScope -win $_nWave2 \
           "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE/i2c_master_ff"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_MASTER/U_I2C_MASTER_CORE"
wvGetSignalSetScope -win $_nWave2 "/tb_I2C/U_SLAVE"
wvSetPosition -win $_nWave2 {("U_SLAVE" 0)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 2)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 4)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 5)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 6)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 7)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 6)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 8)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 9)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 10)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 11)}
wvSetPosition -win $_nWave2 {("U_MASTER" 14)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 12)}
wvAddSignal -win $_nWave2 "/tb_I2C/U_SLAVE/scl_posedge"
wvSetPosition -win $_nWave2 {("U_SLAVE" 12)}
wvSetPosition -win $_nWave2 {("U_SLAVE" 13)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 25702524504.819721 -snap {("U_SLAVE" 13)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 25702579399.305767 -snap {("U_SLAVE" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
debReload
wvSetCursor -win $_nWave2 7922339199.307545 -snap {("U_MASTER" 15)}
srcTBInvokeSim
srcTBRunSim
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
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
wvZoomAll -win $_nWave2
wvSelectErrIndicator -win $_nWave2 -time 25790065000
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectErrIndicator -win $_nWave2 -time 51190065000
wvZoomIn -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 51293456657.318901 -snap {("U_SLAVE" 9)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 51701444663.064034 -snap {("U_SLAVE" 13)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 51370736488.542877 -snap {("U_SLAVE" 7)}
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
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 51117115633.205460 -snap {("U_MASTER" 7)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 50899302016.387489 -snap {("U_MASTER" 7)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomIn -win $_nWave2
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 50772189069.806381 -snap {("U_SLAVE" 11)}
wvSetCursor -win $_nWave2 50701839671.848526 -snap {("U_SLAVE" 13)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 142359347.075017
wvSetCursor -win $_nWave2 37815534656.907219
wvSetCursor -win $_nWave2 38881762137.835052
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 50611740750.591187 -snap {("U_SLAVE" 13)}
wvSetCursor -win $_nWave2 50631816711.577621 -snap {("U_SLAVE" 13)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 50622260004.118057 -snap {("U_SLAVE" 13)}
wvSetCursor -win $_nWave2 50632572997.775467 -snap {("U_SLAVE" 3)}
wvSetCursor -win $_nWave2 50642335965.104485 -snap {("U_SLAVE" 3)}
wvSetCursor -win $_nWave2 50662274419.508820 -snap {("U_SLAVE" 3)}
wvSetCursor -win $_nWave2 50702563848.063782 -snap {("U_SLAVE" 4)}
wvSetCursor -win $_nWave2 50702426341.481682 -snap {("U_SLAVE" 3)}
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 50702575557.608078 -snap {("U_SLAVE" 13)}
wvSetCursor -win $_nWave2 50702586300.309807 -snap {("U_SLAVE" 13)}
wvSetCursor -win $_nWave2 50702576631.878250 -snap {("U_SLAVE" 13)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
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
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
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
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 64473057920.496262 -snap {("U_SLAVE" 0)}
wvSetCursor -win $_nWave2 56387559926.104691 -snap {("U_MASTER" 15)}
wvSetCursor -win $_nWave2 51606569807.681847 -snap {("U_MASTER" 16)}
debReload
srcTBInvokeSim
srcTBRunSim
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
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
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 100785495822.909592 -snap {("U_MASTER" 10)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectErrIndicator -win $_nWave2 -time 102390065000
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
wvSelectSignal -win $_nWave2 {( "U_MASTER" 16 )} 
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
wvSetCursor -win $_nWave2 100101684547.435455 -snap {("U_SLAVE" 5)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 100097051138.869858 -snap {("U_SLAVE" 12)}
wvSetCursor -win $_nWave2 100099501499.168976 -snap {("U_SLAVE" 6)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 60904373514.615906 -snap {("U_SLAVE" 6)}
wvSetCursor -win $_nWave2 58395204568.320869 -snap {("U_SLAVE" 5)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
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
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 81411363098.529190 -snap {("U_MASTER" 17)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
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
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 81298869284.797043 -snap {("U_SLAVE" 5)}
wvSetCursor -win $_nWave2 81297087204.579498 -snap {("U_SLAVE" 12)}
wvSetCursor -win $_nWave2 81291295443.872498 -snap {("U_SLAVE" 10)}
debExit
