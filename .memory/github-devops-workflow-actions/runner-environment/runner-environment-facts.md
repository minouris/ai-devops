# Runner Environment - Fact File

**Topic:** github-devops-workflow-actions / runner-environment

**Status:** Research in progress

---

## FINDING-2026-04-09-1

**Topic:** GitHub Actions runner environment and default working directory

**Introduces terms:** [`GITHUB_WORKSPACE` environment variable](../github-devops-workflow-actions-terms.md#github_workspace-environment-variable)

**Observation:**

GitHub Actions runners are freshly-provisioned virtual machines. Each job executes on a new runner instance. The default working directory available to all jobs is represented by the `GITHUB_WORKSPACE` default environment variable.

**GITHUB_WORKSPACE Default Path:**

An example path for `GITHUB_WORKSPACE` is `/home/runner/work/my-repo-name/my-repo-name`, indicating:
- Root workspace: `/home/runner/work/`
- Repository cloned into: `my-repo-name/my-repo-name` (nested under repository name)

This is described as "the default working directory on the runner for steps, and the default location of your repository."

**Note on terminology:** While the variable is called `GITHUB_WORKSPACE` and is the default working directory, the repository code is NOT automatically present at this location. Explicit checkout is required (see FINDING-2026-04-09-2).

**Source:** [GitHub Docs — About GitHub-hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners); [GitHub Docs — Variables Reference](https://docs.github.com/en/actions/reference/variables-reference)

**Date captured:** 2026-04-09

---

## FINDING-2026-04-09-2

**Topic:** Repository code availability and checkout requirement

**Introduces terms:** [`actions/checkout` action](../github-devops-workflow-actions-terms.md#actionscheckout-action), [GitHub-hosted runner provisioning](../github-devops-workflow-actions-terms.md#github-hosted-runner-provisioning)

**Uses terms:** [Preinstalled software on runners](../github-devops-workflow-actions-terms.md#preinstalled-software-on-runners)

**Observation:**

**Runners do NOT have repository code by default.** The `actions/checkout` action is required to make repository files available to workflows.

**How checkout works:**

The `actions/checkout` action "checks-out your repository under `$GITHUB_WORKSPACE`, so your workflow can access it." The action:
- Retrieves repository code from GitHub
- Places it in the working directory (`$GITHUB_WORKSPACE`)
- By default, fetches only a single commit matching the triggered event (configurable via `fetch-depth`)
- Handles git authentication, persisting credentials for authenticated git commands in subsequent steps

**Practical implication:**

Without the `actions/checkout` step, the runner's workspace lacks access to repository code. Any workflow step that needs to reference, build, test, or operate on repository files requires checkout to have executed first.

**Available by default (without checkout):**

- System tools (grep, find, which, etc.)
- Preinstalled software (managed in `actions/runner-images` repository)
- Environment variables including `GITHUB_WORKSPACE` (points to empty directory)
- Ability to write files to `$GITHUB_WORKSPACE`

**Source:** [GitHub Actions Repository (actions/checkout)](https://github.com/actions/checkout)

**Date captured:** 2026-04-09

---

## FINDING-2026-04-09-3

**Topic:** GitHub Actions scope regarding branch context and ref information

**Uses terms:** [GitHub context object](../github-devops-workflow-actions-terms.md#github-context-object)

**Observation:**

Official GitHub documentation does not explicitly document whether runners initially "know" which branch triggered the workflow or have access to branch metadata without explicit context setup.

However, GitHub Actions provides default context variables through the `github` context (structure not yet documented from available excerpts). Workflows can reference event triggers and context to determine which ref (branch, tag, etc.) triggered the action.

**Requires further investigation:** Whether runners have automatic branch context or if this must be extracted from `github` context variables/environment.

**Source:** [GitHub Docs — Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions) (incomplete documentation provided)

**Date captured:** 2026-04-09

---
