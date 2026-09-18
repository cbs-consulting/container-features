# CAP Dev Stack (cap-dev-stack)

Installs SAP CAP development tools as global npm packages. **Requires Node.js / npm** to be installed first
(use `ghcr.io/devcontainers/features/node` before this one).

Each package has its own version option that accepts:

- `latest` &mdash; install the latest version (default),
- `none` &mdash; skip the package,
- a specific version typed by hand (e.g. `8.6.1`).

`latest` is resolved when the container image is built, so rebuilding the same configuration can install newer versions. Pin the last working exact version if an update causes a problem or the toolchain must remain stable.

## Example Usage

```jsonc
"features": {
    "ghcr.io/devcontainers/features/node:1": {},
    "ghcr.io/cbs-consulting/container-features/cap-dev-stack:1": {
        "cds-dk": "latest",
        "mbt": "none"
    }
}
```

## Options

| Options Id | Package | Type | Default Value |
|-----|-----|-----|-----|
| cds-dk | `@sap/cds-dk` | string | latest |
| mbt | `mbt` | string | latest |
| mta | `mta` | string | latest |

## OS Support

Any image where `npm` is available on `PATH`. Runs as `root` during the build.

## VS Code Customizations

This feature automatically installs the following when VS Code connects:

**Extensions:** `SAPSE.vscode-cds`, `qwtel.sqlite-viewer`, `humao.rest-client`

**Settings:**
- `npm.scriptRunner: "node"`
- `[cds]` → formatter: `SAPSE.vscode-cds`
