# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\project_2026\Verilog_2026_Project\04_Vitis_IDE\N01_GPIO_fnd_upcounter\worksapce\design_1_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\project_2026\Verilog_2026_Project\04_Vitis_IDE\N01_GPIO_fnd_upcounter\worksapce\design_1_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {D:\project_2026\Verilog_2026_Project\04_Vitis_IDE\N01_GPIO_fnd_upcounter\XSA\design_1_wrapper.xsa}\
-fsbl-target {psu_cortexa53_0} -out {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/worksapce}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {design_1_wrapper}
platform generate -quick
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {design_1_wrapper}
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/project_2026/Verilog_2026_Project/04_Vitis_IDE/N01_GPIO_fnd_upcounter/XSA/design_1_wrapper.xsa}
platform generate -domains 
