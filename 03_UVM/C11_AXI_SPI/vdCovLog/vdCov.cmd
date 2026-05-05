verdiWindowResize -win $_vdCoverage_1 "830" "370" "900" "700"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
verdiSetFont  -font  {DejaVu Sans}  -size  11
verdiSetFont -font "DejaVu Sans" -size "11"
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
verdiSetActWin -dock widgetDock_Message
gui_open_cov  -hier coverage.vdb -testdir {} -test {coverage/sim1} -merge MergedTest -db_max_tests 10 -sdc_level 1 -fsm transition
verdiWindowResize -win $_vdCoverage_1 "830" "370" "1015" "709"
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
verdiSetActWin -dock widgetDock_<Summary>
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {/$unit::AXI_SPI_coverage::AXI_SPI_cg}   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} {/$unit::AXI_SPI_coverage::AXI_SPI_cg}
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { {/$unit::AXI_SPI_coverage::AXI_SPI_cg}  {$unit::AXI_SPI_coverage::AXI_SPI_cg.cp_axi_wdata}   }
verdiSetActWin -dock widgetDock_<CovDetail>
verdiWindowResize -win $_vdCoverage_1 "830" "370" "1471" "709"
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} {$unit::AXI_SPI_coverage::AXI_SPI_cg.cp_axi_wdata}  -column {Group} 
verdiSetActWin -dock widgetDock_<Summary>
verdiSetActWin -dock widgetDock_<CovDetail>
gui_list_select -id CovDetail.1 -list {covergroup detail} { walking_ones_20   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { walking_ones_20  walking_zeros_df   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { walking_zeros_df  walking_zeros_ef   }
gui_list_select -id CovDetail.1 -list {covergroup detail} { walking_zeros_ef  walking_zeros_fd   }
gui_list_sort -id  CovDetail.1   -list {covergroup detail} -descending  {Bin Name}
gui_list_sort -id  CovDetail.1   -list {covergroup detail} {Bin Name}
verdiWindowResize -win $_vdCoverage_1 "830" "370" "1471" "870"
vdCovExit -noprompt
