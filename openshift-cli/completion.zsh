#!/usr/bin/env zsh
if command -v oc &>/dev/null; then
  _oc_bin="$(command -v oc)"
  _oc_completion_cache="${XDG_CACHE_HOME:-$HOME/.cache}/oc-completion.zsh"
  if [[ ! -s "$_oc_completion_cache" || "$_oc_bin" -nt "$_oc_completion_cache" ]]; then
    oc completion zsh > "$_oc_completion_cache"
  fi
  source "$_oc_completion_cache"
  unset _oc_bin _oc_completion_cache
fi
