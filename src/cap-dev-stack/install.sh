#!/usr/bin/env bash
# Installs SAP CAP development tools as global npm packages.
# Each option accepts 'latest', 'none' (skip), or a pinned version.
set -e

echo "Activating feature 'cap-dev-stack'"

if ! command -v npm >/dev/null 2>&1; then
	echo "ERROR: npm was not found on PATH." >&2
	echo "       Add a Node.js feature (e.g. ghcr.io/devcontainers/features/node) before 'cap-dev-stack'." >&2
	exit 1
fi

# install_pkg <package-name> <version>
#   version == "none"  -> skip
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

# Feature options are exposed as uppercased environment variables (cds-dk -> CDS_DK, ...).
install_pkg "@sap/cds-dk"                   "${CDS_DK:-latest}"
install_pkg "mbt"                           "${MBT:-latest}"
install_pkg "mta"                           "${MTA:-latest}"

echo "Done."
