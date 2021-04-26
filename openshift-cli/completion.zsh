#!/usr/bin/env zsh
if test $(command -v oc 2>/dev/null); then
  source <(oc completion zsh)
fi
