#!/bin/zsh
set -euo pipefail

repo_dir="${0:A:h:h}"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"

command -v brew >/dev/null || {
  print -u2 'Homebrew is required. Install it from https://brew.sh first.'
  exit 1
}

mkdir -p "$config_dir" "$HOME/.ssh/config.d"
ln -sfn "$repo_dir/zsh" "$config_dir/zsh"
ln -sfn "$repo_dir/ghostty" "$config_dir/ghostty"
ln -sfn "$repo_dir/starship/starship.toml" "$config_dir/starship.toml"
ln -sfn "$repo_dir/shell/zshrc" "$HOME/.zshrc"
ln -sfn "$repo_dir/shell/zprofile" "$HOME/.zprofile"
ln -sfn "$repo_dir/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$repo_dir/git/config" "$HOME/.gitconfig"
ln -sfn "$repo_dir/ssh/00-workstation.conf" "$HOME/.ssh/config.d/00-workstation.conf"

brew tap hashicorp/tap
brew trust --formula hashicorp/tap/terraform
brew bundle --file "$repo_dir/Brewfile"
"$repo_dir/vscode/install.sh"
git lfs install --skip-repo
uv python install 3.13 --default

# Keep JavaScript CLIs in a compatible, fnm-managed Node runtime. Bitwarden's
# current CLI requires Node 22/npm 10, so do not silently move this to latest.
eval "$(fnm env --shell zsh)"
fnm install 22
fnm default 22
fnm use 22
corepack disable 2>/dev/null || true
npm install --global pnpm@10.34.5 @bitwarden/cli@2026.8.0 mongosh@2.10.0

export PATH="/usr/local/opt/rustup/bin:$PATH"
rustup default stable

print 'Workstation packages, dotfile links, and VS Code profile are installed.'
print 'Put Git identity in ~/.gitconfig.local; never commit credentials.'
