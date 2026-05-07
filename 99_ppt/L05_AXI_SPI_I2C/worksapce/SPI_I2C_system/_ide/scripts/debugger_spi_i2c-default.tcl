# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Verilog_2026_Project\99_PPT\L05_AXI_SPI_I2C\worksapce\SPI_I2C_system\_ide\scripts\debugger_spi_i2c-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Verilog_2026_Project\99_PPT\L05_AXI_SPI_I2C\worksapce\SPI_I2C_system\_ide\scripts\debugger_spi_i2c-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Basys3 210183B822AAA" && level==0 && jtag_device_ctx=="jsn-Basys3-210183B822AAA-0362d093-0"}
fpga -file D:/Verilog_2026_Project/99_PPT/L05_AXI_SPI_I2C/worksapce/SPI_I2C/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw D:/Verilog_2026_Project/99_ppt/L05_AXI_SPI_I2C/worksapce/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow D:/Verilog_2026_Project/99_PPT/L05_AXI_SPI_I2C/worksapce/SPI_I2C/Debug/SPI_I2C.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
