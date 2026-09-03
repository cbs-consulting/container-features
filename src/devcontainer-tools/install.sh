#!/usr/bin/env bash
# Installs the Dev Container CLI (@devcontainers/cli) as a global npm package.
# Accepts 'latest', 'none' (skip), or a pinned version.
set -e

echo "Activating feature 'devcontainer-tools'"

if ! command -v npm >/dev/null 2>&1; then
	echo "ERROR: npm was not found on PATH." >&2
	echo "       Add a Node.js feature (e.g. ghcr.io/devcontainers/features/node) before 'devcontainer-tools'." >&2
	exit 1
fi

# install_pkg <package-name> <version>
#   version == "none"   -> skip
#   version == "latest" -> npm install -g <package-name>
#   anything else       -> npm install -g <package-name>@<version>
install_pkg() {
	local name="$1" ver="$2"
	if [ "$ver" = "none" ] || [ -z "$ver" ]; then
		echo "Skipping ${name}"
		return 0
	fi
	if [ "$ver" = "latest" ]; then
		echo "Installing ${name} (latest)"
		npm install -g "${name}"
	else
		echo "Installing ${name}@${ver}"
		npm install -g "${name}@${ver}"
	fi
}

# Feature option 'cli' is exposed as CLI environment variable.
install_pkg "@devcontainers/cli" "${CLI:-latest}"

echo "Done."
