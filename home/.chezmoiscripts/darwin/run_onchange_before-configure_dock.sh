#!/bin/bash

set -eufo pipefail

trap 'killall Dock' EXIT


defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock largesize -float 80
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -float 70

declare -a remove_apps=(
	Launchpad
	Safari
	Messages
	Mail
	Maps
	Photos
	FaceTime
	Calendar
	Contacts
	Reminders
	Notes
	Freeform
	TV
	Music
	Keynote
	Numbers
	Pages
	"App Store"
)

for label in "${remove_apps[@]}"; do
	dockutil --no-restart --remove "${label}" 2>/dev/null || true
done

declare -a add_apps=(
  Arc
  "Spark Desktop:Spark"
  Superhuman
  "Things3:Things"
  Bear
  "Visual Studio Code:Code"
  Sourcetree
  Spotify
  /System/Applications/Calendar.app:Calendar
)


for tuple in "${add_apps[@]}"; do
  # if tuple contains a colon, split it into app and label
  if [[ "$tuple" =~ : ]]; then
    IFS=":" read -r app label <<< "$tuple"
  else
    app=$tuple
    label=$tuple
  fi

  # if app does not end in .app, assume it is in /Applications
  if [[ "${app}" != *.app ]]; then
    app="/Applications/${app}.app"
  fi

  dockutil --no-restart --remove "${label}" 2>/dev/null || true
  dockutil --no-restart --add "${app}" --label "${label}" 1>/dev/null || true
done

# dockutil --no-restart --add "${HOME}/Downloads" --replacing "Downloads" --view grid --display stack --sort dateadded || true
# dockutil --no-restart --replacing "/Applications" --replacing "Applications" --view grid --display folder --sort name || true
