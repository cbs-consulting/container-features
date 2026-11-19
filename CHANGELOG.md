# Changelog

What changed in the cbs Dev Container Features, newest first. Each Feature has
its own version in `src/<feature>/devcontainer-feature.json`, and CI publishes
it to GHCR as soon as the change is merged into `main`. Add your change under
"Unreleased" in the same pull request and start the line with the Feature and
its new version, for example `npm-feeds 1.0.6:`. A check fails otherwise,
unless the pull request has the label "no changelog". From time to time,
"Unreleased" is renamed to the date and a new, empty "Unreleased" is started.

## Unreleased

- Agent skill 0.1.0: new agent skill in `skills/container-features/SKILL.md`
  that picks and sets up the Features in a `devcontainer.json`. The repository
  is an agent plugin (`plugin.json` and `.claude-plugin/plugin.json`), so the
  skill installs from the cbs Agentic Marketplace.

## Before 2026-11-19

This changelog starts here. The Features had these versions when it started:
`btp-cli-tools` 1.1.1, `cap-dev-stack` 1.0.3, `dev-defaults` 1.0.0,
`devcontainer-tools` 1.0.3, `fiori-dev-stack` 1.0.2, `npm-feeds` 1.0.5 and
`typescript` 2.0.0. See the
[commit history](https://github.com/cbs-consulting/container-features/commits/main)
for the changes before then.
