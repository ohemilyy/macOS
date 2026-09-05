# Lunar Ops macOS workstation

Reproducible, credential-free configuration for an infrastructure engineering
Mac. The repository intentionally excludes SSH keys, host inventories,
kubeconfigs, cloud credentials, tokens, and Tailscale state.

## Install

1. Install Homebrew and the current Xcode Command Line Tools.
2. Review `Brewfile` and `bootstrap/macos.sh`.
3. Run `./bootstrap/macos.sh`.
4. Put personal Git identity in `~/.gitconfig.local`.
5. Authenticate `gh`, `az`, `aws`, `bw`, and PowerShell modules interactively as needed.

The bootstrap installs a user-local Python 3.13 through `uv`. It pins Node 22
because the current Bitwarden CLI declares that engine requirement. pnpm,
Bitwarden CLI, and mongosh are installed into that fnm-managed runtime to avoid
forcing a second Homebrew Node source build on Intel macOS.

OpenTofu is the default behind the `tf` alias. Terraform remains installed and
explicit for existing repositories. No apply, destroy, force-push, pod-delete,
or remote infrastructure aliases are included.

## Layout

- `shell/`: minimal zsh entry points
- `zsh/`: modular environment, completion, aliases, functions, integrations
- `ghostty/`: readable lunar terminal theme and practical key bindings
- `starship/`: compact prompt with conspicuous production Kubernetes contexts
- `tmux/`: small, plugin-free configuration for persistent sessions
- `git/`: safe global defaults; identity stays in `~/.gitconfig.local`
- `ssh/`: non-secret macOS client defaults only
- `bootstrap/`: repeatable linking and package installation
