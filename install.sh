#!/usr/bin/env bash
set -euo pipefail

GIT_FLOW="git-flow"
REPO="dev-helpers/${GIT_FLOW}"
BASE_RAW="https://raw.githubusercontent.com/${REPO}/main/scripts"
BIN_PATH="/usr/local/bin/${GIT_FLOW}"
CONFIG_ALIAS=true

error() { printf '❌ Error: %s\n' "$1" >&2; exit 1; }

echo "→ Installing or updating ${GIT_FLOW}…"

if ! command -v curl >/dev/null 2>&1; then
  error "curl is not installed. Please install curl first."
fi

if ! sudo curl -fsSL "${BASE_RAW}/${GIT_FLOW}" -o "${BIN_PATH}"; then
  error "Failed to download ${BASE_RAW}/${GIT_FLOW} using sudo."
fi

if ! sudo chmod +x "${BIN_PATH}"; then
  error "Failed to change permissions for ${BIN_PATH}"
fi

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --no-alias)
      CONFIG_ALIAS=false
      shift
      ;;
    *)
      shift
      ;;
  esac
done

if [ "$CONFIG_ALIAS" = true ]; then
  git config --global alias.flow     "!${GIT_FLOW}"
  git config --global alias.sync     "!${GIT_FLOW} sync"
  git config --global alias.feature  "!${GIT_FLOW} feature"
  git config --global alias.hotfix   "!${GIT_FLOW} hotfix"
  git config --global alias.bugfix   "!${GIT_FLOW} bugfix"
  git config --global alias.propose  "!${GIT_FLOW} propose"
  git config --global alias.pr       "!${GIT_FLOW} propose"
fi

echo
echo "→ Binary installed at: ${BIN_PATH}"
echo

"${GIT_FLOW}" --help || echo "⚠️ Failed to show help — try running '${GIT_FLOW} --help' manually."

echo
echo "✔ Installation / update complete!"
