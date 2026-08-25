#!/usr/bin/env zsh
if command -v kubectl &>/dev/null; then
  _kubectl_bin="$(command -v kubectl)"
  _kubectl_completion_cache="${XDG_CACHE_HOME:-$HOME/.cache}/kubectl-completion.zsh"
  if [[ ! -s "$_kubectl_completion_cache" || "$_kubectl_bin" -nt "$_kubectl_completion_cache" ]]; then
    kubectl completion zsh > "$_kubectl_completion_cache"
  fi
  source "$_kubectl_completion_cache"
  unset _kubectl_bin _kubectl_completion_cache
fi
