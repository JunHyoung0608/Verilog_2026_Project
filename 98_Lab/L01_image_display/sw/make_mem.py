from PIL import Image
import os

def image_to_mem(image_path, output_file):
    # 1. 이미지 열기 및 그레이스케일 변환
    img = Image.open(image_path).convert('L') 
    
    # 2. 해상도 조절 (160x120)
    img = img.resize((80, 60))
    pixels = list(img.getdata()) # 0~255 값의 리스트
    
    with open(output_file, 'w') as f:
        # 3. 4개 픽셀(8-bit x 4)을 하나의 32-bit Word로 패킹
        # 32-bit Word 하나에 [Pixel3][Pixel2][Pixel1][Pixel0] 순서로 배치
        for i in range(0, len(pixels), 4):
            p0 = pixels[i]
            p1 = pixels[i+1] if i+1 < len(pixels) else 0
            p2 = pixels[i+2] if i+2 < len(pixels) else 0
            p3 = pixels[i+3] if i+3 < len(pixels) else 0
            
            # 16진수 8자리 문자열로 변환 (32-bit)
            word = (p3 << 24) | (p2 << 16) | (p1 << 8) | p0
            f.write(f"{word:08X}\n")

    print(f"변환 완료: {output_file} (Total {len(pixels)//4} words)")

# input 
file_name = 'image4'

# 실행
current_path = os.path.dirname(os.path.abspath(__file__))

src_file = os.path.join(current_path, 'src_image', file_name + '.jpg')
mem_file = os.path.join(current_path, 'mem_image', file_name + '.mem')

image_to_mem(src_file, mem_file)