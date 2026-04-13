# GitHub DevOps Workflow Actions Terms

**Last Updated:** 2026-04-09 00:00
**Verified Terms:** 0
**Pending Terms:** 27

---

## Table of Contents

- [`--model` flag](#--model-flag)
- [`--no-ask-user` flag](#--no-ask-user-flag)
- [`actions/checkout` action](#actionscheckout-action)
- [`COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable](#copilot_custom_instructions_dirs-environment-variable)
- [`COPILOT_GITHUB_TOKEN` environment variable](#copilot_github_token-environment-variable)
- [`COPILOT_MODEL` environment variable](#copilot_model-environment-variable)
- [Cache restoration algorithm](#cache-restoration-algorithm)
- [Cache scope isolation](#cache-scope-isolation)
- [`cache-hit` output](#cache-hit-output)
- [`contains()` function](#contains-function)
- [Copilot CLI invocation](#copilot-cli-invocation)
- [Custom instructions](#custom-instructions)
- [`github.event.issue` context object](#githubeeventissue-context-object)
- [`GH_TOKEN` environment variable](#gh_token-environment-variable)
- [`GITHUB_TOKEN` automatic token](#github_token-automatic-token)
- [`GITHUB_WORKSPACE` environment variable](#github_workspace-environment-variable)
- [GitHub CLI preinstallation](#github-cli-preinstallation)
- [GitHub-hosted runner provisioning](#github-hosted-runner-provisioning)
- [Issue activity types](#issue-activity-types)
- [`issues` event](#issues-event)
- [`issues: read` permission](#issues-read-permission)
- [`issues: write` permission](#issues-write-permission)
- [Label filtering](#label-filtering)
- [Model selection priority](#model-selection-priority)
- [npm installation of Copilot CLI](#npm-installation-of-copilot-cli)
- [Preinstalled software on runners](#preinstalled-software-on-runners)
- [Skill invocation via Copilot CLI](#skill-invocation-via-copilot-cli)

---

## `--model` flag

**Captured:** 2026-04-09 00:00

Command-line argument specifying which AI model Copilot CLI uses when executing a prompt.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Copilot CLI Programmatic Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference) | PENDING | Pending verification |

### Description

The `--model` flag allows explicit model selection when invoking Copilot CLI in automated workflows. Example usage: `copilot -p "PROMPT" --model claude-haiku-4.5`. This flag takes precedence in the model selection priority hierarchy after custom agent definitions but before environment variables and configuration files.

### See Also

- [Model selection priority](#model-selection-priority)
- [`COPILOT_MODEL` environment variable](#copilot_model-environment-variable)

### Referenced By

- [FINDING-2026-04-08-8](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-8) - Model specification via --model flag

---

## `--no-ask-user` flag

**Captured:** 2026-04-09 00:00

Copilot CLI flag preventing interactive prompts during automated workflow execution.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions) | PENDING | Pending verification |

### Description

Required for non-interactive execution in GitHub Actions workflows. Suppresses user input prompts that would otherwise halt workflow execution. Must be included when running Copilot in automated contexts.

### See Also

- [Copilot CLI invocation](#copilot-cli-invocation)

### Referenced By

- [FINDING-2026-04-08-7](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-7) - Running Copilot CLI in workflows

---

## `actions/checkout` action

**Captured:** 2026-04-09 00:00

GitHub Actions action that retrieves repository code and places it in the default working directory.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions Repository (actions/checkout)](https://github.com/actions/checkout) | PENDING | Pending verification |

### Description

The `actions/checkout` action is required to enable workflow access to repository files. It fetches repository code from GitHub and places it in `$GITHUB_WORKSPACE`. By default, it fetches only a single commit matching the triggered event but supports configurable `fetch-depth`. The action handles git authentication, persisting credentials for authenticated git commands in subsequent steps. Without this action, runners have no access to repository files.

### See Also

- [`GITHUB_WORKSPACE` environment variable](#github_workspace-environment-variable)
- [GitHub-hosted runner provisioning](#github-hosted-runner-provisioning)

### Referenced By

- [FINDING-2026-04-09-2](./runner-environment/runner-environment-facts.md#finding-2026-04-09-2) - Repository code availability

---

## `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable

**Captured:** 2026-04-09 00:00

Environment variable accepting comma-separated list of directories where Copilot CLI searches for custom instruction files.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Copilot CLI: Add Custom Instructions](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions) | PENDING | Pending verification |

### Description

Enables project-specific instruction directory configuration for Copilot CLI. Accepts multiple paths as comma-separated values. Copilot searches specified directories for `AGENTS.md` and `.github/instructions/**/*.instructions.md` files. This is the documented method for programmatic configuration; no command-line flag exists for this purpose.

### See Also

- [Custom instructions](#custom-instructions)

### Referenced By

- [FINDING-2026-04-09-2](./copilot-cli/copilot-cli-facts.md#finding-2026-04-09-2) - Specifying custom instructions directories

---

## `COPILOT_GITHUB_TOKEN` environment variable

**Captured:** 2026-04-09 00:00

Environment variable containing Personal Access Token for Copilot CLI authentication in workflows.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions) | PENDING | Pending verification |

### Description

Required for Copilot CLI authentication in GitHub Actions workflows. The token must have "Copilot Requests" permission scope. Example usage: `env: COPILOT_GITHUB_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }}`. Enables secure token passing to Copilot during workflow execution.

### See Also

- [`GH_TOKEN` environment variable](#gh_token-environment-variable)
- [`GITHUB_TOKEN` automatic token](#github_token-automatic-token)

### Referenced By

- [FINDING-2026-04-08-7](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-7) - Running Copilot CLI in workflows
- [FINDING-2026-04-09-2](./copilot-cli/copilot-cli-facts.md#finding-2026-04-09-2) - Custom instructions configuration

---

## `COPILOT_MODEL` environment variable

**Captured:** 2026-04-09 00:00

Environment variable setting the default model for Copilot CLI execution when no `--model` flag is provided.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Copilot CLI Programmatic Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference) | PENDING | Pending verification |

### Description

Provides a fallback model specification method for Copilot CLI. Takes precedence after command-line flags but before configuration files and defaults. Example: `env: COPILOT_MODEL: claude-haiku-4.5`. Part of the model selection hierarchy that determines which AI model executes prompts.

### See Also

- [Model selection priority](#model-selection-priority)
- [`--model` flag](#--model-flag)

### Referenced By

- [FINDING-2026-04-08-8](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-8) - Model specification options

---

## Cache restoration algorithm

**Captured:** 2026-04-09 00:00

Three-tier search mechanism for retrieving cached artifacts: exact key match → partial restore-keys match → cache miss.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows) | PENDING | Pending verification |

### Description

When a workflow requests cache restoration, the system searches using a priority-based approach: first searching for an exact key match, then searching partial matches using `restore-keys`, and finally creating a new cache after job completion if no matches found. This hierarchical approach balances precision with fallback matching, enabling cache key flexibility.

### See Also

- [`cache-hit` output](#cache-hit-output)
- [Cache scope isolation](#cache-scope-isolation)

### Referenced By

- [FINDING-2026-04-08-1](./caching/caching-facts.md#finding-2026-04-08-1) - GitHub Actions cache mechanism

---

## Cache scope isolation

**Captured:** 2026-04-09 00:00

Deliberate hierarchy controlling which workflows access which caches based on branch relationships and pull request context.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows) | PENDING | Pending verification |

### Description

GitHub Actions implements hierarchical cache access control: workflows can restore caches from the current branch or default branch only; pull request workflows can also restore from base branch; workflows cannot access child or sibling branch caches. This architecture intentionally compartmentalises cache access to reduce information leakage between branches. Each tag operates as an independent cache namespace.

### See Also

- [Cache restoration algorithm](#cache-restoration-algorithm)

### Referenced By

- [FINDING-2026-04-08-2](./caching/caching-facts.md#finding-2026-04-08-2) - Cache scope and isolation

---

## `cache-hit` output

**Captured:** 2026-04-09 00:00

Boolean-like output from cache action indicating cache restore result: `'true'` for exact match, `'false'` for partial match, or empty string for miss.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions Cache Action Repository](https://github.com/actions/cache) | PENDING | Pending verification |

### Description

The cache action outputs `cache-hit` to indicate restoration outcome. `'true'` indicates exact key match (cache fully restored), `'false'` indicates partial `restore-keys` match, empty string indicates no cache found. This enables conditional skipping of expensive build steps when caches are reused via patterns like `if: steps.cache.outputs.cache-hit != 'true'`.

### See Also

- [Cache restoration algorithm](#cache-restoration-algorithm)

### Referenced By

- [FINDING-2026-04-08-4](./caching/caching-facts.md#finding-2026-04-08-4) - Cache action outputs

---

## `contains()` function

**Captured:** 2026-04-09 00:00

GitHub Actions expression function that checks if an array includes a specific item; performs case-insensitive matching.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Expressions](https://docs.github.com/en/actions/learn-github-actions/expressions) | PENDING | Pending verification |

### Description

Used in workflow conditionals to check array membership. For issue label checking: `contains(github.event.issue.labels.*.name, 'label-name')` returns `true` if the label exists, `false` otherwise. Negation syntax `!contains(...)` checks for label absence. Case-insensitive matching means 'Bug', 'BUG', and 'bug' are treated equivalently.

### See Also

- [Label filtering](#label-filtering)
- [`github.event.issue` context object](#githubeeventissue-context-object)

### Referenced By

- [FINDING-2026-04-08-1](./issue-handling/issue-handling-facts.md#finding-2026-04-08-1) - Label filtering via contains()

---

## Copilot CLI invocation

**Captured:** 2026-04-09 00:00

Executing Copilot CLI in non-interactive workflow steps using `-p PROMPT` flag syntax with required authentication.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions) | PENDING | Pending verification |

### Description

Copilot CLI invocation pattern for GitHub Actions: `copilot -p "YOUR_PROMPT" --no-ask-user` with `COPILOT_GITHUB_TOKEN` environment variable set. Enables programmatic execution of Copilot without user interaction. Must include `--no-ask-user` flag to suppress interactive prompts.

### See Also

- [`--no-ask-user` flag](#--no-ask-user-flag)
- [`COPILOT_GITHUB_TOKEN` environment variable](#copilot_github_token-environment-variable)
- [Skill invocation via Copilot CLI](#skill-invocation-via-copilot-cli)

### Referenced By

- [FINDING-2026-04-08-7](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-7) - Running Copilot CLI in workflows

---

## Custom instructions

**Captured:** 2026-04-09 00:00

Project-specific context files that provide Copilot with additional information on how to understand and work with a project.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Copilot CLI: Add Custom Instructions](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions) | PENDING | Pending verification |

### Description

Custom instructions are discovered at multiple levels: `CLAUDE.md`, `GEMINI.md`, and `AGENTS.md` at repository root; `.github/instructions/**/*.instructions.md` for path-specific instructions; and via `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable for programmatic configuration. Enable repository and project-level customisation of Copilot behaviour.

### See Also

- [`COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable](#copilot_custom_instructions_dirs-environment-variable)

### Referenced By

- [FINDING-2026-04-09-1](./copilot-cli/copilot-cli-facts.md#finding-2026-04-09-1) - Custom instructions configuration
- [FINDING-2026-04-09-2](./copilot-cli/copilot-cli-facts.md#finding-2026-04-09-2) - Custom instructions directories

---

## `github.event.issue` context object

**Captured:** 2026-04-09 00:00

Context object containing issue data available in workflows triggered by the issues event.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows) | PENDING | Pending verification |

### Description

When GitHub Actions workflows are triggered by the `issues` event, issue data becomes available through `github.event.issue` context. Documented accessible properties include `issue.number` and `issue.pull_request`. Full schema aligns with REST API Issue object, providing access to comprehensive issue information within workflow steps.

### See Also

- [`issues` event](#issues-event)
- [Issue activity types](#issue-activity-types)

### Referenced By

- [FINDING-2026-04-08-3](./issue-handling/issue-handling-facts.md#finding-2026-04-08-3) - Issue data availability

---

## `GH_TOKEN` environment variable

**Captured:** 2026-04-09 00:00

Environment variable for GitHub CLI authentication in workflows, typically set to `${{ secrets.GITHUB_TOKEN }}`.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli) | PENDING | Pending verification |

### Description

Required to authenticate GitHub CLI in workflows. Token scopes are determined by the job's permission configuration. Enables GitHub CLI commands like `gh issue comment` and `gh issue edit` within workflow steps. The automatic `GITHUB_TOKEN` available in workflows inherits permissions from job-level configuration.

### See Also

- [`GITHUB_TOKEN` automatic token](#github_token-automatic-token)
- [GitHub CLI preinstallation](#github-cli-preinstallation)

### Referenced By

- [FINDING-2026-04-08-2](./workflow-execution/workflow-execution-facts.md#finding-2026-04-08-2) - GitHub CLI authentication

---

## `GITHUB_TOKEN` automatic token

**Captured:** 2026-04-09 00:00

Automatic token available in GitHub Actions workflows with scopes determined by job-level `permissions` configuration.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli) | PENDING | Pending verification |

### Description

Every GitHub Actions workflow has access to an automatic `GITHUB_TOKEN` with scopes inheriting from the job's `permissions` configuration. Passed to GitHub CLI via `GH_TOKEN` environment variable. Enables secure API access within workflows without requiring explicit secret creation. Token scopes match the granular permissions specified at workflow or job level.

### See Also

- [`GH_TOKEN` environment variable](#gh_token-environment-variable)
- [`issues: write` permission](#issues-write-permission)

### Referenced By

- [FINDING-2026-04-08-2](./workflow-execution/workflow-execution-facts.md#finding-2026-04-08-2) - GitHub CLI authentication

---

## `GITHUB_WORKSPACE` environment variable

**Captured:** 2026-04-09 00:00

Default working directory on runner; example path: `/home/runner/work/my-repo-name/my-repo-name`.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — About GitHub-hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) | PENDING | Pending verification |

### Description

Represents the default working directory available to all jobs on GitHub-hosted runners. Workspace is created but repository code is NOT automatically present at this location; `actions/checkout` is required to place repository files here. The directory exists and is writable even without checkout, but contains no repository code.

### See Also

- [`actions/checkout` action](#actionscheckout-action)
- [GitHub-hosted runner provisioning](#github-hosted-runner-provisioning)

### Referenced By

- [FINDING-2026-04-09-1](./runner-environment/runner-environment-facts.md#finding-2026-04-09-1) - Runner working directory

---

## GitHub CLI preinstallation

**Captured:** 2026-04-09 00:00

GitHub CLI (`gh`) is preinstalled on all GitHub-hosted runners; requires only authentication, not installation.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli) | PENDING | Pending verification |

### Description

Unlike Copilot CLI, GitHub CLI does not require installation steps in workflows. It is available on all GitHub-hosted runners. Only authentication setup via `GH_TOKEN` environment variable is needed. Workflow steps can immediately use GitHub CLI commands without explicit installation.

### See Also

- [npm installation of Copilot CLI](#npm-installation-of-copilot-cli)
- [GitHub-hosted runner provisioning](#github-hosted-runner-provisioning)

### Referenced By

- [FINDING-2026-04-08-1](./workflow-execution/workflow-execution-facts.md#finding-2026-04-08-1) - GitHub CLI preinstallation

---

## GitHub-hosted runner provisioning

**Captured:** 2026-04-09 00:00

Each GitHub Actions job executes on a freshly-provisioned virtual machine without repository code.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — About GitHub-hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) | PENDING | Pending verification |

### Description

GitHub Actions runners are fresh VMs provisioned for each job. Available by default: system tools (grep, find, which), preinstalled software, environment variables, workspace directory. NOT available by default: repository code (requires checkout), custom dependencies. This design ensures isolation and clean execution environments for each workflow run.

### See Also

- [`actions/checkout` action](#actionscheckout-action)
- [`GITHUB_WORKSPACE` environment variable](#github_workspace-environment-variable)
- [Preinstalled software on runners](#preinstalled-software-on-runners)

### Referenced By

- [FINDING-2026-04-09-2](./runner-environment/runner-environment-facts.md#finding-2026-04-09-2) - Runner provisioning

---

## Issue activity types

**Captured:** 2026-04-09 00:00

Specific issue event triggers: opened, edited, deleted, closed, reopened, assigned, unassigned, labeled, unlabeled, pinned, unpinned, transferred, milestoned, demilestoned, locked, unlocked, typed, untyped.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows) | PENDING | Pending verification |

### Description

Project lifecycle events that can trigger workflows via the `issues` event. Grouped by category: Creation/Modification (opened, edited, deleted), State Changes (closed, reopened), Assignment (assigned, unassigned), Organisation (labeled, unlabeled, pinned, unpinned, transferred), Milestone (milestoned, demilestoned), Other (locked, unlocked, typed, untyped). Workflows trigger by all types by default; use `types` keyword to limit to specific events.

### See Also

- [`issues` event](#issues-event)

### Referenced By

- [FINDING-2026-04-08-1](./issue-handling/issue-handling-facts.md#finding-2026-04-08-1) - Issue event types

---

## `issues` event

**Captured:** 2026-04-09 00:00

GitHub Actions trigger fired when issue lifecycle events occur within the repository.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows) | PENDING | Pending verification |

### Description

Triggers workflows when issues are created, modified, or manipulated. Configuration: `on: issues: types: [opened, labeled]`. Workflow file must exist on repository default branch for the event to trigger; this is a critical requirement. Enables issue-driven automation patterns within GitHub Actions.

### See Also

- [Issue activity types](#issue-activity-types)
- [`issues: write` permission](#issues-write-permission)

### Referenced By

- [FINDING-2026-04-08-1](./issue-handling/issue-handling-facts.md#finding-2026-04-08-1) - Triggering workflows on issue events

---

## `issues: read` permission

**Captured:** 2026-04-09 00:00

Workflow permission granting read-only access to repository issues.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Workflow Syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions) | PENDING | Pending verification |

### Description

Limited permission scope restricting workflow jobs to reading issue data without modification capabilities. Configuration: `permissions: issues: read`. Enables workflows to examine issue content and metadata but prevents issue creation, comment addition, or label modification.

### See Also

- [`issues: write` permission](#issues-write-permission)

### Referenced By

- [FINDING-2026-04-08-2](./issue-handling/issue-handling-facts.md#finding-2026-04-08-2) - Permission configuration

---

## `issues: write` permission

**Captured:** 2026-04-09 00:00

Workflow permission granting read and write access to repository issues.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Workflow Syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions) | PENDING | Pending verification |

### Description

Grants full read-write access to repository issues. Configuration: `permissions: issues: write` at workflow or job level. Enables workflow steps to create issues, add comments, modify labels, and perform all issue operations. Write permission includes read access automatically.

### See Also

- [`issues: read` permission](#issues-read-permission)

### Referenced By

- [FINDING-2026-04-08-2](./issue-handling/issue-handling-facts.md#finding-2026-04-08-2) - Permission configuration

---

## Label filtering

**Captured:** 2026-04-09 00:00

Using `contains()` function in job-level `if` conditions to execute jobs only when specific labels present or absent.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Expressions](https://docs.github.com/en/actions/learn-github-actions/expressions) | PENDING | Pending verification |

### Description

Conditional job execution pattern: `if: contains(github.event.issue.labels.*.name, 'label-name')` executes job only when label exists; negation `!contains(...)` executes when label absent. Enables sophisticated workflow triggering based on label presence, supporting complex issue-driven automation without additional API calls.

### See Also

- [`contains()` function](#contains-function)
- [`github.event.issue` context object](#githubeeventissue-context-object)

### Referenced By

- [FINDING-2026-04-08-1](./issue-handling/issue-handling-facts.md#finding-2026-04-08-1) - Label filtering

---

## Model selection priority

**Captured:** 2026-04-09 00:00

Hierarchical precedence determining which model Copilot CLI uses: custom agent → CLI flag → environment variable → config file → default.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Copilot CLI Programmatic Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference) | PENDING | Pending verification |

### Description

Copilot CLI evaluates model selection in this order: 1. Custom agent definition (if applicable), 2. Command-line option (`--model=<model>`), 3. Environment variable (`COPILOT_MODEL`), 4. Configuration file (`~/.copilot/config.json`), 5. Default model. This hierarchy allows flexible configuration at multiple levels with higher-priority methods overriding lower-priority ones.

### See Also

- [`--model` flag](#--model-flag)
- [`COPILOT_MODEL` environment variable](#copilot_model-environment-variable)

### Referenced By

- [FINDING-2026-04-08-8](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-8) - Model selection priority

---

## npm installation of Copilot CLI

**Captured:** 2026-04-09 00:00

Installing Copilot CLI globally on runners using `npm install -g @github/copilot`.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions) | PENDING | Pending verification |

### Description

Unlike GitHub CLI, Copilot CLI must be explicitly installed in workflows. Requires Node.js and npm; typically precede with `actions/setup-node` action. Installation command: `npm install -g @github/copilot`. Critical prerequisite before running Copilot CLI commands in workflows.

### See Also

- [Copilot CLI invocation](#copilot-cli-invocation)
- [GitHub CLI preinstallation](#github-cli-preinstallation)

### Referenced By

- [FINDING-2026-04-08-7](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-7) - Copilot CLI in workflows
- [FINDING-2026-04-08-3](./workflow-execution/workflow-execution-facts.md#finding-2026-04-08-3) - CLI installation requirement

---

## Preinstalled software on runners

**Captured:** 2026-04-09 00:00

System tools and applications available on all GitHub-hosted runners without installation.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — About GitHub-hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) | PENDING | Pending verification |

### Description

All GitHub-hosted runners include system tools such as grep, find, and which. These utilities are available immediately without installation steps. Managed and documented in the `actions/runner-images` repository. Enables workflows to utilise standard UNIX utilities without dependency setup.

### See Also

- [GitHub-hosted runner provisioning](#github-hosted-runner-provisioning)

### Referenced By

- [FINDING-2026-04-09-2](./runner-environment/runner-environment-facts.md#finding-2026-04-09-2) - Default runner capabilities

---

## Automatic caching via setup actions

**Captured:** 2026-04-09 00:00

Language-specific setup actions that include built-in automatic caching of package manager artifacts without manual configuration.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows) | PENDING | Pending verification |

### Description

Setup actions like `actions/setup-node`, `actions/setup-python`, and `actions/setup-java` provide automatic dependency caching via a `cache` parameter. When enabled, these actions automatically detect package manager lock files, create cache keys based on lock file contents, and restore or create caches transparently without requiring explicit cache action configuration.

### See Also

- [Cache restoration algorithm](#cache-restoration-algorithm)

### Referenced By

- [FINDING-2026-04-08-3](./caching/caching-facts.md#finding-2026-04-08-3) - Automatic dependency caching

---

## Custom actions

**Captured:** 2026-04-09 00:00

Reusable workflow components created using Docker, JavaScript, or Composite approaches that can be invoked in workflow steps.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — About Actions](https://docs.github.com/en/actions/creating-actions/about-actions) | PENDING | Pending verification |

### Description

Custom actions are individual tasks combined to create jobs and customise workflows. Three approaches: Docker Container Actions (package environment and code for consistency; Linux-only), JavaScript Actions (execute directly on runners for speed; pure JavaScript only), Composite Actions (combine multiple steps within one action). Each uses YAML metadata files (`action.yml` or `action.yaml`) defining inputs, outputs, and configuration.

### See Also

- [Uses keyword](#uses-keyword)

### Referenced By

- [FINDING-2026-04-08-1](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-1) - Custom actions overview

---

## Event triggers

**Captured:** 2026-04-09 00:00

Events that automatically initiate GitHub Actions workflows, configured via the `on` keyword in workflow files.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows) | PENDING | Pending verification |

### Description

Workflows are triggered by events defined using the `on` keyword. Events include push, pull_request, issues, schedule, workflow_dispatch, and many others. Each event can have configuration options specifying activity types, branches, paths, or inputs. "To automatically trigger a workflow, use `on` to define which events can cause the workflow to run."

### See Also

- [Workflow file](#workflow-file)
- [Workflow_dispatch trigger](#workflow_dispatch-trigger)

### Referenced By

- [FINDING-2026-04-08-3](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-3) - Event triggers and inputs

---

## GitHub Copilot

**Captured:** 2026-04-09 00:00

AI coding assistant that provides code suggestions and assistance across multiple GitHub environments.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Docs — What is GitHub Copilot](https://docs.github.com/en/copilot/about-github-copilot/what-is-github-copilot) | PENDING | Pending verification |

### Description

GitHub Copilot is "an AI coding assistant that helps you write code faster and with less effort." Functions across IDEs (real-time suggestions), GitHub Mobile (chat), GitHub CLI (command-line support), GitHub website, and Windows Terminal. For premium tiers (Pro/Business/Enterprise), can conduct research, draft code modifications, and generate pull requests for developer review.

### See Also

- [Copilot CLI invocation](#copilot-cli-invocation)

### Referenced By

- [FINDING-2026-04-08-6](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-6) - GitHub Copilot functionality

---

## Run keyword

**Captured:** 2026-04-09 00:00

Workflow step keyword that executes shell commands or scripts with configurable shell environments.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Workflow Syntax (run keyword)](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun) | PENDING | Pending verification |

### Description

The `run` keyword executes commands and scripts in workflow steps. Supported shells include bash (default on Linux/macOS), pwsh (PowerShell Core), python, cmd, and powershell. Default shell configured workflow-wide via `defaults.run.shell` or per-step via `shell` parameter. Default working directory set via `defaults.run.working-directory`.

### See Also

- [Steps](#steps)
- [Workflow file](#workflow-file)

### Referenced By

- [FINDING-2026-04-08-4](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-4) - Executing commands in workflow steps

---

## Steps

**Captured:** 2026-04-09 00:00

Individual tasks within a GitHub Actions job that execute sequentially, either running shell commands or invoking reusable actions.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Workflow Syntax (steps)](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idsteps) | PENDING | Pending verification |

### Description

Steps execute sequentially within a job. Each step can either run shell commands using the `run` keyword or execute reusable actions using the `uses` keyword. Steps can be given a `name` for display in GitHub interface. Jobs reference outputs and variables from other steps using expressions.

### See Also

- [Run keyword](#run-keyword)
- [Uses keyword](#uses-keyword)

### Referenced By

- [FINDING-2026-04-08-5](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-5) - Invoking custom actions and passing inputs

---

## Uses keyword

**Captured:** 2026-04-09 00:00

Workflow step keyword that invokes reusable custom actions with inputs passed via the `with` keyword.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Workflow Syntax (steps and uses)](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idsteps) | PENDING | Pending verification |

### Description

Custom actions are invoked in workflow steps using the `uses` keyword. Inputs are passed via the `with` keyword as key-value pairs. Example: `uses: ./.github/actions/my-action` with `with: token: ${{ secrets.access-token }}`. Enables reuse of custom action logic across multiple workflows and jobs.

### See Also

- [Custom actions](#custom-actions)
- [Steps](#steps)

### Referenced By

- [FINDING-2026-04-08-5](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-5) - Invoking custom actions and passing inputs

---

## Workflow file

**Captured:** 2026-04-09 00:00

YAML file stored in `.github/workflows/` directory that defines a GitHub Actions workflow configuration.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Workflow Syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions) | PENDING | Pending verification |

### Description

Workflow files use `.yml` or `.yaml` extensions and are stored in the `.github/workflows/` directory. Core properties: `name` (display name), `on` (triggering events), `run-name` (customises name for runs), `permissions` (token access levels), `env` (workflow-wide variables), `defaults` (default settings), `concurrency` (parallel execution management), `jobs` (parallel by default; use `needs` for sequential). Workflows execute on repository default branch for triggering to occur.

### See Also

- [Event triggers](#event-triggers)

### Referenced By

- [FINDING-2026-04-08-2](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-2) - Workflow file structure
- [FINDING-2026-04-08-3](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-3) - Event triggers and inputs

---

## Workflow_dispatch trigger

**Captured:** 2026-04-09 00:00

Event trigger enabling manual workflow execution from GitHub interface with custom input parameters.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows) | PENDING | Pending verification |

### Description

`workflow_dispatch` enables manual workflow triggering from GitHub Actions tab. Supports custom inputs defined with `inputs` keyword. Input values accessed via `inputs.<input-name>` context and `github.event.inputs`. The `inputs` context preserves Boolean values; `github.event.inputs` converts all to strings.

### See Also

- [Event triggers](#event-triggers)

### Referenced By

- [FINDING-2026-04-08-3](./copilot-cli/copilot-cli-facts.md#finding-2026-04-08-3) - Event triggers and inputs


