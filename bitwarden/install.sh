#!/bin/sh
#
# Bitwarden
#
# installs the bitwarden CLI and extracts secrets 

# Check for bitwarden cli

if test ! $(command -v bw) && test $(command -v brew)
then
  echo "  Installing bitwarden-cli for you."
  brew install bitwarden-cli
fi

if test -n $BITWARDEN_URL
then
  BITWARDEN_URL="https://bitwarden.app.janz.digital"
fi
bw config server "${BITWARDEN_URL}"

exit 0
