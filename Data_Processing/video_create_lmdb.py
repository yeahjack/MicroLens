import os
import lmdb
import pickle
import cv2
import numpy as np

# 视频文件夹路径
video_folder = '/hpc2hdd/home/yxu409/MicroLens/Dataset/Microlens-50k/MicroLens-50k_videos/'

# LMDB数据库路径
lmdb_path = '/hpc2hdd/home/yxu409/MicroLens/Dataset/Microlens-50k/MicroLens-50k_videos_lmdb/'

# 视频帧数
frame_no = 5

# 创建LMDB环境
env = lmdb.open(lmdb_path, map_size=1099511627776)

class LMDB_VIDEO:
    def __init__(self, video):
        self.video = video.tobytes()

# 遍历视频文件夹
with env.begin(write=True) as txn:
    for filename in os.listdir(video_folder):
        if filename.endswith('.mp4'):
            video_path = os.path.join(video_folder, filename)
            
            # 读取视频
            cap = cv2.VideoCapture(video_path)
            
            # 获取视频总帧数
            total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
            
            # 计算要提取的帧的索引
            frame_indices = [int(i * (total_frames - 1) / (frame_no - 1)) for i in range(frame_no)]
            
            # 提取指定帧并转换为NumPy数组
            frames = []
            for index in frame_indices:
                cap.set(cv2.CAP_PROP_POS_FRAMES, index)
                ret, frame = cap.read()
                if ret:
                    frame = cv2.resize(frame, (224, 224))
                    frame = frame.transpose((2, 0, 1))
                    frames.append(frame)
            
            # 释放视频资源
            cap.release()
            
            # 将提取的帧转换为字节对象
            video_data = pickle.dumps(LMDB_VIDEO(np.array(frames, dtype=np.float32)))
            
            # 将数据存储到LMDB数据库中,使用视频文件名作为键
            txn.put(filename.encode(), video_data)

# 关闭LMDB环境
env.close()