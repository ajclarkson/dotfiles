#!/usr/bin/env bash
set -e

echo "Show the ~/Library folder in Finder"
chflags nohidden ~/Library

echo "Enable full keyboard access for all controls"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Enable automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo "Show Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1

echo "Set a shorter Delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "Disable smart quotes and dashes"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "Set date display in menu bar"
defaults write com.apple.menuextra.clock "DateFormat" "EEE MMM d  H.mm"

echo "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Hide recent applications from dock"
defaults write com.apple.dock show-recents -bool false

echo "Only show active apps in dock"
defaults write com.apple.dock static-only -bool true

echo "Disable CMD+space for spotlight"
/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c "Set AppleSymbolicHotKeys:64:enabled false"

for app in "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" &> /dev/null
done

echo "Done! Some changes may require a logout to take effect."
