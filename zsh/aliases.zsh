# Small, memorable interactive conveniences. Scripts do not load these aliases.
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -lah --group-directories-first --icons=auto --git'
  alias la='eza -a --group-directories-first --icons=auto'
  alias lt='eza --tree --level=2 --group-directories-first --icons=auto'
else
  alias ll='ls -lah'
  alias la='ls -A'
fi

(( $+commands[bat] )) && alias bcat='bat --paging=never --style=plain'
alias rgi='rg --hidden --glob=!.git'

alias gs='git status --short --branch'
alias gl='git log --graph --decorate --oneline --all -20'
alias gb='git branch --sort=-committerdate'

alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
alias di='docker images'
alias dc='docker compose'

alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kl='kubectl logs'

alias ports='lsof -nP -iTCP -sTCP:LISTEN'
alias localip='ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1'
alias publicip='curl --fail --silent --show-error https://ifconfig.me/ip; echo'
alias dns='dig +short'
alias dfh='df -h'
alias duh='du -h -d 1'
alias procs='ps aux'
alias brews='brew update && brew outdated'
