#!/usr/bin/env sh

# -e: exit on error
# -u: exit on unset variables
set -eu

# install homebrew if not installed
if ! command -v brew >/dev/null 2>&1; then
  log_task "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (
    echo
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  ) >>$HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install core packages
brew tap "homebrew/bundle"
brew bundle --file="${DOTFILES_DIR}/core.Brewfile"
