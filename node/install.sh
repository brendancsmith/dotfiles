#!/bin/sh

#TODO: use a package.json

if test ! $(which spoof)
then
  sudo npm install spoof -g
fi

if test ! $(which newman)
then
  sudo npm install newman -g
fi
