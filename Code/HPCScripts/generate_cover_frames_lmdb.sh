#!/bin/bash
#SBATCH -p i64m512u   # 申请的分区计算资源
#SBATCH -J generate_cover_frames_lmdb     # 作业名称
#SBATCH --ntasks-per-node=64 # 每个计算节点上运行 task 的数量
#SBATCH  -n 64   # -n: 任务运行多少核;也可以通过-N 来指定申请的节点，如2个节点，就可以用-N 2来指定;
#SBATCH -o logs/%j.out   # 作业运行log输出文件
#SBATCH -e logs/%j.err   # 作业错误信息log输出文件

# 设置Micromamba相关的环境变量
source ~/micromamba/pkgs/python-3.11.8-h955ad1f_0/lib/python3.11/venv/scripts/common/activate microlens

cd /hpc2hdd/home/yxu409/MicroLens/MicroLens/Data_Processing

python generate_cover_frames_lmdb.py

