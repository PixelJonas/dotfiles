#!/usr/bin/env zsh
if test ! $(command -v oc); then
  source <(oc completion zsh)
fi
