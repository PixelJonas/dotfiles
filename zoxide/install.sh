#!/bin/sh
#
# Zoixide | z
# fzf | fzf

# Check for commands

if test ! $(command -v fzf) || test ! $(command -v zoxide) && test $(command -v brew); then
  echo "  Installing zoixide and fzf for you."
  brew install zoxide fzf
fi