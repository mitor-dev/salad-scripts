#!/bin/bash

echo "✅ jupyterlab_start.sh is executing..." | tee /root/jupyterlab-log.txt

# === CREATE OR FIX VENV ===
cd /root
if [ ! -d "jupyterenv/venv" ]; then
  echo "🔧 Creating venv for JupyterLab..."
  python3.12 -m venv /root/jupyterenv/venv
  source /root/jupyterenv/venv/bin/activate
  pip install --upgrade pip
  pip install jupyterlab
else
  echo "✅ Existing JupyterLab venv found."

  # Check if jupyter binary exists
  if [ ! -f "/root/jupyterenv/venv/bin/jupyter" ]; then
    echo "❌ jupyter binary not found. Reinstalling JupyterLab..."
    source /root/jupyterenv/venv/bin/activate
    pip install --upgrade pip
    pip install jupyterlab
  fi
fi

# === RUN NEXT SCRIPT IF PASSED ===
exec "$@"
