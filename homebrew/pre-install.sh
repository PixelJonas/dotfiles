#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(command -v brew)
then
  echo "  Installing Homebrew for you."
  
  # On Ubuntu we need the "build-essential" package
  if test "$(command -v apt)" && test -z "$(dpkg -l build-essential)"
  then
    info "installing build-essential using apt"
    sudo apt update
    sudo apt install -y build-essential
  fi

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin" || test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    if test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
      eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    elif test "$(uname)" = "Darwin"
    then
      info "MacOS config not yet implemented"
    fi
    brew shellenv >> $DOTFILE_HOME/homebrew/homebrew.path.zsh
    brew bundle --file $DOTFILE_HOME/homebrew/Brewfile
  fi
fi

exit 0
