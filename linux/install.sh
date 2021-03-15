if test ! "$(uname)" = "Linux"; then
  exit 0
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# since there is no support for homebrew-casks we install some packages via 
# "apt" for Ubuntu or the "*.deb" packages included in this repo
cd "$(dirname "$0")/.."
DOTFILE_HOME=$(pwd -P)

if test ! $(command -v hyper); then
  echo "Installing Hyper.JS"
  curl -vsSL https://releases.hyper.is/download/deb > "${DOTFILE_HOME}/linux/hyper.deb"
  sudo dpkg -i "${DOTFILE_HOME}/linux/hyper.deb"
  rm "${DOTFILE_HOME}/linux/hyper.deb"
fi

if test ! $(command -v code); then
  echo "Installing Visual Studio Code"
  curl -vsSL https://go.microsoft.com/fwlink/?LinkID=760868 > "${DOTFILE_HOME}/linux/vscode.deb"
  sudo apt install "${DOTFILE_HOME}/linux/vscode.deb"
  rm "${DOTFILE_HOME}/linux/vscode.deb"
  cp "${DOTFILE_HOME}/vscode/settings.json" "${HOME}/.config/Code/User/settings.json"
fi

if test ! $(command -v ferdi); then
  echo "Installing Ferdi"
  curl -vsSL https://github.com/getferdi/ferdi/releases/download/v5.5.0/ferdi_5.5.0_amd64.deb > "${DOTFILE_HOME}/linux/ferdi.deb"
  sudo apt install "${DOTFILE_HOME}/linux/ferdi.deb"
  rm "${DOTFILE_HOME}/linux/ferdi.deb"
fi

if test ! -d "$HOME/.local/share/fonts"; then
  echo "Installing Powerline Fonts"
  git clone https://github.com/powerline/fonts.git --depth=1 "${DOTFILE_HOME}/linux/fonts"
  "${DOTFILE_HOME}/linux/fonts/install.sh"
  rm -rf "${DOTFILE_HOME}/linux/fonts"
fi

if test ! $(command -v zsh); then
  echo "Installing ZSH"
  sudo apt --fix-broken install
  sudo apt install zsh
fi

# Configure KDE
kwriteconfig5 --file $HOME/.config/kwinrc --group Windows --key BorderlessMaximizedWindows false

#set titlebar buttons
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key BorderSize "Normal"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "MF"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key CloseOnDoubleClickOnMenu "false"
kwriteconfig5 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ShowToolTips "false"

# keyboard settings
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key KeyboardRepeating "0"
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key NumLock "2"
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key RepeatDelay "300"
kwriteconfig5 --file $HOME/.config/kcminputrc --group Keyboard --key RepeatRate "40"

# disable restoring of desktop sessions
kwriteconfig5 --file $HOME/.config/ksmserverrc --group General --key loginMode "default"

# setup desktop panels
