#!/usr/bin/env sh

git_clean() {
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

DOTFILES_REPO_HOST=${DOTFILES_REPO_HOST:-"https://github.com"}
DOTFILES_USER=${DOTFILES_USER:-"$GITHUB_USER"}
DOTFILES_REPO="${DOTFILES_REPO_HOST}/${DOTFILES_USER}/dotfiles"
DOTFILES_BRANCH=${DOTFILES_BRANCH:-"master"}
DOTFILES_DIR="${HOME}/.dotfiles"

# check if on mac or linux
if [ "$(uname)" = "Darwin" ]; then
  log_task "Running on macOS"
  if ! command -v brew >/dev/null 2>&1; then
    log_task "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  if ! command -v git >/dev/null 2>&1; then
    log_task "Installing git"
    brew install git
  fi
elif [ "$(uname)" = "Linux" ]; then
  log_task "Running on Linux"
  if ! command -v git >/dev/null 2>&1; then
    log_task "Installing git"
    sudo apt update
  fi
else
  error "Unsupported OS: $(uname)"
fi

if ! command -v git >/dev/null 2>&1; then
  log_task "Installing git"
  sudo apt update --yes
  sudo apt install --yes --no-install-recommends git
fi

if [ -d "${DOTFILES_DIR}" ]; then
  git_clean "${DOTFILES_DIR}" "${DOTFILES_REPO}" "${DOTFILES_BRANCH}"
else
  log_task "Cloning '${DOTFILES_REPO}' at branch '${DOTFILES_BRANCH}' to '${DOTFILES_DIR}'"
  git clone --branch "${DOTFILES_BRANCH}" "${DOTFILES_REPO}" "${DOTFILES_DIR}"
fi
