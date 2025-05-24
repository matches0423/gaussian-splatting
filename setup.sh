#!/bin/bash

# source /home/user/miniconda3/etc/profile.d/conda.sh

# https://github.com/graphdeco-inria/gaussian-splatting/issues/923
if ! grep "#include <float.h>" submodules/simple-knn/simple_knn.cu > /dev/null 2>&1; then
    echo "Please include \"float.h\" header in submodules/simple-knn/simple_knn.cu"
    exit 1
fi

conda env remove -y -n gaussian_splatting

conda create -y -n gaussian_splatting python=3.9

if conda activate gaussian_splatting; then

    conda install -y "numpy<2"

    conda install -y "cuda-toolkit=12.8" -c nvidia

    pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128

    conda install -y plyfile -c conda-forge

    conda install -y tqdm

    export CUDA_HOME=/usr/local/cuda-12.8

    pip install submodules/diff-gaussian-rasterization

    pip install submodules/simple-knn

    pip install submodules/fused-ssim

    pip install opencv-python

    pip install joblib

fi
