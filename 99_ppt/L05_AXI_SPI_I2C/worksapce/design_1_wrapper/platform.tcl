# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\Verilog_2026_Project\99_presentation\L05_Micro_Blaze_SPI_I2C\worksapce\design_1_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\Verilog_2026_Project\99_presentation\L05_Micro_Blaze_SPI_I2C\worksapce\design_1_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {D:\Verilog_2026_Project\99_presentation\L05_Micro_Blaze_SPI_I2C\XSA\design_1_wrapper.xsa}\
-fsbl-target {psu_cortexa53_0} -out {D:/Verilog_2026_Project/99_presentation/L05_Micro_Blaze_SPI_I2C/worksapce}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {design_1_wrapper}
platform generate -quick
platform generate
platform active {design_1_wrapper}
platform config -updatehw {D:/Verilog_2026_Project/99_presentation/L05_Micro_Blaze_SPI_I2C/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Verilog_2026_Project/99_presentation/L05_Micro_Blaze_SPI_I2C/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Verilog_2026_Project/99_presentation/L05_Micro_Blaze_SPI_I2C/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/Verilog_2026_Project/99_presentation/L05_Micro_Blaze_SPI_I2C/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/Verilog_2026_Project/99_ppt/L05_AXI_SPI_I2C/XSA/design_1_wrapper.xsa}
platform generate -domains 
