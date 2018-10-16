#!/usr/bin/env bash
#
# Run all dotfiles installers.

# short circuit on failures
set -e

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# allow for verbose output
if [ $1 -eq "-v" ]; then
    set -v
fi

pushd "$(dirname $0)"

# find the installers and run them iteratively
find . -name install.sh | while read installer
do
    module="$(basename ${installer})"
    sh -c "${installer}"
    if [ $? -eq 0 ]; then
        echo "${module} \e[32m✓"
    else
        echo "${module} \e[31m✗"
    fi
done

popd