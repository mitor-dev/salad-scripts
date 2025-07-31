#!/bin/bash

echo "✅ comfyui_setup.sh is executing..." | tee /root/comfyui-setup-log.txt

# === SYSTEM SETUP ===
apt-get update && apt-get install -y \
  curl git unzip ffmpeg nano zip \
  libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 \
  build-essential python3.12-venv python3.12-dev

# === PYTHON & PIP SETUP ===
update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
curl -sS https://bootstrap.pypa.io/get-pip.py | python

# === CLONE COMFYUI ===
cd /root
if [ ! -d "ComfyUI" ]; then
  git clone https://github.com/comfyanonymous/ComfyUI.git
fi
cd ComfyUI

# === VENV SETUP FOR COMFYUI ===
if [ ! -d "venv" ]; then
  python3.12 -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
  pip install xformers
fi

# === CREATE FOLDERS ===
mkdir -p models/checkpoints models/clip models/controlnet models/upscale_models models/vae input output custom_nodes

# === MODEL DOWNLOAD FUNCTION ===
download_model() {
  local name="$1"
  local url="$2"
  local file="models/checkpoints/${name}.safetensors"
  if [ ! -f "$file" ]; then
    echo "⬇️ Downloading: $name"
    curl -L -o "$file" "$url" || echo "❌ Failed to download $name"
  else
    echo "✅ $name already present. Skipping."
  fi
}

# === DOWNLOAD MODELS ===
download_model "RealisticVisionV60B1_v51HyperVAE" "https://civitai.com/api/download/models/501240?type=Model&format=SafeTensor&size=full&fp=fp16"

echo "✅ comfyui_setup.sh complete."
