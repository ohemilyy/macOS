# Native zsh completion with a daily cache rebuild.
if [[ -d /usr/local/share/zsh/site-functions ]]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
if [[ -d /usr/local/opt/rustup/share/zsh/site-functions ]]; then
  fpath=(/usr/local/opt/rustup/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit
zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${zcompdump:h}"
if [[ -n "$zcompdump"(#qN.mh+24) ]]; then
  compinit -d "$zcompdump"
else
  compinit -C -d "$zcompdump"
fi

setopt AUTO_MENU COMPLETE_IN_WORD ALWAYS_TO_END
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion"

# AWS and the HashiCorp-style CLIs expose external completion helpers.
if (( $+commands[aws_completer] || $+commands[terraform] || $+commands[tofu] )); then
  autoload -Uz bashcompinit && bashcompinit
fi
if (( $+commands[aws_completer] )); then
  complete -C aws_completer aws
fi
if (( $+commands[terraform] )); then
  complete -o nospace -C "$commands[terraform]" terraform
fi
if (( $+commands[tofu] )); then
  complete -o nospace -C "$commands[tofu]" tofu
fi
