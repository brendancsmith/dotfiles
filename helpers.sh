#!/usr/bin/env sh

RED = "0;31"
BLUE = "0;34"

log_color() {
  color_code="$1"
  shift

  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_task() {
  log_color "$BLUE" "$@"
}

log_manual_action() {
  log_color "$RED" "⚠️" "$@"
}

log_error() {
  log_color "$RED" "❌" "$@"
}

error() {
  log_error "$@"
  exit 1
}

sudo() {
  # shellcheck disable=SC2312
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    if ! command sudo --non-interactive true 2>/dev/null; then
      log_manual_action "Root privileges are required, please enter your password below"
      command sudo --validate
    fi
    command sudo "$@"
  fi
}
