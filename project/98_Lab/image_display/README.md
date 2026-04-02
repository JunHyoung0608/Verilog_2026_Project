# 🚀 RV32I Processor: Image Streaming Project (Basys3)

Basys3 FPGA 보드를 활용하여 **RV32I (RISC-V)** 명령 집합 기반의 CPU를 직접 설계하고, 내부 메모리(BRAM)의 이미지 데이터를 UART를 통해 PC로 실시간 전송 및 시각화하는 프로젝트입니다.

---

## 📌 프로젝트 개요
* **Target Board:** Digilent Basys3 (Artix-7 FPGA)
* **Architecture:** RV32I (32-bit RISC-V Base Integer Instruction Set)
* **Main Goal:** CPU가 BRAM의 데이터를 읽어 UART 포트로 송신하고, PC에서 OpenCV로 복원 및 출력
* **Operating Frequency:** 100MHz (sys_clk_pin)

## 🛠 하드웨어 구성 (Hardware)
### 1. CPU Core
- **Single-Cycle Data Path:** 한 클럭에 하나의 명령어를 수행하는 구조.
- **Instruction Support:** 기본 정수 연산, 분기(Branch), 메모리 로드/스토어 지원.
- **Memory Map:** - `0x1000_1000`: Image File (BRAM) - 80x60 Gray-scale 데이터 저장.
    - `0x2000_4000`: UART Peripheral - 전송 상태 체크 및 데이터 송신.

### 2. UART Peripheral
- 8-bit 데이터 전송, 1 Stop bit, No Parity.
- **Baudrate:** 115200 bps.

## 💻 소프트웨어 구성 (Software)
### 1. Firmware (C Language)
- **Header Sync:** 데이터 밀림 방지를 위해 프레임 시작 시 `0xAA`, `0x55` 헤더 송신.
- **Data Handling:** 32-bit 워드로 저장된 이미지 데이터를 8-bit 픽셀 단위로 쪼개어 연속 전송.
- **Optimization:** CPU 타이밍 부하를 줄이기 위해 곱셈 대신 시프트 연산(`<<`) 사용.

### 2. PC Client (Python & OpenCV)
- 시리얼 포트로부터 수신된 Raw 데이터를 80x60 넘파이 배열로 재구성.
- `cv2.imshow`를 통해 실시간 모니터링 창 출력 (8배 확대 시각화).

## 📈 타이밍 최적화 (Timing Issues & Solution)
프로젝트 진행 중 **-1.024ns의 Negative Slack**이 발생하여 이를 해결하기 위해 다음을 적용했습니다.

1. **Fanout 제어:** `(* max_fanout = 50 *)` 어트리뷰트를 적용하여 PC(Program Counter) 레지스터의 신호 부하 분산.
2. **파이프라인 레지스터 추가:** `instr_addr` 출력 단계에 지연 레지스터(`o_pc_delay`)를 삽입하여 크리티컬 패스 분리.
3. **결과:** 타이밍 마진을 확보하여 Basys3 보드에서 안정적으로 데이터 전송 확인.

## 📂 폴더 구조
- `/src`: Verilog CPU 코어 및 주변장치 RTL 소스
- `/firmware`: RISC-V GCC로 컴파일된 C 소스 코드
- `/python`: PC용 시각화 클라이언트 스크립트
- `/docs`: Vivado 타이밍 리포트 및 회로도(Schematic)

---

## 📸 실행 결과
- **해상도:** 80 x 60 Gray-scale
- **표시:** PC 측 OpenCV 창에서 실시간으로 FPGA 내부 메모리 이미지 확인 가능
- **하드웨어 제어:** Basys3 보드의 스위치(SW) 조작에 따라 전송할 이미지 주소 변경 기능 구현