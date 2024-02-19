#!/bin/sh
#
# Hyper.js https://hyper.is/
#
# installs the Hyper.js Terminal Emulator

if test ! $(command -v hyper) && test $(command -v brew); then
  echo "  Installing hyper for you."
  brew install --cask install hyper
fi

exit 0
