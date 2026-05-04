# Sets reasonable macOS defaults.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a really fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct annoyances
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# Trackpad                                                                    #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Always open everything in Finder's list view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Show hidden files and all extensions
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Show path bar, status bar, and POSIX path in title
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "ShowStatusBar" -bool "true"
defaults write com.apple.finder "_FXShowPosixPathInTitle" -bool "true"

# Search current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# Don't warn when changing file extensions
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Auto-remove items from Trash after 30 days
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

# Use home directory as default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show external drives and removable media on Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

killall Finder

###############################################################################
# Dock                                                                        #
###############################################################################

defaults write com.apple.dock "tilesize" -int "36"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "show-recents" -bool "true"
defaults write com.apple.dock "scroll-to-open" -bool "true"
defaults write com.apple.dock "minimize-to-application" -bool "true"

# Run the screensaver if we're in the bottom-left hot corner
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

killall Dock

###############################################################################
# Screenshots                                                                 #
###############################################################################

mkdir -p "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture "location" -string "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture "type" -string "png"
defaults write com.apple.screencapture "disable-shadow" -bool true

###############################################################################
# Save & Print panels                                                         #
###############################################################################

# Expand save and print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

###############################################################################
# Misc UI                                                                     #
###############################################################################

# Faster window resize animation
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Don't write .DS_Store on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Reveal IP address, hostname, OS version etc. when clicking the clock in login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

killall SystemUIServer

###############################################################################
# Window Management                                                           #
###############################################################################

# Disable window snapping/tiling when dragging to the edges of the screen
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false

###############################################################################
# Safari (developer settings)                                                 #
###############################################################################

# These require Full Disk Access for the terminal — skip silently if unavailable
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true 2>/dev/null || true
defaults write com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null || true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true 2>/dev/null || true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true 2>/dev/null || true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
