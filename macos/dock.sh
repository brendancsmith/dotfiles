#!/usr/bin/env bash
###### Setup Dock Items #####

read -p "Reset the dock icons? [y/N]" -n 1 -r input
if ! [[ "$input" =~ ^[Yy]$ ]] ; then exit 0; fi

# Wipe all (default) app icons from the Dock
dockutil --remove all --no-restart

# Add favorite applications
dockutil --add '/Applications/Google Chrome.app' --no-restart
dockutil --add '/Applications/Spotify.app' --no-restart
dockutil --add '/Applications/Visual Studio Code.app' --no-restart
dockutil --add '/Applications/iTerm 2.app' --no-restart
dockutil --add '/Applications/Todoist.app' --no-restart

# Add a spacer
# dockutil --add '' --type spacer --section apps --no-restart

# Add favorite folders
dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
dockutil --add '~/Downloads' --view fan --display stack --sort dateadded --no-restart

killall Dock
