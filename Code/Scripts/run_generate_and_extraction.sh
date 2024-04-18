source ~/micromamba/pkgs/python-3.11.8-h955ad1f_0/lib/python3.11/venv/scripts/common/activate microlens

cd /hpc2hdd/home/yxu409/MicroLens/MicroLens/Data_Processing

python generate_cover_frames_lmdb.py

python "video_feature_extraction_(from_lmdb).py"