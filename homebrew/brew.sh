#!/bin/sh

# install core packages
echo "Installing core packages via homebrew"
brew bundle --file="$(dirname $0)/core.Brewfile"

echo "Install software bundles via homebrew (y/N)? \c"
read resp

if ! [ "$resp" != "${resp#[Yy]}" ] ;then
    exit 0
fi

#TODO: use select statements with ALL and EXIT options,
#      then move core.Brewfile into bundles/
# find the domain-specific Brewfiles and run them iteratively
for brewfile in bundles/*Brewfile; do
    bundle="$(basename ${brewfile})"

    echo "Install packages from ${bundle} (y/N)? \c"
    read resp

    if [ "$resp" != "${resp#[Yy]}" ] ;then
        brew bundle --file="${brewfile}"
    fi
done