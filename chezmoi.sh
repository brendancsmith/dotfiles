#!/usr/bin/env sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! command -v chezmoi >/dev/null 2>&1; then
  brew install chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
# shellcheck disable=SC2312
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# exec: replace current process with chezmoi init
log_task "Running 'chezmoi $*'"
exec "chezmoi init --apply --source=${script_dir}"
