#!/bin/sh

# System upgrades, wooh!
echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

dir="$(dirname $0)"

sh $dir/login-items.sh
sh $dir/dock.sh
sh $dir/hostname.sh
sh $dir/defaults.sh