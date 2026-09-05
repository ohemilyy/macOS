# Neptune

```text
                 _..._
             .-'     '-.
          .-'  .-"""-.  '-.
        .'    /       \\    '.
       /     |  ~ ~ ~  |     \\
      |       \\       /       |
       \\       '.___.'       /
        '.                 .'
          '-.           .-'
             '---------'
              N E P T U N E
```

## DevOps-flavored macOS dotfiles

A ready-to-go macOS setup for people who spend too much time in terminals,
YAML files, Kubernetes clusters, and VS Code.

These are my personal dotfiles, but they are intentionally kept portable and
free of credentials so anyone can clone them, tweak a few things, and make
themselves at home. You get a nice shell, a useful DevOps toolkit, sensible Git
defaults, and a customized VS Code setup without assembling everything from
scratch.

## A quick peek

![Full VS Code setup with the Catppuccin theme and custom background](screenshots/vscode.png)

![Closer look at the editor colors, typography, minimap, and background](screenshots/vscode-editor.png)

## What's included?

- A tidy Zsh setup with completions, aliases, and small quality-of-life helpers
- Ghostty, Starship, tmux, zoxide, fzf, bat, eza, ripgrep, and other terminal goodies
- Docker and Colima
- kubectl, Helm, k9s, kubectx, Stern, and kind
- OpenTofu, Terraform, Ansible, pre-commit, ShellCheck, and shfmt
- AWS, Azure, PowerShell, Go, Rust, Java, Python via `uv`, and Node via `fnm`
- Handy networking, security, and database tools
- VS Code settings, a big extension pack, Catppuccin styling, and a custom wallpaper

Nothing here automatically applies infrastructure, deletes clusters, force
pushes branches, or does other exciting career-limiting things.

## Quick start

You will need macOS, an internet connection, and an administrator account.
Install Apple's command-line tools first:

```bash
xcode-select --install
```

Then install [Homebrew](https://brew.sh), clone this repo, and start the guided
setup:

```bash
git clone https://github.com/ohemilyy/neptune.git ~/dotfiles
cd ~/dotfiles
./bootstrap/macos.sh
```

The installer asks what you actually want. Docker, Kubernetes, infrastructure
tools, language runtimes, cloud CLIs, databases, networking tools, and the VS
Code profile can all be selected separately. AWS and Azure are off by default.
It can also set your Git name and email without adding them to this repository.

Existing config files are moved into a timestamped backup folder before the
dotfile links are created. It is fine to run the installer again later.

Prefer fewer questions? There are a few shortcuts:

```bash
./bootstrap/macos.sh --yes      # recommended defaults
./bootstrap/macos.sh --minimal  # shell, Git, and core CLI tools
./bootstrap/macos.sh --all      # the whole toolbox
```

The root `Brewfile` remains available if you prefer a traditional full
`brew bundle` install.

> [!TIP]
> Have a look through `Brewfile` and `bootstrap/macos.sh` before running them.
> Fork the repo and remove anything you do not want—dotfiles should feel like
> yours, not like a mysterious appliance.

## Just want the VS Code setup?

If VS Code is already installed, you can restore only the editor settings,
extensions, and wallpaper:

```bash
git clone https://github.com/ohemilyy/neptune.git ~/dotfiles
cd ~/dotfiles
./vscode/install.sh
```

The custom background extension may ask for administrator access the first time
it patches VS Code. After installation, run **Developer: Reload Window** from
the Command Palette if the wallpaper does not appear right away.

## A couple of personal bits you still need to add

Secrets and machine-specific data do not belong in this repo. You will still
need to:

- Put your Git name and email in `~/.gitconfig.local`
- Sign in to tools such as `gh`, `aws`, and `az` if you chose to install them
- Add your own SSH keys, host aliases, kubeconfigs, cloud credentials, and Tailscale login

For example:

```gitconfig
[user]
    name = Your Name
    email = you@example.com
```

## What's where?

```text
bootstrap/   the main macOS setup script
git/         safe Git defaults (no personal identity)
ghostty/     terminal theme and key bindings
shell/       small .zshrc and .zprofile entry points
ssh/         non-secret macOS SSH client defaults
starship/    prompt configuration
tmux/        lightweight tmux configuration
vscode/      editor settings, extensions, wallpaper, and installer
zsh/         aliases, functions, completions, and integrations
```

## Notes for fellow tinkerers

- Python 3.13 is installed through `uv`.
- Node 22 is managed by `fnm`; it is pinned for compatibility with the included CLIs.
- The `tf` alias uses OpenTofu. Terraform is also installed for projects that need it.
- Database packages are clients only and are not started as background services.
- The prompt makes production Kubernetes contexts intentionally hard to miss.

## Credits

The VS Code settings are based on the setup by
[AndyReckt](https://github.com/andyreckt). Thanks for sharing it! 💜

Steal what you like, delete what you do not, and make something cozy. ✨
