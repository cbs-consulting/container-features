# Dev Container Tools (devcontainer-tools)

Installs the [Dev Container CLI](https://github.com/devcontainers/cli) (`@devcontainers/cli`) as a global npm package and adds the **Dev Containers** VS Code extension. **Requires Node.js / npm** to be installed first (use `ghcr.io/devcontainers/features/node` before this one).

## Example Usage

```jsonc
"features": {
    "ghcr.io/devcontainers/features/node:1": {},
    "ghcr.io/cbs-group/container-features/devcontainer-tools:1": {}
}
```

## Options

| Options Id | Package | Type | Default Value |
|-----|-----|-----|-----|
| cli | `@devcontainers/cli` | string | latest |

The `cli` option accepts `latest` (default), `none` to skip installation, or a specific version (e.g. `0.75.0`).

`latest` is resolved when the container image is built, so rebuilding the same configuration can install a newer CLI. Pin the last working exact version if an update causes a problem or the toolchain must remain stable.

## OS Support

Any image where `npm` is available on `PATH`. Runs as `root` during the build.

## VS Code Customizations

This feature automatically installs the following when VS Code connects:

**Extensions:** `ms-vscode-remote.remote-containers`
