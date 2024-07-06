#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

# ---- configurable environment varibles ----

DOTFILES_USER=${DOTFILES_USER:-"brendancsmith"}
DOTFILES_BRANCH=${DOTFILES_BRANCH:-"main"}

# ---- repo settings ----

DOTFILES_REPO_HOST=${DOTFILES_REPO_HOST:-"https://github.com"}
DOTFILES_REPO="${DOTFILES_REPO_HOST}/${DOTFILES_USER}/dotfiles"
export DOTFILES_DIR="${HOME}/.dotfiles"

# ---- colorized output ----

export RED="0;31"
export BLUE="0;34"

log_color() {
  color_code="$1"
  shift

  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}
export -f log_color

log_task() {
  log_color "$BLUE" "🔃" "$@"
}
export -f log_task

log_manual_action() {
  log_color "$RED" "⚠️" "$@"
}
export -f log_manual_action

log_error() {
  log_color "$RED" "❌" "$@"
}
export -f log_error

error() {
  log_error "$@"
  exit 1
}
export -f error

# ---- sudo with minimal prompts ----

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

# ---- install homebrew ----

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    log_task "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (
      echo
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
    ) >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}
export -f install_homebrew

# ---- operating system check & git install ----

if [ "$(uname)" = "Darwin" ]; then
  log_task "Running on macOS"
  if ! command -v git >/dev/null 2>&1; then
    log_task "Installing git"
    brew install git
  fi
elif [ "$(uname)" = "Linux" ]; then
  log_task "Running on Linux"
  sudo apt update --yes
  if ! command -v git >/dev/null 2>&1; then
    log_task "Installing git"
    brew install git
  fi
else
  error "Unsupported OS: $(uname)"
fi

# ---- fetch dotfiles ----

git_refresh() {
  path=$(realpath "$1")
  remote="$2"
  branch="$3"

  log_task "Cleaning '${path}' with '${remote}' at branch '${branch}'"
  git="git -C ${path}"
  # Ensure that the remote is set to the correct URL
  if ${git} remote | grep -q "^origin$"; then
    ${git} remote set-url origin "${remote}"
  else
    ${git} remote add origin "${remote}"
  fi
  ${git} checkout -B "${branch}"
  ${git} fetch origin "${branch}"
  ${git} reset --hard FETCH_HEAD
  ${git} clean -fdx
  unset path remote branch git
}

if [ -d "${DOTFILES_DIR}" ]; then
  git_refresh "${DOTFILES_DIR}" "${DOTFILES_REPO}" "${DOTFILES_BRANCH}"
else
  log_task "Cloning '${DOTFILES_REPO}' at branch '${DOTFILES_BRANCH}' to '${DOTFILES_DIR}'"
  git clone --branch "${DOTFILES_BRANCH}" "${DOTFILES_REPO}" "${DOTFILES_DIR}"
fi

# ---- run chezmoi ----

if [ -f "${DOTFILES_DIR}/chezmoi.sh" ]; then
  CHEZMOI_SCRIPT="${DOTFILES_DIR}/chezmoi.sh"
  log_task "Running '${CHEZMOI_SCRIPT}'"
  sh "${CHEZMOI_SCRIPT}" "$@"
else
  error "No chezmoi script found."
fi

# ---- install homebrew packages ----

if [ -f "${DOTFILES_DIR}/brew.sh" ]; then
  HOMEBREW_SCRIPT="${DOTFILES_DIR}/brew.sh"
  log_task "Running '${HOMEBREW_SCRIPT}'"
  "${HOMEBREW_SCRIPT}" "$@"
else
  error "No homebrew script found."
fi
