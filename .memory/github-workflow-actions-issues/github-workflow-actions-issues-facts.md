# GitHub Workflow Actions Issues - Fact File

## FINDING-2026-04-07-1

**Topic:** GitHub Actions trigger

**Observation:**
The `issues` event in GitHub Actions supports 18 activity types. The `opened` type fires when a new issue is first created. The `labeled` type fires when any label is added to an issue. For triggering only when an AI-cause label is applied, `types: [labeled]` is the correct trigger. The workflow file must exist on the **default branch** for issue-event triggers to work. `github.event.issue.number`, `github.event.issue.title`, `github.event.issue.body`, and `github.event.issue.user.login` are available as expressions in the workflow.

**Source:** [GitHub Actions — Events that trigger workflows: issues](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#issues)

**Date captured:** 2026-04-07

---

## FINDING-2026-04-07-2

**Topic:** Claude Code Action inputs

**Observation:**
The action `anthropics/claude-code-action@v1` accepts a `prompt` input for automated (non-interactive) mode. Tool access is configured via `claude_args: "--allowedTools Tool1,Tool2"` — the former `allowed_tools` input is deprecated. Authentication is via `anthropic_api_key` (Anthropic API key secret) or `claude_code_oauth_token`. No inputs are marked required; `anthropic_api_key` is required in practice unless using a cloud provider. The `settings` input accepts a JSON string or path to a JSON settings file for further Claude Code configuration.

**Source:** [anthropics/claude-code-action — action.yml](https://github.com/anthropics/claude-code-action/blob/main/action.yml); [docs/usage.md](https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md)

**Date captured:** 2026-04-07

---

## FINDING-2026-04-07-3

**Topic:** Skill invocation in automated mode

**Observation:**
Claude Code skills are invoked with `/skill-name` syntax and support `$ARGUMENTS` substitution for arguments. In GitHub Actions automated mode, the `prompt` input is processed by Claude Code, which has all project skills (`.claude/skills/`) available in its context. You can instruct Claude to invoke a specific skill by including `/skill-name <args>` in the `prompt`, or by describing the task in natural language and letting Claude match it to the skill description. When a skill is invoked with arguments, `$ARGUMENTS` in `SKILL.md` is substituted with those arguments; if `$ARGUMENTS` is absent, arguments are appended as `ARGUMENTS: <value>`.

**Source:** [Claude Code Skills documentation](https://code.claude.com/docs/en/skills)

**Date captured:** 2026-04-07

---

## FINDING-2026-04-07-4

**Topic:** GitHub token permissions for issue operations

**Observation:**
To read and modify issues, the workflow job requires `issues: write` permission on `GITHUB_TOKEN`. `contents: read` is needed to read repository files including skill definitions. `id-token: write` is required for OIDC-based authentication. These permissions are declared under the `permissions:` key at the job level. The official issue-triage example from `docs/solutions.md` uses exactly `issues: write` and `id-token: write` with no `pull-requests` permission.

**Source:** [anthropics/claude-code-action — docs/solutions.md](https://github.com/anthropics/claude-code-action/blob/main/docs/solutions.md)

**Date captured:** 2026-04-07

---

## FINDING-2026-04-07-5

**Topic:** Checkout requirement

**Observation:**
An `actions/checkout@v4` step is required before the Claude Code Action step in order for Claude to have access to repository files, including `.claude/skills/` skill definitions and any scripts referenced by the skill. Without checkout, Claude runs in an empty workspace and cannot read or invoke project skills.

**Source:** [anthropics/claude-code-action — docs/solutions.md](https://github.com/anthropics/claude-code-action/blob/main/docs/solutions.md) — issue triage YAML example includes `actions/checkout@v4`

**Date captured:** 2026-04-07

---

## FINDING-2026-04-07-6

**Topic:** Verified workflow YAML for inspect-ai-problem-issue trigger

**Observation:**
The following workflow pattern triggers the `inspect-ai-problem-issue` skill when a `cause:` label is added to any issue. Triggering on `labeled` (rather than `opened`) is correct because the skill requires a `cause:` label to be present — the skill's own `fetch-issue.md` flow stops if no `cause:` label is found. The skill is invoked by passing `/inspect-ai-problem-issue ${{ github.event.issue.number }}` in the prompt, substituting the issue number via `$ARGUMENTS`. The `--allowedTools` flag must include `Bash,Read,Grep,Glob` to match the skill's `allowed-tools` frontmatter declaration.

```yaml
name: Inspect AI Problem Issue
on:
  issues:
    types: [labeled]

jobs:
  inspect:
    runs-on: ubuntu-latest
    permissions:
      issues: write
      contents: read
      id-token: write
    steps:
      - uses: actions/checkout@v4
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          prompt: /inspect-ai-problem-issue ${{ github.event.issue.number }}
          claude_args: --allowedTools Bash,Read,Grep,Glob
```

The skill's own qualification checks (FINDING-2026-04-07-1) handle cases where the labeled event fires for a non-`cause:` label or an already-analysed issue — the skill exits early in those cases.

**Source:** [anthropics/claude-code-action — docs/solutions.md](https://github.com/anthropics/claude-code-action/blob/main/docs/solutions.md); [Claude Code Skills documentation](https://code.claude.com/docs/en/skills)

**Date captured:** 2026-04-07

---
