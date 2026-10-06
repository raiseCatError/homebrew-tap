# RaiseCatError Tap

## Install NMSh

```sh
brew install raiseCatError/tap/nmsh
nmsh --version
```

The fully qualified command adds the tap automatically. You can also add it explicitly with `brew tap raiseCatError/tap`.

To update:

```sh
brew upgrade raiseCatError/tap/nmsh
```

To uninstall, use `brew uninstall raiseCatError/tap/nmsh`.

For a `brew bundle` `Brewfile`:

```ruby
tap "raiseCatError/tap"
brew "raiseCatError/tap/nmsh"
```

## Release maintenance

This tap's Homebrew-generated workflows own formula updates; the [NMSh source repository](https://github.com/raiseCatError/notMyShell) does not push updates into the tap.

1. Publish a stable NMSh release with a version tag such as `v0.17.0`. The formula's GitHub archive URL lets Homebrew livecheck discover newer version tags; conventional prerelease names such as `-alpha`, `-beta` and `-rc` are filtered out. Tag discovery does not inspect GitHub's release draft/prerelease flags, so use prerelease names for prerelease tags.
2. `autobump.yml` runs daily at 05:55 UTC and uses `brew bump` to open a formula-update PR with the new URL and checksum.
3. Approve the bot-created PR's workflows when GitHub prompts, then wait for `tests.yml` (`brew test-bot`) to validate the formula and build bottles on macOS and Linux.
4. To publish bottles and integrate the PR, manually run `publish.yml` (`brew pr-pull`) with the PR number and preferably its expected head SHA. It pulls tested bottles, publishes them and pushes the resulting commits to `main`. For a source-only update, merge the validated PR normally; bottle publishing is not triggered automatically by merging.

In **Settings → Actions → General → Workflow permissions**, enable **Allow GitHub Actions to create and approve pull requests**. Actions must be enabled and the pinned Homebrew/GitHub actions must be permitted. The workflows declare their required job permissions explicitly, so the default workflow permission can remain read-only. Branch rules must permit the publish workflow to push to `main` if bottle publishing is used.

These workflows use the tap's `GITHUB_TOKEN`. No custom PAT or `HOMEBREW_TAP_TOKEN` is required. GitHub may require a maintainer with write access to approve test runs for a PR opened or updated with `GITHUB_TOKEN`; see [GitHub's workflow triggering documentation](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow).

Validate the current formula locally with:

```sh
brew test raiseCatError/tap/nmsh
brew audit --formula raiseCatError/tap/nmsh
brew style raiseCatError/tap/nmsh
brew livecheck raiseCatError/tap/nmsh
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
