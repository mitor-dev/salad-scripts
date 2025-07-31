#!/bin/bash

echo "✅ comfyui_launch.sh is executing..." | tee /root/comfyui-launch-log.txt

cd /root/ComfyUI
if [ -d "venv" ]; then
  echo "🚀 Launching ComfyUI..."
  ./venv/bin/python main.py --listen --port 8188 > /root/comfyui.log 2>&1 &
  echo "✅ ComfyUI running in background. Log: /root/comfyui.log"
else
  echo "❌ ComfyUI venv not found! Run comfyui_setup.sh first."
fi

# Optional: Run passed command to keep container alive or launch something else
exec "$@"
