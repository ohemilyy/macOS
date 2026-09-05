#!/bin/bash
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
jetbrains_dir="$repo_dir/jetbrains"
support_dir="$HOME/Library/Application Support/JetBrains"
toolbox_state="$support_dir/Toolbox/state.json"
asset_dir="$HOME/.config/jetbrains"

launcher=""
candidates=()

if [[ -f "$toolbox_state" ]]; then
    while IFS= read -r line; do
        candidates+=("$line")
    done < <(sed -n 's/.*"launchCommand": "\(.*\/idea\)".*/\1/p' "$toolbox_state")
fi

candidates+=(
    "$HOME/Applications"/*.app/Contents/MacOS/idea
    "$HOME/Applications/JetBrains Toolbox"/*.app/Contents/MacOS/idea
    /Applications/*.app/Contents/MacOS/idea
)

for candidate in "${candidates[@]}"; do
    [[ -x "$candidate" ]] && launcher="$candidate" && break
done

if [[ -z "$launcher" ]]; then
    echo "IntelliJ IDEA not found. Install it (JetBrains Toolbox or the cask) and run this again." >&2
    exit 1
fi

if pgrep -qf "$launcher"; then
    echo "Quit IntelliJ IDEA first, or it will overwrite these settings when it exits." >&2
    exit 1
fi

echo "Using $launcher"

while IFS= read -r plugin; do
    [[ -z "$plugin" ]] && continue
    "$launcher" installPlugins "$plugin" || echo "skipped $plugin (already bundled, or unavailable for this edition)"
done < "$jetbrains_dir/plugins.txt"

config_dir=""
for candidate in "$support_dir"/IntelliJIdea*; do
    [[ -d "$candidate" ]] && config_dir="$candidate"
done

if [[ -z "$config_dir" ]]; then
    echo "Plugins installed. Launch IntelliJ IDEA once, then run this again to apply the settings."
    exit 0
fi

mkdir -p "$config_dir/options" "$asset_dir"
cp "$jetbrains_dir/options"/*.xml "$config_dir/options/"

wallpaper_dir="${JETBRAINS_WALLPAPER_DIR:-$jetbrains_dir/backgrounds}"
wallpaper="$(find "$wallpaper_dir" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) 2>/dev/null | sort -R | sed -n '1p' || true)"

if [[ -z "$wallpaper" ]]; then
    echo "No images in $wallpaper_dir, skipping the background." >&2
    exit 1
fi

echo "Picked $wallpaper"
cp "$wallpaper" "$asset_dir/background.png"

background="$asset_dir/background.png,15,scale,center"
other="$config_dir/options/other.xml"

if [[ ! -f "$other" ]]; then
    cat > "$other" <<XML
<application>
  <component name="PropertyService"><![CDATA[{
  "keyToString": {
    "idea.background.editor": "$background"
  }
}]]></component>
</application>
XML
elif grep -q '"idea.background.editor"' "$other"; then
    sed -i '' "s|\"idea.background.editor\": \"[^\"]*\"|\"idea.background.editor\": \"$background\"|" "$other"
else
    sed -i '' "s|\"keyToString\": {|\"keyToString\": {\\
    \"idea.background.editor\": \"$background\",|" "$other"
fi

echo "IntelliJ IDEA plugins, theme, and background restored. Restart the IDE to load them."
