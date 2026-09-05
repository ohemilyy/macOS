# Show current Kubernetes target explicitly on demand before sensitive work.
kwhere() {
  local context namespace
  context=$(kubectl config current-context 2>/dev/null) || {
    print -u2 'No active Kubernetes context.'
    return 1
  }
  namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  [[ -n "$namespace" ]] || namespace=default
  if [[ "$context" == *prod* || "$context" == *prd* || "$context" == *production* ]]; then
    print -P "%F{red}%B⚠ PRODUCTION%b%f  context=%F{red}$context%f  namespace=%F{yellow}$namespace%f"
  else
    print -P "context=%F{blue}$context%f  namespace=%F{cyan}$namespace%f"
  fi
}

# OpenTofu is preferred for generic new work; Terraform remains explicit.
alias tf='tofu'
alias tfmt='tofu fmt'
alias tvalidate='tofu validate'
