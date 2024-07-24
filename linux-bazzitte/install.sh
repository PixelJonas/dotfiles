#! /usr/bin/env bash
# vim: set filetype=bash :

if test ! "$(uname)" = "Linux"; then
  echo "foo"
  exit 0
fi
# The Brewfile handles Homebrew-based app and library installs, but there may
# since there is no support for homebrew-casks we install some packages via the package manager
cd "$(dirname "$0")/.."
DOTFILE_HOME=$(pwd -P)

if test $(command -v ujust); then
    ujust toggle-user-motd
    echo "foo"
fi

# Flathub installation
if test $(command -v flatpak); then
    flatpak remote-add -u --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
    flatpak remote-modify -u --enable flathub
    flatpak update -u  --appstream
    flatpak update -u 

    flatpak install -u --noninteractive --assumeyes --or-update flathub \
        "com.github.tchx84.Flatseal" \
        "com.mattjakeman.ExtensionManager" \
        "org.freedesktop.Platform.ffmpeg-full" \
        "org.videolan.VLC" \
        "com.visualstudio.code"  \
        "com.discordapp.Discord" \
        "com.slack.Slack" \
        "org.virt_manager.virt-viewer" \
        "org.signal.Signal" \
        "org.openrgb.OpenRGB" \
        "md.obsidian.Obsidian" \
        "com.google.Chrome" \
        "com.spotify.Client"
fi

# dconf settings
if test $(command -v dconf); then
    dconf load / < "$(pwd)/d.conf"
fi