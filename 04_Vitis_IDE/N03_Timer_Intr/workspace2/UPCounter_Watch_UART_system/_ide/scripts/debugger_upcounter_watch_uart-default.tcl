# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Verilog_2026_Project\04_Vitis_IDE\N03_Timer_Intr\workspace2\UPCounter_Watch_UART_system\_ide\scripts\debugger_upcounter_watch_uart-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Verilog_2026_Project\04_Vitis_IDE\N03_Timer_Intr\workspace2\UPCounter_Watch_UART_system\_ide\scripts\debugger_upcounter_watch_uart-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw D:/Verilog_2026_Project/04_Vitis_IDE/N03_Timer_Intr/workspace2/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper2.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow D:/Verilog_2026_Project/04_Vitis_IDE/N03_Timer_Intr/workspace2/UPCounter_Watch_UART/Debug/UPCounter_Watch_UART.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
