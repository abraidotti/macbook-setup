#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable smart quotes and smart dashes as they are annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Do not create .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Expand the save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Reverse swipe scroll direction the opposite of "natural"
# Only monsters like "natural" scrolling
defaults write -g com.apple.swipescrolldirection '0'

# Set trackpad & mouse speed
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

# Set dock items to 36 px
defaults write com.apple.dock tilesize -int 36

# Setting dock to auto-hide and remove auto-hide delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Set screenshot save location to ~/Desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Set screenshot format to PNG
defaults write com.apple.screencapture type -string "png"

# Setup Finder Commands
# Show Library Folder in Finder
chflags nohidden ~/Library

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show Hidden Files in Finder
defaults write com.apple.finder AppleShowAllFiles YES

# Show Path Bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show Status Bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Use column view in all Finder windows
defaults write com.apple.finder FXPreferredViewStyle Clmv

# Check for Homebrew, and then install it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebrew installed successfully"
else
    echo "Homebrew already installed!"
fi

# Install XCode Command Line Tools
echo 'Checking to see if XCode Command Line Tools are installed...'
brew config

# Updating Homebrew.
echo "Updating Homebrew..."
brew update

# Upgrade any already-installed formulae.
echo "Upgrading Homebrew..."
brew upgrade

brew install awscli
brew install git
brew install nmap
brew install node
brew install python3
brew install terraform
brew install trash
brew install tree
brew install wget
brew install yarn
brew install zsh

# Apps
apps=(
    adobe-acrobat-reader
    burp-suite
    docker
    firefox
    forticlient
    google-chrome
    google-drive-file-stream
    iterm2
    lastpass
    openvpn-connect
    postman
    slack
    spotify
    visual-studio-code
    zoom
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Git config"
git config --global user.name "Alessandro Braidotti"
git config --global user.email alessandro@kintyre.co

chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

# Update the Terminal
# Install oh-my-zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Need to logout now to start the new SHELL..."
logout

