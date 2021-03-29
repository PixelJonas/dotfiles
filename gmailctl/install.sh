#!/bin/sh
#
# gmailctl

# Check for gmailctl cli


if test ! $(command -v gmailctl) && test $(command -v gmailctl); then
  echo "  Installing gmailctl for you."
  brew install gmailctl
fi
export DOTFILE_HOME=$HOME/.dotfiles

if test ! -d "$HOME/.gmailctl"; then
    echo "Creating .gmailctl dir"
    mkdir -p "$HOME/.gmailctl"
    echo "Linking gmailctl config"
    ln -s "${DOTFILE_HOME}/gmailctl/config.jsonnet" "$HOME/.gmailctl/config.jsonnet"
  fi

exit 0
