#!/usr/bin/env bash

export SRC_DIR="${1:-.}"
export DEST_DIR="${2:-.}"

function __confirm () {
    local TEXT="$(echo ${1} | sed 's/\?$//g')"
    local PROMPT="$TEXT [y/N]? "
    read -e -p "$PROMPT"
    [[ "$REPLY" == [Yy]* ]]
    return $?
}
export -f __confirm

function __op () {
    local FILE="$1"
    local FILENAME="$(basename $FILE)"
    echo "$FILE  ->  $DEST_DIR/$FILENAME"
    mv -i "$FILE" "$DEST_DIR/"
}
export -f __op

find "$SRC_DIR" -type f -print0 | parallel -0 __op {}

if [ $? -eq 0 ]; then
    __confirm "Delete ${SRC_DIR}?" && rm -r "$SRC_DIR"
fi
