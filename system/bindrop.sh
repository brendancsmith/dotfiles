#!/usr/bin/env bash

cd "$(dirname $0)"/..

# symlink executables to /usr/local/bin
find bin -type f -perm -a=x | while read executable
do
    target="/usr/local/bin/$(basename $executable)"
    ln -s "$executable" "$target" 2> /dev/null
    if [ $? -eq 0 ]; then echo "Created link $target -> $executable"; fi
done