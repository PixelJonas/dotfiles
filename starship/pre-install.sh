#!/usr/bin/env bash
# Install starship prompt (used as SSH/minimal terminal fallback)

if command -v starship &>/dev/null; then
  exit 0
fi

if command -v brew &>/dev/null; then
  brew install starship
elif command -v apt-get &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi
