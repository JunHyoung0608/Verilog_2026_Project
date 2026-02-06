# Verilog_2026_Project


# tcl 만들기

```
# ==========================================================
# 1. USER CONFIGURATION SECTION
# ==========================================================
# EDIT THIS: Change to "tb_watch_bd.wcfg" or "tb_watch_data.wcfg"
set TARGET_WCFG "tb_watch_data.wcfg" 
set RUN_TIME "1000ns"

# ==========================================================
# 2. PATH RESOLUTION LOGIC
# ==========================================================
# Your project root seems to be D:/verilog/L00_stopwatch/L00_stopwatch
set PROJ_DIR [get_property directory [current_project]]
set FULL_PATH [file join $PROJ_DIR $TARGET_WCFG]

# Debug Info
puts "DEBUG: Project Directory is $PROJ_DIR"
puts "DEBUG: Target Waveform is $FULL_PATH"

# ==========================================================
# 3. SIMULATION CONTROL LOGIC
# ==========================================================
restart

# Close all existing waveform windows to refresh
while {[current_wave_config] != ""} {
    close_wave_config -force
}

# Check and Open the file
if { [file exists $FULL_PATH] } {
    open_wave_config $FULL_PATH
    puts "SUCCESS: Loaded [file tail $FULL_PATH]"
} else {
    # If the file is not in project root, search one level up just in case
    set PARENT_DIR [file dirname $PROJ_DIR]
    set ALT_PATH [file join $PARENT_DIR $TARGET_WCFG]
    
    if { [file exists $ALT_PATH] } {
        open_wave_config $ALT_PATH
        puts "SUCCESS: Loaded from parent directory: $ALT_PATH"
    } else {
        puts "ERROR: Cannot find '$TARGET_WCFG'. Please check the filename."
        create_wave_config 
        add_wave /
    }
}

run $RUN_TIME
```

- 