#!/bin/bash

# === SYSTEM SETUP (Ubuntu 24.04 already has Python 3.12) ===
apt update && apt install -y \
  curl git wget unzip ffmpeg nano zip \
  libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 \
  build-essential python3.12-venv python3.12-dev

# === SYMLINK python and pip TO 3.12 ===
update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# === ENSURE pip IS INSTALLED ===
curl -sS https://bootstrap.pypa.io/get-pip.py | python

# === JUPYTERLAB INSTALL ===
pip install jupyterlab
jupyter lab --port=8888 --no-browser --allow-root --NotebookApp.token='' &

# === COMFYUI SETUP ===
cd /workspace
if [ ! -d "ComfyUI" ]; then
  git clone https://github.com/comfyanonymous/ComfyUI.git
fi
cd ComfyUI

# === CREATE VENV WITH PYTHON 3.12 ===
python3.12 -m venv venv
source venv/bin/activate

# === INSTALL DEPENDENCIES IN VENV ===
pip install --upgrade pip
pip install -r requirements.txt
pip install xformers

# === CREATE MODEL FOLDER ===
mkdir -p models/checkpoints

# === AUTO-DOWNLOAD MODELS ===

# Realistic Vision v5.1
wget -O models/checkpoints/realisticVisionV51.safetensors https://civitai.com/api/download/models/131351

# Epic Realism v6
wget -O models/checkpoints/epicRealismV6.safetensors https://civitai.com/api/download/models/117277

# DreamShaper v8
wget -O models/checkpoints/dreamshaperV8.safetensors https://civitai.com/api/download/models/128713

# CyberRealistic v4
wget -O models/checkpoints/cyberRealisticV4.safetensors https://civitai.com/api/download/models/104694

# Stable Diffusion v1.5 (required base model)
wget -O models/checkpoints/sd15.safetensors https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors

# === LAUNCH COMFYUI ===
source venv/bin/activate
python3 main.py --listen --port 8188
