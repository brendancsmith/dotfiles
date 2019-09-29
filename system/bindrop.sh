#!/usr/bin/env bash

cd "$(dirname $0)"/../bin

# symlink executables to /usr/local/bin
find . -type f -perm -a=x | while read executable
do
    target="/usr/local/bin/$(basename ${executable})"
    source="$(pwd)/$(basename ${executable})"
    ln -s "$source" "$target" 2> /dev/null
    if [ $? -eq 0 ]; then echo "Created link $target -> $source"; fi
done
