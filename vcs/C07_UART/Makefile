# ===== UVM Testbench Makefile =====
#vcs -full64 -sverilog -debug_access+all -ntb_opts uvm-1.2 -timescale=1ns/1ps -kdb -lca -o simv ./rtl/adder.sv ./tb/tb_adder.sv

#-------------------value---------------------
NAME		:= uart
TOP 		:= tb_top
TEST 		:= uart_tx_test
VERBOSITY 	:= UVM_DEBUG
SEED 		:= random

#-------------------file_name---------------------
DATE    := $(shell date +%y%m%d_%H%M%S)
INCLUDE := "\`include \"uvm_macros.svh\"\nimport uvm_pkg::*;\n"
SEQ     := "\`include \"tb_seq.svh\"\n"

FILE_LIST  	:= filelist.f
LOG_DIR 	:= ./logs
TAR_FILE 	:= uvm_format.tar.gz


#-------------------macro---------------------
COMP_OPTS := -full64 -sverilog -debug_access+all -kdb -lca -ntb_opts uvm-1.2 \
			-timescale=1ns/1ps \
			+incdir+./rtl \
			+incdir+./tb \
			-cm line+cond+fsm+tgl+branch+assert



SIM_OPTS := +UVM_TESTNAME=$(TEST) 
# 			+UVM_VERBOSITY=$(VERBOSITY)	\
# 			+ntb_random_seed=$(SEED) \
# 			-cm line+cond+fsm+tgl+branch+assert \
# 			-cm_dir coverage.vdb \
# 			-cm_name sim1

VERDI_OPTS := -dbdir simv.daidir -ssf novas.fsdb

init:
	mkdir -p rtl tb logs
	touch ./rtl/$(RTL_FILE).sv
	@printf "#RTL\n./rtl/$(NAME).sv\n\n#Testbench\n./tb/tb_$(NAME).sv\n" > $(FILE_LIST)
	@echo "1. 준비 중: 임시 폴더 생성 및 $(TAR_FILE) 해제"
	@mkdir -p ./temp_untar ./tb
	@tar -xzf ../$(TAR_FILE) -C	./temp_untar
	@echo "2. 파일명 및 내용 수정 중..."
	@for file in $$(ls ./temp_untar/*.sv); do \
		base=$$(basename $$file); \
		if [ "$$base" = "tb_.sv" ]; then \
			TARGET="./tb/tb_$(NAME).sv"; \
			mv $$file $$TARGET; \
			echo "  [Special Rename] $$base -> tb_$(NAME).sv"; \
		elif [[ "$$base" == _* ]]; then \
			TARGET="./tb/$(NAME)$$base"; \
			mv $$file $$TARGET; \
			echo "  [Rename] $$base -> $(NAME)$$base"; \
		else \
			TARGET="./tb/$$base"; \
			mv $$file $$TARGET; \
		fi; \
		\
		# 파일 내부의 'junbro' 문자열을 $(NAME)으로 치환 \
		if [ -f $$TARGET ]; then \
			sed -i 's/junbro/$(NAME)/g' $$TARGET; \
			echo "  [Content Update] 'junbro' -> '$(NAME)' in $$TARGET"; \
		fi \
	done

	@echo "3. 잔여 파일 정리..."
	@rm -rf ./temp_untar
	@echo "--------------------------------------------"
	@echo "완료: 모든 파일의 이름과 내부 내용($(NAME))이 업데이트되었습니다."
	@echo "--------------------------------------------"

comp:
	vcs $(COMP_OPTS) -f filelist.f -o simv
	@echo "타겟 컴파일 완료"
	
sim: comp
	@mkdir -p $(LOG_DIR)
	./simv $(SIM_OPTS) -l $(LOG_DIR)/$(TEST)_$(DATE).log
	@ln -sf $$PWD/$(LOG_DIR)/$(TEST)_$(DATE).log $(LOG_DIR)/latest.log
	@echo "로그 파일 저장 완료: $(LOG_DIR)/$(TEST)_$(DATE).log"
	@echo "최신 로그 연결: $(LOG_DIR)/latest.log"

verdi: sim
	verdi $(VERDI_OPTS) &

verdi_c: sim
	verdi -cov -covdir coverage.vdb &

clean:
	rm -rf simv* csrc *.log *.vpd *.fsdb *.key *.h DVE* *.fsdb navas* *.conf *LOG
	@echo "삭제 완료"


.PHONY: comp run clean init