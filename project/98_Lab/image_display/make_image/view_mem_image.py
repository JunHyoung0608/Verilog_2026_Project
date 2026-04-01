import numpy as np
from PIL import Image
import os

def show_mem_image(mem_path, width=80, height=60):
    if not os.path.exists(mem_path):
        print(f"에러: {mem_path} 파일을 찾을 수 없습니다.")
        return

    pixels = []
    
    with open(mem_path, 'r') as f:
        for line in f:
            # 16진수 문자열을 32-bit 정수로 변환
            try:
                word = int(line.strip(), 16)
            except ValueError:
                continue # 빈 줄이나 잘못된 형식 스킵
            
            # 32-bit Word 분해 (Little Endian: p0가 하위 8비트)
            # 파이썬 변환 코드에서 (p3<<24 | p2<<16 | p1<<8 | p0) 로 넣었으므로 동일하게 추출
            p0 = word & 0xFF
            p1 = (word >> 8) & 0xFF
            p2 = (word >> 16) & 0xFF
            p3 = (word >> 24) & 0xFF
            
            pixels.extend([p0, p1, p2, p3])

    # 데이터 크기 맞추기 (160 * 120 = 19,200)
    pixels = pixels[:width * height]
    
    # 리스트를 8-bit 정수 배열로 변환 및 형태(Shape) 재구성
    img_array = np.array(pixels, dtype=np.uint8).reshape((height, width))
    
    # 이미지를 생성하고 즉시 화면에 출력
    img = Image.fromarray(img_array, 'L')
    print("이미지를 띄웁니다...")
    img.show() 

# input
file_name = 'image4.mem'

# --- 경로 설정 및 실행 ---
# 스크립트 파일이 있는 폴더를 기준으로 경로 설정
current_path = os.path.dirname(os.path.abspath(__file__))
mem_file = os.path.join(current_path, 'mem_image', file_name)

show_mem_image(mem_file)