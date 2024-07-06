#!/usr/bin/env sh

/bin/bash "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap homebrew/bundle

brew bundle
