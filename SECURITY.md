# Security Policy

## Supported Versions

Each Feature is versioned and published on its own. Only the latest release
of each Feature receives security fixes. The major version tag, such as `:1`,
always points at that release, so a rebuild picks up the fix unless you pinned
a full version such as `:1.2.0`.

## Reporting a Vulnerability

Do not open a public issue for a security problem. Report it privately in one
of these ways:

- Through [GitHub private vulnerability reporting](https://github.com/cbs-consulting/container-features/security/advisories/new).
- By email to [cp_opensource@cbs-consulting.de](mailto:cp_opensource@cbs-consulting.de),
  with [administrator@cbs-consulting.de](mailto:administrator@cbs-consulting.de)
  in copy.

Describe the problem, the affected Feature and version, and the steps to
reproduce it. If you know of a fix or a workaround, add it as well.

We confirm that we received your report within five working days and keep you
informed while we work on a fix. Once the fix is released we publish a
security advisory and credit you, unless you would rather stay anonymous.

## Scope

This policy covers the Features in this repository: their install scripts and
the files, settings and credentials handling they set up in a dev container,
such as the npm registry configuration written by `npm-feeds`. Problems in the
tools that the Features install, such as the Cloud Foundry CLI, SAP CAP or the
Fiori tools, belong with those projects.
