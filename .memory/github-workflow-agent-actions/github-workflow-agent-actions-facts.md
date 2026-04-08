# GitHub Workflow Agent Actions - Fact File

**Topic:** github-workflow-agent-actions

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** GitHub Actions overview and custom actions

**Observation:**

According to GitHub's official documentation, GitHub Actions are individual tasks that can be combined to create jobs and customise workflows. Actions are reusable components available from GitHub's community or developed privately.

Custom actions can be created through three approaches:
1. **Docker Container Actions** - Package environment and code for consistency; Linux-only on runners
2. **JavaScript Actions** - Execute directly on runner machines for faster performance; must be pure JavaScript
3. **Composite Actions** - Combine multiple workflow steps within one action

Action metadata files use YAML syntax with filenames `action.yml` or `action.yaml`, defining inputs, outputs, and configuration.

**Source:** [GitHub Actions — About Actions](https://docs.github.com/en/actions/creating-actions/about-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** GitHub Workflow file structure and core properties

**Observation:**

Workflow files are stored in `.github/workflows/` directory using `.yml` or `.yaml` extensions. Core workflow properties:

- **`name`** — Sets the workflow's display name in the Actions tab
- **`on`** — Defines triggering events via the `on` keyword; "To automatically trigger a workflow, use `on` to define which events can cause the workflow to run"
- **`run-name`** — Customises name shown for individual workflow runs (supports dynamic expressions)
- **`permissions`** — Controls `GITHUB_TOKEN` access levels (read, write, or none)
- **`env`** — Sets workflow-wide environment variables
- **`defaults`** — Establishes default settings like shell type and working directory
- **`concurrency`** — Manages parallel execution; ensures only one job with same concurrency group runs concurrently
- **`jobs`** — Contains jobs that run in parallel by default; use `jobs.<job_id>.needs` for sequential execution

**Source:** [GitHub Actions — Workflow Syntax](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Event triggers and custom inputs in workflows

**Observation:**

Workflows are triggered by events defined using the `on` keyword. Custom inputs can be defined for manual workflow dispatch:

```yaml
on:
  workflow_dispatch:
    inputs:
      logLevel:
        description: 'Log level'
        required: true
        default: 'warning'
        type: choice
```

Inputs are accessed via the `inputs` context: `${{ inputs.logLevel }}`. The `inputs` context preserves Boolean values as Booleans (not strings), whereas `github.event.inputs` converts all values to strings.

Environment variables defined with `env:` are accessed using shell syntax (e.g., `$LEVEL` or `$MESSAGE`).

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-4

**Topic:** Executing commands in workflow steps

**Observation:**

Commands and scripts in workflows are executed using the `run` keyword within job steps. Shell environments are specified via the `shell` parameter.

Supported shells:
- **bash** — Default on Linux/macOS; runs `bash --noprofile --norc -eo pipefail {0}`
- **pwsh** — PowerShell Core; runs `pwsh -command ". '{0}'"`
- **python** — Executes Python directly
- **cmd** — Windows Command Prompt
- **powershell** — PowerShell Desktop on Windows

Default shell can be configured workflow-wide using `defaults.run.shell` or per-step using the `shell` parameter. Default working directory is set via `defaults.run.working-directory`.

**Source:** [GitHub Actions — Workflow Syntax (`run` keyword)](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-5

**Topic:** Invoking custom actions and passing inputs to steps

**Observation:**

Custom actions are invoked in workflow steps using the `uses` keyword, and inputs are passed via the `with` keyword:

```yaml
- name: Pass the received secret to an action
  uses: ./.github/actions/my-action
  with:
    token: ${{ secrets.access-token }}
```

Steps execute sequentially within a job. Steps can either:
1. Run shell commands using the `run` keyword
2. Execute reusable actions using the `uses` keyword

Each step can be given a `name` for display in the GitHub interface. Jobs reference outputs and variables from other jobs using expressions.

**Source:** [GitHub Actions — Workflow Syntax (steps and uses)](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idsteps)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-6

**Topic:** GitHub Copilot functionality and GitHub integration

**Observation:**

GitHub Copilot is characterised as "an AI coding assistant that helps you write code faster and with less effort." It functions across multiple GitHub environments:

- IDEs (real-time code suggestions)
- GitHub Mobile (chat-based assistance)
- GitHub CLI (command-line support)
- GitHub website
- Windows Terminal

For premium tiers (Copilot Pro+, Business, Enterprise), Copilot can conduct research, draft code modifications, and generate pull requests for developer review. It can "generate descriptions of changes in a pull request."

**Source:** [GitHub Copilot — About GitHub Copilot](https://docs.github.com/en/copilot/about-github-copilot/what-is-github-copilot)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-7

**Topic:** Running GitHub Copilot CLI in GitHub Actions workflows

**Observation:**

GitHub Copilot CLI can be invoked directly in GitHub Actions workflows using the command syntax `copilot -p PROMPT [OPTIONS]`, enabling non-interactive programmatic execution without user input.

**Five-Step Setup Process:**

1. **Trigger** — Initiate workflow on schedule or manually via `on:` configuration
2. **Environment Preparation** — Checkout repository code and configure the runner with `actions/checkout@v4`
3. **Installation** — Install Copilot CLI globally: `npm install -g @github/copilot`
4. **Authentication** — Create a personal access token (PAT) with "Copilot Requests" permission and store as repository secret
5. **Authorization** — Set `COPILOT_GITHUB_TOKEN` environment variable within workflow step using the stored secret

**Workflow Step Syntax:**

```yaml
- name: Run Copilot CLI
  env:
    COPILOT_GITHUB_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
  run: copilot -p "YOUR_PROMPT" --allow-tool=[TOOLS] --no-ask-user
```

**Key Command Flags:**

- `--allow-tool='shell(git:*)'` — Enable Git commands
- `--allow-tool=write` — Permit file operations
- `--no-ask-user` — Prevent interactive prompts (required for automation)

CLI output can be captured and used in subsequent workflow steps.

**Source:** [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-8

**Topic:** Specifying model in Copilot CLI for GitHub Actions workflows

**Observation:**

GitHub Copilot CLI supports model specification via the `--model=<model>` flag. When running Copilot CLI in GitHub Actions workflows, you can specify which AI model to use through this flag.

**Configuration methods (in priority order):**

1. **Command-line flag:**
```bash
copilot -p "YOUR_PROMPT" --model claude-haiku-4.5 --no-ask-user
```

2. **Environment variable:**
```yaml
- name: Run Copilot with specific model
  env:
    COPILOT_GITHUB_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
    COPILOT_MODEL: claude-haiku-4.5
  run: copilot -p "YOUR_PROMPT" --no-ask-user
```

3. **Configuration file:**
Persists model preference in `~/.copilot/config.json`:
```json
{
  "model": "claude-haiku-4.5"
}
```

**Model selection priority in Copilot CLI:**
1. Custom agent definition (if applicable)
2. Command-line option (`--model=<model>`)
3. Environment variable (`COPILOT_MODEL`)
4. Configuration file (`~/.copilot/config.json`)
5. Default model (if none specified)

**Available models (examples from documentation):**
- `claude-haiku-4.5` — Fast, lower-cost option for straightforward tasks
- `claude-sonnet-4.6` — Standard Claude model
- `gpt-5.3-codex` — More powerful model for complex reasoning
- `gpt-5.2` — Alternative model

**Note:** Complete list of available models for your account can be found by running `copilot help` in your terminal.

**Applicable to workflows:**
When running Copilot CLI in GitHub Actions workflows (as shown in FINDING-2026-04-08-7), the `--model` flag can be included in the `run` command to specify which model Copilot should use for the prompt execution.

**Source:** [GitHub Docs — Copilot CLI Programmatic Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-09-1

**Topic:** Custom instructions configuration for Copilot CLI

**Observation:**

Official GitHub documentation references "custom instructions" for Copilot and describes them as a way to "give Copilot additional context on how to understand your project and how to build, test and validate its changes." Documentation mentions three levels:

1. **Personal instructions** — User-specific customization
2. **Repository instructions** — Project-specific context
3. **Organization instructions** — Organization-wide customization

However, **official GitHub documentation does not specify:**
- The exact file path or directory where Copilot CLI reads custom instructions
- Whether a command-line flag exists to specify an instructions folder
- The required file format or naming convention for instruction files
- How to configure Copilot CLI to read from a specific folder in workflows

**Investigation method:** Searched GitHub official documentation for:
- `docs.github.com/en/copilot/reference/copilot-cli-reference` — Lists available CLI flags but does not include custom instructions directory specification
- `docs.github.com/en/copilot/customizing-copilot` — Mentions custom instructions exist but references incomplete documentation pages

**Research status:** INCOMPLETE

Documentation references the feature but technical specifications are not available in GitHub's currently-accessible official documentation.

**Source:** [GitHub Docs — Copilot CLI Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference); [GitHub Docs — Customizing Copilot](https://docs.github.com/en/copilot/customizing-copilot)

**Date captured:** 2026-04-09

---
