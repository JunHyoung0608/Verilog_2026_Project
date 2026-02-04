# Verilog_2026_Project


# tcl 만들기

```
# 1. 시뮬레이션 초기화 (시간을 0ns로 되돌림)
restart

# 2. 현재 실행 중인 이 TCL 스크립트의 전체 경로를 가져옵니다.
# [info script] 명령어가 현재 파일의 위치와 이름을 알려줍니다.
set script_path [info script]

# 3. 파일 확장자를 .tcl에서 .wcfg로 변경합니다.
# string map을 사용하여 파일명 뒤의 확장자만 바꾼 경로를 만듭니다.
set wcfg_file [string map {.tcl .wcfg} $script_path]

# 4. 일치하는 .wcfg 파일이 실제로 존재하는지 확인합니다.
if { [file exists $wcfg_file] } {
    # 동일한 이름의 파일이 있으면 해당 설정을 파형 창에 불러옵니다.
    open_wave_config $wcfg_file
    puts "SUCCESS: Auto-matched and loaded [file tail $wcfg_file]"
} else {
    # 일치하는 파일이 없으면 새로 파형 창을 만들고 모든 최상위 신호를 추가합니다.
    if {[current_wave_config] == ""} { 
        create_wave_config 
    }
    add_wave /
    puts "INFO: No matching .wcfg found for [file tail $script_path]. Added default signals."
}

# 5. 시뮬레이션을 지정된 시간(1000ns) 동안 실행합니다.
run 1000ns
```

- 