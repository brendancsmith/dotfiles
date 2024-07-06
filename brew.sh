#!/usr/bin/env sh

# -e: exit on error
# -u: exit on unset variables
set -eu

# install homebrew if not installed
install_homebrew

# install core packages
brew tap "homebrew/bundle"
brew bundle --file="${DOTFILES_DIR}/core.Brewfile"
