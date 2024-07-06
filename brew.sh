#!/usr/bin/env sh

# -e: exit on error
# -u: exit on unset variables
set -eu

# install core packages
brew tap "homebrew/bundle"
brew bundle --file="${DOTFILES_DIR}/core.Brewfile"
