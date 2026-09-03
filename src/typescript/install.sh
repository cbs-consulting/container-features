#!/usr/bin/env bash
# Installs TypeScript and ts-node as global npm packages.
# Each option accepts 'latest', 'none' (skip), or a pinned version.
set -e

echo "Activating feature 'typescript'"

if ! command -v npm >/dev/null 2>&1; then
	echo "ERROR: npm was not found on PATH." >&2
	echo "       Add a Node.js feature (e.g. ghcr.io/devcontainers/features/node) before 'typescript'." >&2
	exit 1
fi

# install_pkg <package-name> <version>
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

# Feature options are exposed as uppercased environment variables.
# typescript -> TYPESCRIPT, ts-node -> TS_NODE
install_pkg "typescript" "${TYPESCRIPT:-latest}"
install_pkg "ts-node"    "${TS_NODE:-latest}"

echo "Done."
