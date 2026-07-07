#!/bin/sh
#
# mise | dev tool version manager

if ! command -v mise >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    echo "  Installing mise via Homebrew."
    brew install mise
  else
    echo "  Installing mise via install script."
    curl https://mise.run | sh
  fi
fi
