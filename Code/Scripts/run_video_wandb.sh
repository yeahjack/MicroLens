#!/bin/bash

# 4card

# 设置Micromamba相关的环境变量
source ~/micromamba/pkgs/python-3.11.8-h955ad1f_0/lib/python3.11/venv/scripts/common/activate microlens
export HF_ENDPOINT=https://hf-mirror.com
export OMP_NUM_THREADS=16
export WANDB_API_KEY="2c7aa527aff528bc3f677d4e6b0cf189163d5dea"
wandb login
cd /hpc2hdd/home/yxu409/MicroLens/MicroLens/Code/VideoRec/SASRec

wandb agent weiyuguo/MicroLens-Code_VideoRec_SASRec/qnfs0nrs
