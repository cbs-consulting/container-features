# container-features

Dev Container Features for SAP BTP / CAP development, published to GHCR at
`ghcr.io/cbs-consulting/container-features`.

## Features

| Feature | Purpose |
|---|---|
| **`dev-defaults`** | General VS Code extensions & editor settings (GitLens, Copilot, spell check, Markdown, CSV, …) |
| **`typescript`** | TypeScript + ts-node globally; ESLint, Prettier, Pretty TS Errors |
| **`btp-cli-tools`** | Cloud Foundry CLI + optional CF plugins |
| **`cap-dev-stack`** | SAP CAP tools (`@sap/cds-dk`, `mbt`, `mta`) + CDS VS Code extensions |
| **`fiori-dev-stack`** | SAP Fiori tools (`yo`, `@sap/generator-fiori`) + Fiori VS Code extensions |
| **`npm-feeds`** | Private npm registry feeds — scope→URL at build time, PAT prompt at post-create |
| **`devcontainer-tools`** | Dev Container CLI (`@devcontainers/cli`) + Dev Containers VS Code extension |

## Usage

### Full SAP BTP stack

```jsonc
{
  "features": {
    "ghcr.io/devcontainers/features/node:1": { "version": "lts" },
    "ghcr.io/cbs-consulting/container-features/dev-defaults:1": {},
    "ghcr.io/cbs-consulting/container-features/devcontainer-tools:1": {},
    "ghcr.io/cbs-consulting/container-features/typescript:1": {},
    "ghcr.io/cbs-consulting/container-features/btp-cli-tools:1": {},
    "ghcr.io/cbs-consulting/container-features/cap-dev-stack:1": {},
    "ghcr.io/cbs-consulting/container-features/fiori-dev-stack:1": {},
    "ghcr.io/cbs-consulting/container-features/npm-feeds:1": {
      "feeds": "@myorg|https://pkgs.dev.azure.com/org/_packaging/feed/npm/registry/|AZURE_DEVOPS_PAT"
    }
  }
}
```

Project-specific settings to add in your own `devcontainer.json`:
- `i18n-ally.localesPaths` (varies per project)
- MCP servers (`cds-mcp`, `ui5-mcp`, `fiori-mcp`)
- `name`, `image`, `runArgs`

### Package version policy

npm-based tools default to `latest`, resolved when the container image is built. Rebuilding the same configuration can therefore install newer package versions. If an update causes a problem or a stable toolchain is required, set each affected feature option to the last working exact version.

### Individual feature with pinned versions

```jsonc
{
  "features": {
    "ghcr.io/cbs-consulting/container-features/cap-dev-stack:1": {
      "cds-dk": "8.6.1",
      "mbt": "none"
    }
  }
}
```

## License

Copyright 2026 cbs Corporate Business Solutions Unternehmensberatung GmbH.

Licensed under the [Apache License, Version 2.0](LICENSE).

