# GitHub DevOps Workflow Actions — Workflow Execution Fundamentals - Facts

**Topic:** github-devops-workflow-actions / Subtopic: workflow-execution

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** GitHub Actions overview and custom actions

**Introduces terms:** [Custom actions](../github-devops-workflow-actions-terms.md#custom-actions)

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

**Introduces terms:** [Workflow file](../github-devops-workflow-actions-terms.md#workflow-file)

**Observation:**

Workflow files are stored in `.github/workflows/` directory using `.yml` or `.yaml` extensions. Core workflow properties include `name`, `on`, `run-name`, `permissions`, `env`, `defaults`, `concurrency`, and `jobs`.

**Source:** [GitHub Actions — Workflow Syntax](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Event triggers and custom inputs in workflows

**Uses terms:** [Event triggers](../github-devops-workflow-actions-terms.md#event-triggers), [Workflow_dispatch trigger](../github-devops-workflow-actions-terms.md#workflow_dispatch-trigger)

**Observation:**

Workflows are triggered by events defined using the `on` keyword. The `inputs` context preserves Boolean values; `github.event.inputs` converts all to strings.

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-4

**Topic:** Executing commands in workflow steps

**Introduces terms:** [Run keyword](../github-devops-workflow-actions-terms.md#run-keyword)

**Observation:**

Commands and scripts use the `run` keyword with configurable shell environments (bash, pwsh, python, cmd, powershell).

**Source:** [GitHub Actions — Workflow Syntax (run keyword)](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-5

**Topic:** Invoking custom actions and passing inputs to steps

**Uses terms:** [Uses keyword](../github-devops-workflow-actions-terms.md#uses-keyword), [Steps](../github-devops-workflow-actions-terms.md#steps)

**Observation:**

Custom actions are invoked using `uses` keyword; inputs passed via `with` keyword. Steps execute sequentially within a job.

**Source:** [GitHub Actions — Workflow Syntax (steps and uses)](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#jobsjob_idsteps)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-6

**Topic:** GitHub Copilot functionality and GitHub integration

**Introduces terms:** [GitHub Copilot](../github-devops-workflow-actions-terms.md#github-copilot)

**Observation:**

GitHub Copilot is an AI coding assistant functioning across IDEs, GitHub Mobile, GitHub CLI, GitHub website, and Windows Terminal.

**Source:** [GitHub Copilot — About GitHub Copilot](https://docs.github.com/en/copilot/about-github-copilot/what-is-github-copilot)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-7

**Topic:** Running GitHub Copilot CLI in GitHub Actions workflows

**Uses terms:** [Copilot CLI invocation](../github-devops-workflow-actions-terms.md#copilot-cli-invocation), [`--no-ask-user` flag](../github-devops-workflow-actions-terms.md#--no-ask-user-flag), [`COPILOT_GITHUB_TOKEN` environment variable](../github-devops-workflow-actions-terms.md#copilot_github_token-environment-variable), [npm installation of Copilot CLI](../github-devops-workflow-actions-terms.md#npm-installation-of-copilot-cli)

**Observation:**

GitHub Copilot CLI can be invoked directly in workflows using `copilot -p PROMPT [OPTIONS]` for non-interactive execution.

**Source:** [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions)

**Date captured:** 2026-04-08

---
