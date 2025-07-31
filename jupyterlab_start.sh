#!/bin/bash

echo "✅ jupyterlab_start.sh is executing..." | tee /root/jupyterlab-log.txt

# === CREATE VENV IF NEEDED ===
cd /root
if [ ! -d "jupyterenv/venv" ]; then
  echo "🔧 Creating venv for JupyterLab..."
  python3.12 -m venv /root/jupyterenv/venv
  source /root/jupyterenv/venv/bin/activate
  pip install --upgrade pip
  pip install jupyterlab
else
  echo "✅ Existing JupyterLab venv found."
fi

# === LAUNCH JUPYTERLAB ===
echo "🚀 Launching JupyterLab on port 8888..."
/root/jupyterenv/venv/bin/jupyter lab --port=8888 --no-browser --allow-root --NotebookApp.token=''
