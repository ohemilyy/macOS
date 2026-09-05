# Environment shared by interactive zsh sessions. Never put secrets here.
export LANG="${LANG:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"
export EDITOR="${EDITOR:-code --wait}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-less}"
export LESS="-FRX"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--height=45% --layout=reverse --border=rounded --info=inline --prompt='◌ ' --pointer='◆' --marker='◇' --color=bg+:#1e2030,bg:#0b1020,spinner:#82aaff,hl:#c099ff,fg:#c8d3f5,header:#86e1fc,info:#636da6,pointer:#ffc777,marker:#c3e88d,fg+:#ffffff,prompt:#82aaff,hl+:#c099ff"

# Prefer Homebrew client tools without starting their optional servers.
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
path=(/usr/local/bin /usr/local/sbin $path)
[[ -d /usr/local/opt/rustup/bin ]] && path=(/usr/local/opt/rustup/bin $path)
[[ -d /usr/local/opt/libpq/bin ]] && path=(/usr/local/opt/libpq/bin $path)
[[ -d /usr/local/opt/openjdk/bin ]] && path=(/usr/local/opt/openjdk/bin $path)
typeset -U path PATH
