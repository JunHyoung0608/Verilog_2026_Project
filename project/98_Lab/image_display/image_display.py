import serial
import numpy as np
import cv2

# --- 설정 (FPGA 설정과 동일하게 맞추세요) ---
PORT = 'COM4'         # Windows: 'COMx', Linux/Mac: '/dev/ttyUSBx'
BAUD = 115200         # 보레이트
WIDTH = 80            # 이미지 가로
HEIGHT = 60           # 이미지 세로
IMG_SIZE = WIDTH * HEIGHT  # 총 4800 바이트

def main():
    try:
        # UART 포트 열기
        py_serial = serial.Serial(port=PORT, baudrate=BAUD, timeout=1)
        print(f"연결 성공: {PORT} @ {BAUD}")

        while True:
            # 1. 이미지 한 장 분량의 데이터가 쌓일 때까지 대기
            if py_serial.in_waiting >= IMG_SIZE:
                # 2. 데이터 읽기
                raw_data = py_serial.read(IMG_SIZE)
                
                # 3. 1차원 바이트 데이터를 2차원 넘파이 행렬로 변환 (8-bit Gray Scale)
                # 만약 FPGA에서 RGB 데이터를 보낸다면 shape를 (HEIGHT, WIDTH, 3)으로 수정해야 함
                img_array = np.frombuffer(raw_data, dtype=np.uint8).reshape((HEIGHT, WIDTH))

                # 4. 화면 표시를 위해 크기 키우기 (80x60은 너무 작으므로 8배 확대)
                display_img = cv2.resize(img_array, (WIDTH*8, HEIGHT*8), interpolation=cv2.INTER_NEAREST)

                # 5. OpenCV 창에 출력
                cv2.imshow("FPGA Real-time Image", display_img)

            # 'q' 키를 누르면 종료
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    except Exception as e:
        print(f"에러 발생: {e}")
    finally:
        py_serial.close()
        cv2.destroyAllWindows()

if __name__ == "__main__":
    main()