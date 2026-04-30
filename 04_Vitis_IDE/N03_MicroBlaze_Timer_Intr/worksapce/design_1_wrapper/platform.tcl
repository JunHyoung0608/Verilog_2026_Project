# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\Verilog_2026_Project\04_Vitis_IDE\N03_MicroBlaze_Timer_Intr\worksapce\design_1_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\Verilog_2026_Project\04_Vitis_IDE\N03_MicroBlaze_Timer_Intr\worksapce\design_1_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {D:\Verilog_2026_Project\04_Vitis_IDE\N03_MicroBlaze_Timer_Intr\XSA\design_1_wrapper.xsa}\
-fsbl-target {psu_cortexa53_0} -out {D:/Verilog_2026_Project/04_Vitis_IDE/N03_MicroBlaze_Timer_Intr/worksapce}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {design_1_wrapper}
platform generate -quick
platform generate
platform generate -domains standalone_microblaze_0 
platform config -updatehw {D:/Verilog_2026_Project/04_Vitis_IDE/N03_MicroBlaze_Timer_Intr/XSA/kim_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/Verilog_2026_Project/04_Vitis_IDE/N03_MicroBlaze_Timer_Intr/XSA/design_1_wrapper.xsa}
platform generate -domains 
