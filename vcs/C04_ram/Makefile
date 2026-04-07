# ===== UVM Testbench Makefile =====
#vcs -full64 -sverilog -debug_access+all -ntb_opts uvm-1.2 -timescale=1ns/1ps -kdb -lca -o simv ./rtl/adder.sv ./tb/tb_adder.sv

#-------------------value---------------------
TOP 		:= tb_top
TEST 		:= ram_test
VERBOSITY 	:= UVM_LOW
SEED 		:= random

#-------------------log---------------------
#LOG_TIME := $(shell date +%Y%m%d_%H%M%S)
LOG_FILE := sim_$(TEST).log


#-------------------macro---------------------
COMP_OPTS := -full64 -sverilog -debug_access+all -kdb -lca -ntb_opts uvm-1.2 \
			-timescale=1ns/1ps \
			+incdir+./rtl \
			+incdir+./tb \


SIM_OPTS := +UVM_TESTNAME=$(TEST) \
			+UVM_VERBOSITY=$(VERBOSITY)	\
			+ntb_random_seed=$(SEED)
comp:
	vcs $(COMP_OPTS) -f filelist.f -o simv
	@echo "타겟 컴파일 완료"
	
sim: comp
	./simv $(SIM_OPTS)
	@echo "로그 파일 저장 완료: logs/$(LOG_FILE)"
	@echo "의존타겟 [$<] 완료"
	@echo "타겟 [$@] 완료"

sim2:
	./simv $(SIM_OPTS) | tee logs/$(LOG_FILE)
	@echo "로그 파일 저장 완료: logs/$(LOG_FILE)"
	@echo "의존타겟 [$<] 완료"
	@echo "타겟 [$@] 완료"

clean:
	rm -rf simv* csrc *.log *.vpd *.fsdb *.key *.h DVE*
	@echo "삭제 완료"


.PHONY: comp run clean