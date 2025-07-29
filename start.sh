#!/bin/bash

# === START LOG ===
echo "✅ start.sh is executing..." | tee /root/startup-log.txt

# === SYSTEM SETUP (Ubuntu 24.04 + Python 3.12) ===
apt update && apt install -y \
  curl git wget unzip ffmpeg nano zip \
  libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 \
  build-essential python3.12-venv python3.12-dev

# === SYMLINK python/pip TO 3.12 ===
update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# === ENSURE pip IS INSTALLED ===
curl -sS https://bootstrap.pypa.io/get-pip.py | python

# === COMFYUI SETUP IN /root ===
cd /root
if [ ! -d "ComfyUI" ]; then
  git clone https://github.com/comfyanonymous/ComfyUI.git
fi
cd ComfyUI

# === CREATE & ACTIVATE VENV ===
python3.12 -m venv venv
source venv/bin/activate

# === INSTALL DEPENDENCIES ===
pip install --upgrade pip
pip install jupyterlab
pip install -r requirements.txt
pip install xformers

# === CREATE REQUIRED FOLDERS ===
mkdir -p models/checkpoints
mkdir -p models/clip
mkdir -p models/controlnet
mkdir -p models/upscale_models
mkdir -p models/vae
mkdir -p input
mkdir -p output
mkdir -p custom_nodes

# === AUTO-DOWNLOAD MODELS ===
wget -O models/checkpoints/model1.safetensors "https://civitai.com/api/download/models/501240?type=Model&format=SafeTensor&size=full&fp=fp16"
wget -O models/checkpoints/model2.safetensors "https://civitai.com/api/download/models/983309?type=Model&format=SafeTensor&size=full&fp=fp32"
wget -O models/checkpoints/model3.safetensors "https://civitai.com/api/download/models/128078?type=Model&format=SafeTensor&size=pruned&fp=fp16"
wget -O models/checkpoints/model4.safetensors "https://civitai.com/api/download/models/143906?type=Model&format=SafeTensor&size=pruned&fp=fp16"
wget -O models/checkpoints/model5.safetensors "https://civitai.com/api/download/models/1941849?type=Model&format=SafeTensor&size=full&fp=fp32"
wget -O models/checkpoints/dreamshaper.safetensors "https://civitai.com/api/download/models/128713?type=Model&format=SafeTensor&size=pruned&fp=fp16"

# === LOG AND LAUNCH ===
echo "✅ All setup complete. Launching ComfyUI..." | tee -a /root/startup-log.txt
jupyter lab --port=8888 --no-browser --allow-root --NotebookApp.token='' &
python3 main.py --listen --port 8188
