#!/bin/bash

echo "✅ comfyui_launch.sh is executing..." | tee /root/comfyui-launch-log.txt

cd /root/ComfyUI
if [ -d "venv" ]; then
  echo "🚀 Launching ComfyUI..."
  exec ./venv/bin/python main.py --listen --port 8188
else
  echo "❌ ComfyUI venv not found! Run comfyui_setup.sh first."
fi
