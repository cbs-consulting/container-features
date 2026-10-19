<div align="center">

<img src=".github/assets/logo.svg" alt="" width="120" />

# cbs Dev Container Features

**Ready-to-use Dev Container Features for SAP BTP, CAP and Fiori development.**

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![GHCR](https://img.shields.io/badge/ghcr.io-cbs--consulting%2Fcontainer--features-0F4C5C?logo=github)](https://github.com/orgs/cbs-consulting/packages?repo_name=container-features)
[![Dev Containers spec](https://img.shields.io/badge/spec-containers.dev-2496ED?logo=docker&logoColor=white)](https://containers.dev/implementors/features/)

</div>

---

Set up a complete SAP BTP toolchain (Cloud Foundry CLI, CAP, Fiori tools, TypeScript and private npm feeds) by adding a few lines to your `devcontainer.json`. No manual setup and no "works on my machine". Every Feature is published as an OCI artifact to `ghcr.io/cbs-consulting/container-features`.

## ✨ Features

| Feature | What you get |
| --- | --- |
| [`dev-defaults`](src/dev-defaults) | Curated VS Code extensions and editor settings (GitLens, Copilot, spell check, Markdown, CSV, …) |
| [`typescript`](src/typescript) | TypeScript and `ts-node` globally, plus ESLint, Prettier and Pretty TS Errors |
| [`btp-cli-tools`](src/btp-cli-tools) | Cloud Foundry CLI with optional CF plugins |
| [`cap-dev-stack`](src/cap-dev-stack) | SAP CAP tooling (`@sap/cds-dk`, `mbt`, `mta`) and CDS extensions |
| [`fiori-dev-stack`](src/fiori-dev-stack) | SAP Fiori tooling (`yo`, `@sap/generator-fiori`) and Fiori extensions |
| [`npm-feeds`](src/npm-feeds) | Private npm registries: scope→URL mapping at build time, PAT prompt on first start |
| [`devcontainer-tools`](src/devcontainer-tools) | Dev Container CLI (`@devcontainers/cli`) and the Dev Containers extension |

Each Feature's folder has its own README with all available options.

## 🚀 Quick start

Add the Features you need to `.devcontainer/devcontainer.json`:

```jsonc
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/node:1": { "version": "lts" },
    "ghcr.io/cbs-consulting/container-features/cap-dev-stack:1": {}
  }
}
```

Then run **Dev Containers: Rebuild and Reopen in Container** in VS Code.

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

> [!NOTE]
> Most Features rely on Node.js, so include `ghcr.io/devcontainers/features/node` as shown above.

## 📌 Version policy

npm-based tools default to `latest`, which is resolved when the image is built. A rebuild can therefore pull newer versions. If you need a reproducible toolchain, or an update breaks something, pin exact versions:

```jsonc
{
  "features": {
    "ghcr.io/cbs-consulting/container-features/cap-dev-stack:1": {
      "cds-dk": "8.6.1",
      "mbt": "none"   // "none" skips installation
    }
  }
}
```

The `:1` tag tracks the latest 1.x release of a Feature. Use a full version such as `:1.2.0` to lock the Feature itself.

## 🧩 Related

- [**container-templates**](https://github.com/cbs-consulting/container-templates): ready-made Dev Container Templates built on these Features

## 🛠️ Contributing

The repo ships its own dev container. Open it in VS Code and choose **Reopen in Container**. Features live in `src/<feature>/` and their tests in `test/<feature>/`. Run the tests locally with:

```bash
devcontainer features test -f <feature> .
```

## 📄 License

Copyright © 2026 cbs Corporate Business Solutions Unternehmensberatung GmbH.
Licensed under the [Apache License 2.0](LICENSE).

<sub>SAP, SAP BTP and SAP Fiori are trademarks of SAP SE. This project is not affiliated with or endorsed by SAP.</sub>
