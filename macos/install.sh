if test ! "$(uname)" = "Darwin"; then
  exit 0
fi

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

echo "› Applying macOS defaults"
bash "$(dirname "$0")/set-defaults.sh"
echo "› macOS defaults applied (some changes require logout to take effect)"
