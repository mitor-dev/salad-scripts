#!/bin/bash

echo "✅ comfyui_launch.sh is executing..." | tee /root/comfyui-launch-log.txt

cd /root/ComfyUI

# === Start ComfyUI ===
if [ -d "venv" ]; then
  echo "🚀 Launching ComfyUI on port 8188..."
  
  # Start in foreground to keep container running
  ./venv/bin/python main.py --listen --port 8188

  # If ComfyUI crashes, script ends here — container can restart depending on policy
else
  echo "❌ ComfyUI venv not found! Run comfyui_setup.sh first."
  exit 1
fi

# === Run extra command ONLY IF provided, and prevent repetition ===
if [ $# -gt 0 ]; then
  echo "⚙️ Running extra command: $@"
  exec "$@"
fi
