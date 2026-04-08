# GitHub Workflow Agent Actions - Topic Index

**Topic Slug:** github-workflow-agent-actions

**Topic Name:** Running a GitHub Copilot prompt as a GitHub Actions workflow action

**Created:** 2026-04-07

---

## Knowledge Summary

Research into executing GitHub Copilot prompts as GitHub Actions workflow steps. The authoritative approach is via Copilot CLI command invocation within workflow steps, not through the Claude Agent SDK or external actions.

---

## Research Areas

- Copilot CLI invocation syntax and command options
- Authentication mechanism (personal access token with "Copilot Requests" permission)
- Installation and setup in workflow environments
- Tool restrictions and automation flags (`--no-ask-user`, `--allow-tool`)
- Output capture and integration with subsequent workflow steps

---

## Key Concepts

- **GitHub Copilot CLI** — Command-line interface for Copilot accessible via `copilot -p PROMPT` in workflows
- **Copilot Request Token (PAT)** — Personal access token with "Copilot Requests" permission for authentication
- **GitHub Actions** — Workflow automation platform with support for environment variables, secrets, and step execution
- **Workflow steps** — Individual tasks in a job; can run shell commands or invoke actions

---

## Research Progress

**Total Findings Captured:** 7

| Finding | Topic | Status |
|---------|-------|--------|
| FINDING-2026-04-08-1 | GitHub Actions overview and custom actions | Captured |
| FINDING-2026-04-08-2 | Workflow file structure and core properties | Captured |
| FINDING-2026-04-08-3 | Event triggers and custom inputs | Captured |
| FINDING-2026-04-08-4 | Command execution in workflow steps | Captured |
| FINDING-2026-04-08-5 | Invoking custom actions and passing inputs | Captured |
| FINDING-2026-04-08-6 | GitHub Copilot integration (initial) | Captured |
| FINDING-2026-04-08-7 | Copilot CLI invocation in workflows (AUTHORITATIVE) | Captured |

**Previous Findings:** 6 findings (FINDING-2026-04-07-1 through 6) archived to `-facts-disproven.md` after identifying external project sources

**Files:**
- Main facts: [github-workflow-agent-actions-facts.md](github-workflow-agent-actions-facts.md)
- Disproven: [github-workflow-agent-actions-facts-disproven.md](github-workflow-agent-actions-facts-disproven.md)
- Operation log: [github-workflow-agent-actions-log.md](github-workflow-agent-actions-log.md)

**Status:** COMPLETE

**Key Solution (from GitHub official documentation):**

Run GitHub Copilot prompts in workflows via Copilot CLI:

```yaml
- name: Run Copilot CLI
  env:
    COPILOT_GITHUB_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
  run: copilot -p "YOUR_PROMPT" --allow-tool=write --no-ask-user
```

Setup:
1. Install: `npm install -g @github/copilot`
2. Authenticate: Create PAT with "Copilot Requests" permission
3. Set `COPILOT_GITHUB_TOKEN` environment variable
4. Invoke: `copilot -p "PROMPT" --allow-tool=[TOOLS] --no-ask-user`

Source: [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions)

---


