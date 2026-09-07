# npm Private Feeds (npm-feeds)

Configures private npm registry feeds for a Dev Container.

- **Build time**: writes `@scope:registry=url` mappings to the global `.npmrc` so `npm install` resolves scoped packages from your private registry — no token needed.
- **Post-create time**: stores `_authToken` entries in `~/.npmrc` using the PAT from the env var you specify. Set that env var via `containerEnv`, a VS Code secret, or your own `postCreateCommand`.

Requires Node.js / npm. Add `ghcr.io/devcontainers/features/node` before this feature.

## Example Usage

### Single feed with a dedicated PAT

```jsonc
"features": {
    "ghcr.io/devcontainers/features/node:1": { "version": "lts" },
    "ghcr.io/cbs-consulting/container-features/npm-feeds:1": {
        "feeds": "@myorg|https://pkgs.dev.azure.com/org/_packaging/feed/npm/registry/|AZURE_DEVOPS_PAT"
    }
}
```

### Multiple feeds with separate PATs

```jsonc
"feeds": "@myorg|https://pkgs.dev.azure.com/org/_packaging/feed/npm/registry/|AZURE_PAT;@other|https://npm.example.com/|OTHER_PAT"
```

### Multiple feeds sharing one fallback PAT

Omit the token var from entries that should use the fallback:

```jsonc
"feeds": "@feed1|https://pkgs.dev.azure.com/org/_packaging/feed1/npm/registry/;@feed2|https://pkgs.dev.azure.com/org/_packaging/feed2/npm/registry/",
"token-env-var": "AZURE_DEVOPS_PAT"
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| feeds | Semicolon-separated feed entries. Format: `@scope\|registryUrl` or `@scope\|registryUrl\|TOKEN_VAR`. | string | |
| token-env-var | Fallback env var for feeds that do not specify their own `TOKEN_VAR`. | string | NPM_TOKEN |

## How auth works

The feature writes the registry URL mapping at image build time (no secret needed).

At post-create time it runs `/usr/local/share/npm-feeds/post-create.sh`:

1. For each feed, it checks if the designated token env var is set.
2. If set (e.g. via `containerEnv`), it uses it silently.
3. If **not** set, it **prompts interactively** in the VS Code terminal.
4. If the same env var covers multiple feeds, you are only prompted once.
5. If you skip a prompt, run the script again at any time: `bash /usr/local/share/npm-feeds/post-create.sh`

Re-running the script is safe — it updates existing entries rather than duplicating them.

## Credential storage

npm stores registry tokens as plaintext in its user configuration. This feature restricts `~/.npmrc` to the container user with mode `0600`, but processes running as that user or as root can still read it.

Use scoped, short-lived tokens with only the package permissions required. Revoke the token when the container is no longer trusted, and never commit or copy `~/.npmrc` into a project or container image.
