# Compose the Issue

## Check for Existing Issues

Before composing, search for existing open issues that match:

```
gh issue list --repo minouris/ai-devops --state open --search "<skill name OR rule name OR root cause keyword>"
```

An existing issue matches if it concerns the same skill, the same rule violation, or the same training or system prompt trigger.

If a match is found, compose only the **new information** not already present in the issue or its comments. You will append this as a comment in [submit-issue.md](submit-issue.md) instead of creating a new issue.

## Title

```
AI Problem: <concise description of the violation>
```

## Body

````markdown
## Incident Summary

<What was being attempted and what went wrong>

## Skill Context

<If a skill was active: name, path, and link to skill file. Otherwise: "No skill was active.">

## What Was Attempted

<The task or operation being performed>

## What the User Disagreed With

<The specific action, output, or claim identified as wrong>

## Why This Was a Violation

<How this contradicts rules, instructions, or expectations>

## Rule Violations

### Rule: <rule name>

**Source:** `<file path>`

**Rule text:**
> <exact quote of the violated rule>

**Loophole or mechanism that allowed the violation:**
<Explanation of how the rule was circumvented or failed to prevent the problem>

## Contributing Factors

<Training tendencies, system prompt conflicts, context issues, or recovered system prompt excerpts — paste verbatim; do not reference internal skill file names or paths>

## Root Cause Classification

- **cause: <label>**: <one sentence explaining why this label applies>
````

## Sub-Issues

Pass the main issue number and the list of cause labels to [check-sub-issues.md](../../analyse-ai-problem/references/check-sub-issues.md) to check for existing sub-issues and compose new sub-issue bodies.

## Data Exclusion

**MUST NOT include:**
- Personal or identifying data (names, emails, accounts)
- Secrets, tokens, API keys, or credentials
- File paths that are not part of AI configuration or training
- Internal skill library file paths or file names (e.g. `root_cause_definitions.md`, `check-sub-issues.md`) — inline quoted text directly without file attribution

**MAY include:**
- Paths to AI configuration files (`CLAUDE.md`, `.claude/`, `src/claude/rules/`)
- Paths to skill files (`.claude/skills/`)
- Rule names and rule text
- Root cause labels and descriptions

Output of this flow is passed to [present-report.md](present-report.md).
