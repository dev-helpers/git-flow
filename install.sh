#!/usr/bin/env bash
set -euo pipefail

GIT_FLOW="git-flow"
REPO="dev-helpers/${GIT_FLOW}"
BASE_RAW="https://raw.githubusercontent.com/${REPO}/main/scripts"

SYSTEM_BIN_PATH="/usr/local/bin/${GIT_FLOW}"
USER_BIN_PATH="${HOME}/.git-flow/bin/${GIT_FLOW}"

BIN_PATH="${SYSTEM_BIN_PATH}"
USE_SUDO=false
CONFIG_ALIAS=true

error() { printf '❌ Error: %s\n' "$1" >&2; exit 1; }

platform="unix"
case "${OSTYPE:-}" in
	msys*|cygwin*|win32*)
		platform="windows-bash"
		;;
	*)
		;;
esac

if [[ "${platform}" == "unix" ]]; then
	uname_s="$(uname -s 2>/dev/null || true)"
	case "${uname_s}" in
		MINGW*|MSYS*|CYGWIN*)
			platform="windows-bash"
			;;
		*)
			;;
	esac
fi

if [[ "${platform}" == "windows-bash" ]]; then
	BIN_PATH="${USER_BIN_PATH}"
elif [[ -d "/usr/local/bin" && -w "/usr/local/bin" ]]; then
	BIN_PATH="${SYSTEM_BIN_PATH}"
elif command -v sudo >/dev/null 2>&1; then
	BIN_PATH="${SYSTEM_BIN_PATH}"
	USE_SUDO=true
else
	BIN_PATH="${USER_BIN_PATH}"
fi

echo "→ Installing or updating ${GIT_FLOW}…"

if ! command -v curl >/dev/null 2>&1; then
	error "curl is not installed. Please install curl first."
fi

PARENT_DIR="$(dirname "${BIN_PATH}")"

if [[ "${USE_SUDO}" == true ]]; then
	if ! sudo mkdir -p "${PARENT_DIR}"; then
		error "Failed to create directory '${PARENT_DIR}'"
	fi

	if ! sudo curl -fsSL "${BASE_RAW}/${GIT_FLOW}" -o "${BIN_PATH}"; then
		error "Failed to download ${BASE_RAW}/${GIT_FLOW} using sudo."
	fi

	if ! sudo chmod +x "${BIN_PATH}"; then
		error "Failed to change permissions for ${BIN_PATH}"
	fi
else
	if ! mkdir -p "${PARENT_DIR}"; then
		error "Failed to create directory '${PARENT_DIR}'"
	fi

	if ! curl -fsSL "${BASE_RAW}/${GIT_FLOW}" -o "${BIN_PATH}"; then
		error "Failed to download ${BASE_RAW}/${GIT_FLOW}"
	fi

	if ! chmod +x "${BIN_PATH}"; then
		error "Failed to change permissions for ${BIN_PATH}"
	fi
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

if [[ "${CONFIG_ALIAS}" = true ]]; then
	git config --global alias.flow     "!\"${BIN_PATH}\""
	git config --global alias.sync     "!\"${BIN_PATH}\" sync"
	git config --global alias.feature  "!\"${BIN_PATH}\" feature"
	git config --global alias.feat     "!\"${BIN_PATH}\" feature"
	git config --global alias.hotfix   "!\"${BIN_PATH}\" hotfix"
	git config --global alias.bugfix   "!\"${BIN_PATH}\" bugfix"
	git config --global alias.fix      "!\"${BIN_PATH}\" bugfix"
	git config --global alias.propose  "!\"${BIN_PATH}\" propose"
	git config --global alias.pr       "!\"${BIN_PATH}\" propose"
fi

echo
echo "→ Binary installed at: ${BIN_PATH}"
echo

"${BIN_PATH}" --help || echo "⚠️ Failed to show help — try running '${BIN_PATH} --help' manually."

echo
echo "✔ Installation / update complete!"
