# BTP CLI Tools (btp-cli-tools)

Installs BTP CLI tools. Currently includes the Cloud Foundry CLI from the official Cloud Foundry apt repository (`cf<version>-cli`).

## Example Usage

```jsonc
"features": {
    "ghcr.io/cbs-consulting/container-features/btp-cli-tools:1": {
        "version": "8",
        "plugins": "multiapps,html5-plugin"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Cloud Foundry CLI major version, used as the apt package suffix: `8` -> `cf8-cli`, `7` -> `cf7-cli`. | string | 8 |
| skip-cf-on-failure | Keep building the container without CF CLI or CF plugins if its verified APT installation fails. The failing CF repository is removed. | boolean | true |
| plugins | Comma-separated list of unreviewed third-party plugins to install from CF-Community. Names resolve to the latest published version. E.g. `multiapps,html5-plugin`. | string | |

`skip-cf-on-failure` is an availability fallback for Cloud Foundry APT repository failures. It never disables APT signature verification. By default, an unavailable or invalid repository does not prevent the container from building, but `cf` and requested CF plugins are omitted. Set the option to `false` to fail the build instead. The [invalid repository signature reported in cloudfoundry/cli#3863](https://github.com/cloudfoundry/cli/issues/3863) is one example.

Plugins selected through the feature option are installed into a shared, root-owned directory. Container users can run them but cannot add, update, or remove plugins there. Change the `plugins` option and rebuild the container to manage the shared plugin set.

## Plugin trust

CF Community plugins are third-party binaries and are not reviewed by the Cloud Foundry Foundation. Configuring the `plugins` option explicitly accepts that risk. Review each plugin and its publisher before adding it.

The CF CLI repository installation command does not support version or checksum selection. Each plugin name therefore resolves to the latest version available when the container image is built, so rebuilding can install different code without a configuration change.

## OS Support

Debian / Ubuntu based images with `apt`. Runs as `root` during the build.
