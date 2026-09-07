# Fiori Dev Stack (fiori-dev-stack)

Installs SAP Fiori development tools as global npm packages. **Requires Node.js / npm** to be installed first
(use `ghcr.io/devcontainers/features/node` before this one).

Each package has its own version option that accepts:

- `latest` &mdash; install the latest version (default),
- `none` &mdash; skip the package,
- a specific version typed by hand (e.g. `1.14.0`).

`latest` is resolved when the container image is built, so rebuilding the same configuration can install newer versions. Pin the last working exact version if an update causes a problem or the toolchain must remain stable.

## Example Usage

```jsonc
"features": {
    "ghcr.io/devcontainers/features/node:1": {},
    "ghcr.io/cbs-group/container-features/fiori-dev-stack:1": {}
}
```

## Options

| Options Id | Package | Type | Default Value |
|-----|-----|-----|-----|
| yo | `yo` | string | latest |
| generator-fiori | `@sap/generator-fiori` | string | latest |

## OS Support

Any image where `npm` is available on `PATH`. Runs as `root` during the build.

## VS Code Customizations

This feature automatically installs the following when VS Code connects:

**Extensions:** `formulahendry.auto-rename-tag`, `SAPSE.sap-ux-fiori-tools-extension-pack`, `lokalise.i18n-ally`

**Settings** (project-specific paths like `i18n-ally.localesPaths` must be set in your own `devcontainer.json`):
- `i18n-ally.displayLanguage: "de"`
- `i18n-ally.enabledFrameworks: ["ui5"]`
- `i18n-ally.keystyle: "flat"`
- `i18n-ally.sourceLanguage: "de"`
- `i18n-ally.regex.usageMatchAppend` for `t('key')` pattern

**MCP servers** (add to your `devcontainer.json` `customizations.vscode.mcp`):
```jsonc
"ui5-mcp": { "command": "npx", "args": ["-y", "@ui5/mcp-server"], "type": "stdio" },
"fiori-mcp": { "command": "npx", "args": ["-y", "@sap-ux/fiori-mcp-server@latest", "fiori-mcp"], "type": "stdio" }
```
