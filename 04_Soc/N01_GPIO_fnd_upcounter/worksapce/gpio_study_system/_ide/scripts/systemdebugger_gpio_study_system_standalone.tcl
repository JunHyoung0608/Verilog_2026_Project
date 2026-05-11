# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Verilog_2026_Project\04_Vitis_IDE\N01_GPIO_fnd_upcounter\worksapce\gpio_study_system\_ide\scripts\systemdebugger_gpio_study_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Verilog_2026_Project\04_Vitis_IDE\N01_GPIO_fnd_upcounter\worksapce\gpio_study_system\_ide\scripts\systemdebugger_gpio_study_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Basys3 210183BB7CD3A" && level==0 && jtag_device_ctx=="jsn-Basys3-210183BB7CD3A-0362d093-0"}
fpga -file D:/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/worksapce/gpio_study/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw D:/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/worksapce/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow D:/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/worksapce/gpio_study/Debug/gpio_study.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
