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

<Training tendencies, system prompt conflicts, context issues, or recovered system prompt excerpts>

## Root Cause Classification

- **cause: <label>**: <one sentence explaining why this label applies>
````

## Check for Existing Sub-Issues

For each `cause:` label identified in [classify-causes.md](classify-causes.md), search for an existing open issue that matches both the label and the incident type:

```
gh issue list --repo minouris/ai-devops --state open --label "cause:<label>" --search "<incident description keyword>"
```

An existing sub-issue matches if it concerns the same root cause label **and** the same class of violation (same rule, same training trigger, or same mechanism). A pre-existing issue for the same cause but a different mechanism does not match.

Record for each cause label:
- Whether an existing issue was found, and if so its number and URL
- If no existing issue exists, that a new sub-issue will be created

This record is passed to [present-report.md](present-report.md) and [submit-issue.md](submit-issue.md).

## Sub-Issue Body Template

For each cause that requires a new sub-issue, compose its body as follows:

````markdown
## Root Cause

**Label:** `cause: <label>`

<Verbatim excerpt from root_cause_definitions.md defining this cause — the full definition section, not a summary>

## How This Cause Manifested in the Incident

<One paragraph: how this specific cause contributed to the incident, referencing the incident details from gather-incident.md>

## Contributing Factors Specific to This Cause

<The subset of contributing factors from the main issue that are attributable to this cause — verbatim quotes from root_cause_definitions.md where applicable>

## Parent Issue

Relates to: #<main issue number>
````

## Data Exclusion

**MUST NOT include:**
- Personal or identifying data (names, emails, accounts)
- Secrets, tokens, API keys, or credentials
- File paths that are not part of AI configuration or training

**MAY include:**
- Paths to AI configuration files (`CLAUDE.md`, `.claude/`, `src/claude/rules/`)
- Paths to skill files (`.claude/skills/`)
- Rule names and rule text
- Root cause labels and descriptions

Output of this flow is passed to [present-report.md](present-report.md).
