#!/bin/bash
#SBATCH -p i64m1tga800u  # 申请的分区计算资源
#SBATCH -J wandbVideo     # 作业名称
#SBATCH --ntasks-per-node=64 # 每个计算节点上运行 task 的数量
#SBATCH --gres=gpu:8
#SBATCH  -n 64   # -n: 任务运行多少核;也可以通过-N 来指定申请的节点，如2个节点，就可以用-N 2来指定;
#SBATCH -o logs/%j.out   # 作业运行log输出文件
#SBATCH -e logs/%j.err   # 作业错误信息log输出文件
#SBATCH -o logs/%j.out   # 作业运行log输出文件
#SBATCH -x gpu1-31

# 设置Micromamba相关的环境变量
source ~/micromamba/pkgs/python-3.11.8-h955ad1f_0/lib/python3.11/venv/scripts/common/activate microlens
export HF_ENDPOINT=https://hf-mirror.com
export OMP_NUM_THREADS=16
export WANDB_API_KEY="2c7aa527aff528bc3f677d4e6b0cf189163d5dea"
wandb login
cd /hpc2hdd/home/yxu409/MicroLens/MicroLens/Code/VideoRec/SASRec

wandb agent weiyuguo/MicroLens-Code_VideoRec_SASRec/ircujy7l

