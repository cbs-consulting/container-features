# TypeScript (typescript)

Installs TypeScript and ts-node as global npm packages, and configures VS Code for TypeScript/JavaScript development.

Requires Node.js / npm. Add `ghcr.io/devcontainers/features/node` before this feature.

## Options

| Option | Description | Type | Default |
|---|---|---|---|
| `typescript` | TypeScript version. `'latest'`, `'none'` to skip, or a specific version (e.g. `5.4.5`). | string | `latest` |
| `ts-node` | ts-node version. `'latest'`, `'none'` to skip, or a specific version. | string | `latest` |

`latest` is resolved when the container image is built, so rebuilding the same configuration can install newer versions. Pin the last working exact version if an update causes a problem or the toolchain must remain stable.

## Extensions included

| Extension | Purpose |
|---|---|
| `dbaeumer.vscode-eslint` | ESLint integration |
| `esbenp.prettier-vscode` | Prettier formatter |
| `YoavBls.pretty-ts-errors` | Human-readable TypeScript errors |
| `meganrogge.template-string-converter` | Auto-convert to template literals |
| `codeandstuff.package-json-upgrade` | Show available dependency updates |

## Settings applied

- `editor.codeActionsOnSave: { "source.fixAll.eslint": "always" }`
- `typescript.updateImportsOnFileMove.enabled: "always"`
- `javascript.updateImportsOnFileMove.enabled: "always"`
- `[javascript][typescript][json][typescriptreact]` → formatter: `esbenp.prettier-vscode`

## Example Usage

```jsonc
"features": {
    "ghcr.io/devcontainers/features/node:1": { "version": "lts" },
    "ghcr.io/cbs-consulting/container-features/typescript:1": {}
}
```

Pin a specific TypeScript version:

```jsonc
"ghcr.io/cbs-consulting/container-features/typescript:1": {
    "typescript": "5.4.5",
    "ts-node": "none"
}
```
