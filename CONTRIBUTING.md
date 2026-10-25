# Contributing

Thank you for helping to improve the cbs Dev Container Features. This guide
explains how to propose a change and how to test it locally.

By taking part in this project you agree to follow our
[Code of Conduct](CODE_OF_CONDUCT.md). To report a security problem, follow the
[Security Policy](SECURITY.md) instead of opening an issue.

## Reporting bugs and requesting features

Search the [existing issues](https://github.com/cbs-consulting/container-features/issues)
first. If nothing matches, open a new issue with the bug report or feature
request form. For a larger change, such as a new Feature or a breaking change
to an existing one, open an issue before you start so we can agree on the
approach.

## Repository layout

- `src/<feature>/`: the Feature itself (`devcontainer-feature.json`,
  `install.sh` and its `README.md`)
- `test/<feature>/`: scenario tests (`scenarios.json` and one script per
  scenario)
- `lib/npm-utils.sh`: npm helpers shared by the npm-based Features. Each of
  those Features ships a copy at `src/<feature>/npm-utils.sh`, because a
  Feature can only use files from its own folder.

## Making a change

1. Fork the repository and create a branch from `main`.
2. Open the repository in VS Code and choose **Reopen in Container**. The dev
   container provides Docker and the Dev Container CLI that the tests need.
3. Make your change and add or update the scenario tests for it in
   `test/<feature>/`.
4. If you changed `lib/npm-utils.sh`, copy it into the Features with:

   ```sh
   ./scripts/sync-lib.sh
   ```

5. Check that everything passes:

   ```sh
   shellcheck lib/*.sh scripts/*.sh src/*/*.sh test/test.sh test/*/*.sh
   ./scripts/sync-lib.sh --check
   ./test/test.sh <feature>
   ```

6. Bump `version` in `src/<feature>/devcontainer-feature.json` following
   [Semantic Versioning](https://semver.org/): a patch for a fix, a minor
   version for a new option, and a major version for a change that can break
   existing `devcontainer.json` files, such as a removed option or a changed
   default. CI publishes the new version when the change is merged into
   `main`; without a bump, the change is not published.
7. Update the Feature's `README.md` if you added or changed an option, and the
   top-level `README.md` if you added a Feature.
8. Open a pull request against `main` and fill in the template.

Pull requests are merged through a merge queue. Once the checks pass and the
pull request is approved, choose **Merge when ready**: GitHub tests it on top
of `main` and the pull requests queued ahead of it, and merges it when the
checks pass there too. You don't have to update your branch with `main`
first.

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/) with the
Feature as the scope, for example `feat(cap-dev-stack): add mta option` or
`fix(npm-feeds): keep existing .npmrc`. Mark a breaking change with `!`, as in
`feat(typescript)!: replace ts-node with tsx`. Keep each pull request to one
topic.

## License

By contributing you agree that your contribution is licensed under the
[Apache License 2.0](LICENSE), the license of this project.
