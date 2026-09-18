#!/usr/bin/env bash
# Installs the Cloud Foundry CLI from the official Cloud Foundry apt repository.
# Mirrors the original Dockerfile: add the signing key + apt source, then apt install cf<version>-cli.
set -e

# Feature options are exposed as uppercased environment variables (version -> VERSION).
VERSION="${VERSION:-8}"
SKIP_CF_ON_FAILURE="${SKIP_CF_ON_FAILURE:-true}"

echo "Activating feature 'btp-cli-tools' (cf${VERSION}-cli)"

export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y wget gnupg ca-certificates

# VERSION selects the apt package suffix: "8" -> cf8-cli, "7" -> cf7-cli.
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | gpg --dearmor -o /usr/share/keyrings/cli.cloudfoundry.org.gpg
echo "deb [signed-by=/usr/share/keyrings/cli.cloudfoundry.org.gpg] https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list

CF_INSTALLED=true
if ! apt-get update -y || ! apt-get install -y "cf${VERSION}-cli"; then
	if [ "${SKIP_CF_ON_FAILURE}" != "true" ]; then
		echo "ERROR: Cloud Foundry CLI installation failed." >&2
		exit 1
	fi
	echo "WARNING: Cloud Foundry CLI installation failed and will be skipped."
	echo "         One upstream example is https://github.com/cloudfoundry/cli/issues/3863."
	rm -f /etc/apt/sources.list.d/cloudfoundry-cli.list
	CF_INSTALLED=false
fi

# Clean up apt lists to keep the image layer small.
rm -rf /var/lib/apt/lists/*

if [ "${CF_INSTALLED}" = "true" ]; then
	echo "Done. Installed $(cf version)"
else
	echo "Done without installing the Cloud Foundry CLI."
fi

# Install CF CLI plugins if requested.
# PLUGINS is a comma-separated list, e.g. "multiapps,html5-plugin".
export CF_PLUGIN_HOME=/usr/local/share/cf-plugins
mkdir -p "${CF_PLUGIN_HOME}"

# Plugins are installed to a shared directory so all container users can use them.
if [ -n "${PLUGINS:-}" ] && [ "${CF_INSTALLED}" = "true" ]; then
	echo "WARNING: CF Community plugins are unreviewed third-party binaries."
	echo "         Plugin names resolve to the latest version published by the community repository."
	printf '%s\n' \
		"CF Community plugins installed here are unreviewed third-party binaries." \
		"Plugin names resolved to the latest version available when this image was built." \
		> "${CF_PLUGIN_HOME}/SOURCE-NOTICE"

	echo "Adding CF Community plugin repository..."
	cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org

	echo "Installing CF CLI plugins: ${PLUGINS}"
	IFS=',' read -ra PLUGIN_LIST <<< "${PLUGINS}"
	for plugin in "${PLUGIN_LIST[@]}"; do
		plugin="$(echo "$plugin" | tr -d '[:space:]')"
		[ -z "$plugin" ] && continue
		echo "Installing plugin: $plugin"
		cf install-plugin "$plugin" -r CF-Community -f
	done
elif [ -n "${PLUGINS:-}" ]; then
	echo "WARNING: Skipping CF CLI plugins because the Cloud Foundry CLI was not installed."
fi

# Build-installed plugins are shared but may only be changed by root.
chown -R root:root "${CF_PLUGIN_HOME}"
chmod -R u=rwX,go=rX "${CF_PLUGIN_HOME}"
