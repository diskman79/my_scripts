import os
import random
import eyed3

# 遍历当前目录下所有mp3文件
for filename in os.listdir():
    if filename.endswith('.mp3'):
        prefix = filename[:3]
        # 如果文件名前三位是数字，则更新文件属性里的 #
        if prefix.isdigit():
            num = int(prefix)
            audiofile = eyed3.load(filename)
            audiofile.tag.track_num = num
            audiofile.tag.save()
            
            
        # 如果文件名前三位不是数字，则分配一个新的编号，更新文件属性里的 #
        else:
            new_num = random.randrange(1000)
            new_filename = f'{new_num:03d} {filename}'
            os.rename(filename, new_filename)
            print(f'将 {filename} 重命名为 {new_filename}，分配的新编号为 {new_num:03d}.')
            audiofile = eyed3.load(filename)
            audiofile.tag.track_num = new_num
            audiofile.tag.save()




        
