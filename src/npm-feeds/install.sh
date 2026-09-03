#!/usr/bin/env bash
# Configures private npm registry feeds.
# Build time: writes scope→registry URL mappings to the global npm config.
# Post-create: a generated script appends auth token entries to ~/.npmrc.
set -e

echo "Activating feature 'npm-feeds'"

if ! command -v npm >/dev/null 2>&1; then
	echo "ERROR: npm was not found on PATH." >&2
	echo "       Add a Node.js feature (e.g. ghcr.io/devcontainers/features/node) before 'npm-feeds'." >&2
	exit 1
fi

# Feature options (feeds -> FEEDS, token-env-var -> TOKEN_ENV_VAR).
FEEDS="${FEEDS:-}"
FALLBACK_TOKEN_ENV_VAR="${TOKEN_ENV_VAR:-NPM_TOKEN}"

CONF_DIR=/usr/local/share/npm-feeds
mkdir -p "$CONF_DIR"

# Parse feeds and write scope→registry mappings to global npm config.
# Feed format: '@scope|registryUrl' or '@scope|registryUrl|TOKEN_VAR'
# Falls back to FALLBACK_TOKEN_ENV_VAR when TOKEN_VAR is omitted.
if [ -n "$FEEDS" ]; then
	IFS=';' read -ra FEED_LIST <<< "$FEEDS"
	for feed in "${FEED_LIST[@]}"; do
		feed="$(echo "$feed" | tr -d '[:space:]')"
		[ -z "$feed" ] && continue
		IFS='|' read -r scope url token_var <<< "$feed"
		if [ -z "$scope" ] || [ -z "$url" ]; then
			echo "WARNING: Skipping malformed feed entry (expected @scope|url or @scope|url|TOKEN_VAR): ${feed}" >&2
			continue
		fi
		# Use per-feed TOKEN_VAR if provided, otherwise fall back to global default.
		token_var="${token_var:-$FALLBACK_TOKEN_ENV_VAR}"
		echo "Configuring registry for ${scope}: ${url} (token from \$${token_var})"
		npm config set --global "${scope}:registry" "${url}"
		# Store scope, url, token_var for the post-create auth step (tab-separated).
		printf '%s\t%s\t%s\n' "${scope}" "${url}" "${token_var}" >> "$CONF_DIR/feeds.conf"
	done
fi

# Generate the post-create script that injects auth tokens at runtime.
cat > "$CONF_DIR/post-create.sh" << 'POSTCREATESCRIPT'
#!/usr/bin/env bash
# Appends npm auth token entries to ~/.npmrc for all configured private feeds.
# If a token env var is not set, prompts the user interactively (read -s).
# Run automatically at post-create time by the npm-feeds Dev Container Feature.

set -e

CONF_DIR=/usr/local/share/npm-feeds
FEEDS_CONF="$CONF_DIR/feeds.conf"
NPMRC="$HOME/.npmrc"

[ -f "$FEEDS_CONF" ] || exit 0

# npm stores registry credentials in its user config, so keep the file private
# and replace it atomically to avoid exposing partial writes.
umask 077
touch "$NPMRC"
chmod 600 "$NPMRC"

write_auth_token() {
	local auth_key="$1" token="$2" line temporary_file
	temporary_file="$(mktemp "${NPMRC}.XXXXXX")"

	while IFS= read -r line || [ -n "$line" ]; do
		case "$line" in
			"${auth_key}:_authToken="*) continue ;;
		esac
		printf '%s\n' "$line"
	done < "$NPMRC" > "$temporary_file"

	printf '%s:_authToken=%s\n' "$auth_key" "$token" >> "$temporary_file"
	chmod 600 "$temporary_file"
	mv "$temporary_file" "$NPMRC"
}

# Track which token vars we've already prompted for (one prompt per unique var).
declare -A prompted_tokens

while IFS=$'\t' read -r scope url token_var; do
	[ -z "$url" ] && continue

	token="${!token_var}"

	# If not set in env and not already prompted, ask interactively.
	if [ -z "$token" ]; then
		if [ -n "${prompted_tokens[$token_var]+x}" ]; then
			token="${prompted_tokens[$token_var]}"
		else
			echo ""
			echo "┌─────────────────────────────────────────────────────┐"
			echo "│  npm-feeds: token required                          │"
			echo "└─────────────────────────────────────────────────────┘"
			echo "  Feed  : ${scope}"
			echo "  Var   : \$${token_var}"
			echo ""
			read -r -s -p "  Enter PAT: " token < /dev/tty
			echo ""
			if [ -z "$token" ]; then
				echo "  ⚠ Skipped (no value entered). Run this script again to retry:"
				echo "    bash /usr/local/share/npm-feeds/post-create.sh"
				prompted_tokens[$token_var]=""
				continue
			fi
			prompted_tokens[$token_var]="$token"
		fi
	fi

	[ -z "$token" ] && continue

	# Auth key is the registry URL stripped of its protocol (npm convention).
	auth_key="${url#https:}"
	auth_key="${auth_key#http:}"
	# Ensure trailing slash.
	auth_key="${auth_key%/}/"

	write_auth_token "$auth_key" "$token"
	echo "  ✓ Auth configured for ${scope}"
done < "$FEEDS_CONF"

echo ""
echo "npm-feeds: done."
POSTCREATESCRIPT

chmod +x "$CONF_DIR/post-create.sh"
echo "Done."
