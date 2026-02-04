# 1. Reset simulation
restart

# 2. Get the current Tcl script's full path and name
# [info script] returns the path of the script currently being executed
set script_path [info script]

# 3. Change the extension from .tcl to .wcfg
set wcfg_file [string map {.tcl .wcfg} $script_path]
if {[current_wave_config] != ""} {
    close_sim_wave_config
}

# 4. Check if the matching .wcfg exists
if { [file exists $wcfg_file] } {
    # If the file exists, open it
    open_wave_config $wcfg_file
    puts "SUCCESS: Auto-matched and loaded [file tail $wcfg_file]"
} else {
    # If no matching file, create new and add all signals
    if {[current_wave_config] == ""} { 
        create_wave_config 
    }
    add_wave /
    puts "INFO: No matching .wcfg found for [file tail $script_path]. Added default signals."
}

# 5. Run simulation
run 1000ns