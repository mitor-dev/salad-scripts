#!/bin/bash

echo "✅ comfyui_setup.sh started..." | tee /root/comfyui-setup-log.txt

# === SYSTEM SETUP (Ubuntu 24.04 + Python 3.12) ===
apt-get update && apt-get install -y \
  curl git wget unzip ffmpeg nano zip \
  libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 \
  build-essential python3.12-venv python3.12-dev

# === SYMLINK python/pip TO 3.12 ===
update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# === ENSURE pip IS INSTALLED ===
curl -sS https://bootstrap.pypa.io/get-pip.py | python

# === COMFYUI SETUP ===
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
pip install jupyterlab             # ✅ RE-ADDED HERE
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

# === DOWNLOAD MODELS WITH SKIP & FALLBACK ===
function download_model() {
  NAME="$1"
  URL="$2"
  FILE="models/checkpoints/${NAME}.safetensors"
  if [ -f "$FILE" ]; then
    echo "✅ $NAME already exists. Skipping..."
  else
    echo "⬇️ Downloading $NAME..."
    if ! wget -O "$FILE" "$URL"; then
      echo "❌ Failed to download $NAME. Skipping..."
    else
      echo "✅ $NAME downloaded successfully."
    fi
  fi
}

# ✅ MODELS: Renamed with .safetensors
download_model "v1-5-pruned-emaonly_v15PrunedEmaonly" "https://civitai.com/api/download/models/66991?type=Model&format=SafeTensor&size=full&fp=fp16"
download_model "RealisticVisionV60B1_v51HyperVAE" "https://civitai.com/api/download/models/501240?type=Model&format=SafeTensor&size=full&fp=fp16"
download_model "epiCRealism_naturalSinRC1VAE" "https://civitai.com/api/download/models/143906?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "SDXL_v10VAEFix" "https://civitai.com/api/download/models/128078?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "DreamShaper_8" "https://civitai.com/api/download/models/128713?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "JuggernautXL_ragnarokBy" "https://civitai.com/api/download/models/1759168?type=Model&format=SafeTensor&size=full&fp=fp16"
download_model "AbsoluteReality_v181" "https://civitai.com/api/download/models/132760?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "HassakuXLIllustrious_v30" "https://civitai.com/api/download/models/2010753?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "CounterfeitXL_v25" "https://civitai.com/api/download/models/265012?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "MeinaMix_meinaV11" "https://civitai.com/api/download/models/119057?type=Model&format=SafeTensor&size=pruned&fp=fp16"

echo "✅ comfyui_setup.sh completed." | tee -a /root/comfyui-setup-log.txt
