# GitHub DevOps Workflow Actions — GitHub CLI Integration - Facts

**Topic:** github-devops-workflow-actions / Subtopic: github-cli

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** GitHub CLI preinstallation and setup requirement

**Introduces terms:** [GitHub CLI preinstallation](../github-devops-workflow-actions-terms.md#github-cli-preinstallation)

**Observation:**

GitHub CLI is preinstalled on all GitHub-hosted runners. No installation required. Only authentication setup via `GH_TOKEN` environment variable is needed.

**Source:** [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Authenticating GitHub CLI with GH_TOKEN in workflows

**Uses terms:** [`GH_TOKEN` environment variable](../github-devops-workflow-actions-terms.md#gh_token-environment-variable), [`GITHUB_TOKEN` automatic token](../github-devops-workflow-actions-terms.md#github_token-automatic-token)

**Observation:**

Set `GH_TOKEN` to `${{ secrets.GITHUB_TOKEN }}`. Token scopes inherited from job `permissions` configuration. GitHub CLI can execute API calls via `gh api` subcommand.

**Source:** [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Copilot CLI installation requirement vs GitHub CLI preinstallation

**Uses terms:** [npm installation of Copilot CLI](../github-devops-workflow-actions-terms.md#npm-installation-of-copilot-cli)

**Observation:**

Unlike GitHub CLI (preinstalled), Copilot CLI must be explicitly installed. Use `npm install -g @github/copilot` after `actions/setup-node`.

**Source:** [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions)

**Date captured:** 2026-04-08

---
