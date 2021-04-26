#!/usr/bin/env zsh
if test ! $(command -v kubectl); then
  source <(kubectl completion zsh)
fi
