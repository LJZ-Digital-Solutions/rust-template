# rust-template

**Ready to go Rust development template. Includes a devcontainer, logging, formatting, linting, basic CI, releases and build actions.** _Based on [maxgallup/rust-template](https://github.com/maxgallup/rust-template)_

## Development

Hop right in with the provided devcontainer, preferrably using VScode. Use <kbd>ctrl</kbd>/<kbd>cmd</kbd> + <kbd>shift</kbd> + <kbd>p</kbd> and select "Rebuild and Reopen in Container" (this might take a while the first time)

 ![image](https://github.com/user-attachments/assets/fe99f580-031d-44ba-9332-e21c93cd571a)

You can build using `just`. Cross-compilation to ARM is available out of the box.

```bash
# Debug builds
just build
just build-arm

# Release builds
just build-release
just build-arm-release
```

Built binaries can be found in the _target_ folder. Check out the _justfile_ for more available targets, including formatting and linting.

## CI

Various CI workflows are included. They are available in _.github/workflows_.

### Test and Security Audits

Tests (including formatting and linting) are run on every push, together with basic security audits. You can use Github branch protection rules to further protect PRs using the test actions.

### Release and Build

Google's [release-please](https://github.com/googleapis/release-please-action) action is integrated to automatically create releases based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) (i.e. `feat:`, `fix:` and `chore:` commit messages). 

Release-please is configured to work with the default `GITHUB_TOKEN` secret, so that you do not have to set or keep track of any personal access tokens. This might cause issues in the first run:

- **If no PR could be created**: [allow actions to create and merge pull requests](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#preventing-github-actions-from-creating-or-approving-pull-requests)
  - If you are within an organization/enterprise and the option is grayed out, you must enable this in your organization/enterprise first
- **If labels cannot be created**: create the labels manually and rerun the release-please action. You need to create the following labels:
  - `autorelease: pending`
  - `autorelease: tagged`

After fixing these quirks, release-please will create PRs for you based on your commit messages. After merging a PR, the cargo.toml will be updated, the commits will be added to the CHANGELOG, and a new github release will be created.

> [!WARNING]  
> The creation of a new github release will **NOT** trigger workflows triggered by:
> ```yaml
>    on:
>      release: 
> ```
> This is because GITHUB_TOKEN actions [cannot trigger new workflows](https://github.com/orgs/community/discussions/54574#discussioncomment-10119733) (also see [here](https://github.com/orgs/community/discussions/25281)). 
>
> We work around this by opening the new release in the browser and pressing "update" without changing anything. This will trigger the build action. 
> <img width="978" alt="image" src="https://github.com/user-attachments/assets/f8a919cf-91a4-4940-9903-be2295cad8a5" />
> It is... not ideal.
> 
> You can also work around this by using a PAT for the release-please and build action, but that requires you to set up and maintain a PAT with the correct permissions manually.

The build action will compile a Linux AMD and ARM binary and add it to the release as an asset that can be downloaded.
