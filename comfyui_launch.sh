#!/bin/bash

echo "✅ comfyui_launch.sh is executing..." | tee /root/comfyui-launch-log.txt

cd /root/ComfyUI
if [ -d "venv" ]; then
  echo "🚀 Launching ComfyUI..."
  nohup ./venv/bin/python main.py --listen --port 8188 > /root/comfyui.log 2>&1 &
  echo "✅ ComfyUI running in background. Check /root/comfyui.log for details."
else
  echo "❌ ComfyUI venv not found! Run comfyui_setup.sh first."
fi
