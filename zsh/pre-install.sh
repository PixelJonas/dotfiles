#!/bin/sh
#
# ZSH
#
# This install zsh and oh-my-zsh if not already present

if test -n $(command -v brew); then
  echo "  Homebrew installed"

  if test ! -d $HOME/.oh-my-zsh; then
    echo "  Installing Oh-My-ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" ""
  fi

  echo "Installing Oh-My-ZSH plugins"
  # ZSH-Autosuggestions
  if test ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi
  # ZSH Syntax Highlighting
  if test ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi

fi

exit 0
