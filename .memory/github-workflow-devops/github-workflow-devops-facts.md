# GitHub Workflow DevOps - Fact File

**Topic:** github-workflow-devops

**Status:** Research in progress

---

## FINDING-2026-04-08-1

**Topic:** GitHub CLI preinstallation and setup requirement

**Introduces terms:** [GitHub CLI preinstallation](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#github-cli-preinstallation)

**Observation:**

GitHub CLI (`gh`) is preinstalled on all GitHub-hosted runners, eliminating the need for explicit installation steps in workflows. The only requirement for using GitHub CLI in workflows is authentication setup.

**Key implication:**
No installation step is required when running on GitHub-hosted runners. Actions can immediately use GitHub CLI commands without installing the tool.

**Authentication requirement:**
To use GitHub CLI in workflows, an environment variable must be set for each step that uses it: `GH_TOKEN` must be provided with a token that has the required scopes.

**Source:** [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Authenticating GitHub CLI with GH_TOKEN in workflows

**Uses terms:** [`GH_TOKEN` environment variable](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#gh_token-environment-variable), [`GITHUB_TOKEN` automatic token](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#github_token-automatic-token)

**Observation:**

GitHub CLI in workflows is authenticated by setting the `GH_TOKEN` environment variable. The typical pattern is to set `GH_TOKEN` to `${{ secrets.GITHUB_TOKEN }}`, which is the automatic token available in GitHub Actions.

**Basic usage pattern:**
```yaml
- run: gh issue comment $ISSUE --body "comment text"
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    ISSUE: ${{ github.event.issue.html_url }}
```

**Requirements:**
- Set `GH_TOKEN` environment variable for each step using GitHub CLI
- Token must have required scopes for the operations being performed
- Typically use `secrets.GITHUB_TOKEN` (automatic token) for authentication

**Scope integration:**
The token's scopes determine what GitHub CLI operations are available. The automatic `GITHUB_TOKEN` inherits permissions from the workflow job's permission configuration (e.g., `issues: write`).

**Advanced capability:**
GitHub CLI can execute API calls via `gh api` subcommand, enabling GraphQL queries, result parsing, and passing data to subsequent workflow steps.

**Source:** [GitHub Docs — Use GitHub CLI in GitHub Actions workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-github-cli)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Copilot CLI installation requirement vs GitHub CLI preinstallation

**Uses terms:** [npm installation of Copilot CLI](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#npm-installation-of-copilot-cli)

**Observation:**

Unlike GitHub CLI, which is preinstalled on all GitHub-hosted runners, Copilot CLI is NOT preinstalled and must be explicitly installed in workflows.

**Key difference:**
- **GitHub CLI** — Preinstalled on all GitHub-hosted runners; only requires authentication
- **Copilot CLI** — Must be explicitly installed; then requires authentication

**Installation requirement:**
You must install Copilot CLI on the runner before use. The documentation explicitly states: "You must install Copilot CLI on the runner so your workflow can invoke it as a command."

**Installation method:**
Using npm (requires Node.js in the environment):
```yaml
- run: npm install -g @github/copilot
```

**Complete workflow pattern:**
```yaml
- uses: actions/setup-node@v4
- run: npm install -g @github/copilot
- run: copilot -p "YOUR_PROMPT" --no-ask-user
  env:
    COPILOT_GITHUB_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
```

**Source:** [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions)

**Date captured:** 2026-04-08

---

