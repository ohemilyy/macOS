#!/bin/bash
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
vscode_dir="$repo_dir/vscode"
user_dir="$HOME/Library/Application Support/Code/User"
asset_dir="$HOME/.config/vscode"

mkdir -p "$user_dir" "$asset_dir"
cp "$vscode_dir/settings.json" "$user_dir/settings.json"
cp "$vscode_dir/catppuccin-aurora.png" "$asset_dir/catppuccin-aurora.png"

while IFS= read -r extension; do
    [[ -z "$extension" || "$extension" == \#* ]] && continue
    code --install-extension "$extension" --force
done < "$vscode_dir/extensions.txt"

echo "VS Code settings, wallpaper, and extensions restored."

