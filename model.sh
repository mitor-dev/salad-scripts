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
download_model "v1-5-pruned-emaonly_v15PrunedEmaonly" "https://civitai.com/api/download/models/66991?type=Model&format=SafeTensor&size=full&fp=fp16"
download_model "RealisticVisionV60B1_v51HyperVAE" "https://civitai.com/api/download/models/501240?type=Model&format=SafeTensor&size=full&fp=fp16"
download_model "SDXL_v10VAEFix" "https://civitai.com/api/download/models/128078?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "epiCRealism_naturalSinRC1VAE" "https://civitai.com/api/download/models/143906?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "DreamShaper_8" "https://civitai.com/api/download/models/128713?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "JuggernautXL_ragnarokBy" "https://civitai.com/api/download/models/1759168?type=Model&format=SafeTensor&size=full&fp=fp16"
download_model "AbsoluteReality_v181" "https://civitai.com/api/download/models/132760?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "HassakuXLIllustrious_v30" "https://civitai.com/api/download/models/2010753?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "CounterfeitXL_v25" "https://civitai.com/api/download/models/265012?type=Model&format=SafeTensor&size=pruned&fp=fp16"
download_model "MeinaMix_meinaV11" "https://civitai.com/api/download/models/119057?type=Model&format=SafeTensor&size=pruned&fp=fp16"
