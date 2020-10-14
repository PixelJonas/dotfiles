#!/bin/sh
#
# ZSH
#
# This install zsh and oh-my-zsh if not already present

if test -n $(command -v brew); then
  echo "  Homebrew installed"

  if test ! -d ${ZSH:-~/.oh-my-zsh}; then
    echo "  Installing Oh-My-ZSH"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ${ZSH:-~/.oh-my-zsh}
  fi

  echo "Installing Oh-My-ZSH plugins"
  # Oh-My-ZSH
  # ZSH-Autosuggestions
  if test ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi
  # ZSH Syntax Highlighting
  if test ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi
  # zsh-you-should-use
  if test ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use; then
    git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
  fi
  # Powerlevel10k Theme
  if test ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  fi

fi

exit 0
