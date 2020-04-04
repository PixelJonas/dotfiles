#!/bin/sh
#
# Java | jEnv

# Check for bitwarden cli

if test ! $(command -v jenv) && test $(command -v brew); then
  echo "  Installing jenv for you."
  brew install jenv
  eval "$(jenv init -)"
  jenv enable-plugin maven
  jenv enable-plugin export
fi

exit 0
