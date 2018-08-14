#!/usr/bin/env bash
##### Set Hostnames #####

read -p "Set the computer hostnames? [y/N]" -n 1 -r input
if ! [[ input =~ ^[Yy]$ ]] ; then exit 0; fi

# Set computer name (as done via System Preferences → Sharing)
read -p "Enter new hostname: " VAR_NAME
read -p "Hostname will be '${VAR_NAME}'. Press enter to continue."
sudo scutil --set ComputerName "${VAR_NAME}"
sudo scutil --set HostName "${VAR_NAME}"
sudo scutil --set LocalHostName "${VAR_NAME}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${VAR_NAME}"
