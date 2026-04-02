import serial
import numpy as np
import cv2

# --- 설정 (FPGA와 반드시 일치시켜야 함) ---
PORT = 'COM8'
BAUD = 9600
WIDTH = 80
HEIGHT = 60
IMG_SIZE = WIDTH * HEIGHT
HEADER = b'\xAA\x55'  # 프레임 시작을 알리는 헤더 (2바이트)

def main():
    try:
        py_serial = serial.Serial(port=PORT, baudrate=BAUD, timeout=1)
        print(f"연결 성공: {PORT} @ {BAUD}")
        print("헤더 동기화 대기 중...")

        while True:
            # 1. 헤더 찾기: 버퍼에서 HEADER가 나올 때까지 1바이트씩 읽음
            # 이 과정이 있어야 화면이 옆으로 밀리는 현상이 사라집니다.
            if py_serial.in_waiting >= len(HEADER):
                if py_serial.read(1) == b'\xAA':
                    if py_serial.read(1) == b'\x55':
                        # 헤더를 찾았으므로 이제 IMG_SIZE만큼 데이터를 읽음
                        # 데이터가 다 들어올 때까지 잠시 대기 (timeout 설정 덕분에 안전)
                        raw_data = py_serial.read(IMG_SIZE)
                        
                        if len(raw_data) == IMG_SIZE:
                            # 2. 넘파이 배열 변환
                            img_array = np.frombuffer(raw_data, dtype=np.uint8).reshape((HEIGHT, WIDTH))

                            # 3. 화면 표시용 확대 (INTER_NEAREST로 선명하게)
                            display_img = cv2.resize(img_array, (WIDTH*8, HEIGHT*8), interpolation=cv2.INTER_NEAREST)

                            # 4. 출력
                            cv2.imshow("FPGA Real-time Image (Sync)", display_img)
                        else:
                            print("데이터 유실 발생: 프레임 크기가 맞지 않습니다.")

            # 'q' 키를 누르면 종료
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    except Exception as e:
        print(f"에러 발생: {e}")
    finally:
        if 'py_serial' in locals() and py_serial.is_open:
            py_serial.close()
        cv2.destroyAllWindows()

if __name__ == "__main__":
    main()