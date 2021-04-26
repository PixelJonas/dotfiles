#!/usr/bin/env zsh
if test $(command -v kubectl 2>/dev/null); then
  source <(kubectl completion zsh)
fi
