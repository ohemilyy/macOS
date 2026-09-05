mkcd() {
  [[ $# -eq 1 ]] || { print -u2 'usage: mkcd DIRECTORY'; return 2; }
  mkdir -p -- "$1" && cd -- "$1"
}

# Fuzzy-switch Git branches without changing Git's underlying commands.
gbrowse() {
  (( $+commands[fzf] )) || { print -u2 'fzf is not installed'; return 1; }
  local branch
  branch=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads |
    fzf --prompt='branch> ' --preview='git log --color=always --oneline -12 {}') || return
  git switch "$branch"
}

# Read-only Kubernetes resource picker; no delete/apply shortcuts are provided.
kpods() {
  (( $+commands[fzf] )) || { kubectl get pods "$@"; return; }
  kubectl get pods "$@" --no-headers |
    fzf --header-lines=0 --prompt='pod> ' --preview='kubectl describe pod {1}'
}
