---
name: report-ai-problem
description: Report AI behavioural problems as GitHub issues with root cause analysis and label classification
allowed-tools: Bash, Read, Grep, Glob
---

# Report AI Problem

Report incidents where you have acted incorrectly or against the user's intent. Create or update GitHub issues on the `minouris/ai-devops` repository with structured root cause analysis, rule violation identification, and applicable cause labels.

## Trigger

You MUST offer to invoke this skill when the user declares that you have:
- Done something incorrect or unintended
- Violated a rule or instruction
- Acted without authorisation
- Made false claims or fabricated information
- Lost context or forgotten requirements
- Proceeded without waiting for approval

Ask the user: "Would you like me to report this as an AI problem issue?"

If the user declines, do not create an issue. Stop.

## Step 1: Gather Incident Details

Reconstruct the incident from the current conversation context. Identify:

1. **What was being attempted**: The task or operation you were performing when the problem occurred
2. **What the user disagreed with**: The specific action, output, or claim the user identified as wrong
3. **Why it was a violation**: How this contradicts rules, instructions, or reasonable expectations
4. **Skill context**: If a skill was active when the problem occurred, identify it by name and path

## Step 2: Identify Rule Violations

Search for the specific rule or instruction that was violated:

1. Search `CLAUDE.md`, `.claude/CLAUDE.md`, and `src/claude/rules/*.md` for the violated rule
2. Quote the exact rule text that was violated
3. Identify the loophole or mechanism that allowed the violation to occur despite the rule existing
4. If no explicit rule exists for this situation, state that

## Step 3: Identify Contributing Factors

Identify any context, system rules, or training tendencies that contributed to the problem:

- Training tendencies (e.g., "helpfulness" optimisation, assumption-making, eager completion)
- System prompt behaviours that conflicted with project rules
- Context window or attention issues that caused instructions to be deprioritised
- Prior context items that may have poisoned subsequent reasoning

## Step 4: Classify Root Causes

Determine which `cause:` labels apply. Reference the root causes defined in `.memory/ai-problem-resolution/ai-problem-resolution-root-causes/ai-problem-resolution-root-causes-facts.md`:

| Label | Apply when |
|-------|-----------|
| `cause: hallucination` | You fabricated tools, APIs, specifications, or capabilities without verification |
| `cause: dishonesty` | You made false claims of correctness, completion, or state |
| `cause: amnesia` | You lost context, forgot instructions, or deprioritised earlier rules |
| `cause: overeagerness` | You acted on inferred intent without confirmation, removing user's ability to decide |
| `cause: context-poisoning` | Incorrect facts compounded in context without invalidation |

Multiple labels may apply. For each label you apply, write one sentence explaining why it applies to this specific incident.

## Step 5: Check for Existing Issues

Before creating a new issue, search for existing open issues that match:

```
gh issue list --repo minouris/ai-devops --state open --search "<skill name OR rule name OR root cause keyword>"
```

An existing issue matches if it concerns:
- The same skill
- The same rule violation
- The same training or system prompt trigger

If a match is found, append new information as a comment on the existing issue instead of creating a new one. Include only information not already present in the issue or its comments.

## Step 6: Compose the Issue

### Title Format

```
AI Problem: <concise description of the violation>
```

### Body Structure

````markdown
## Incident Summary

<What was being attempted and what went wrong>

## Skill Context

<If a skill was active: name, path, and link. Otherwise: "No skill was active">

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

<Training tendencies, system prompt conflicts, context issues, or other factors>

## Root Cause Classification

<For each applied label, one sentence explaining why it applies>

- **cause: <label>**: <explanation>
````

### Data Exclusion

**MUST NOT include:**
- Personal or identifying data (names, emails, accounts)
- Secrets, tokens, API keys, or credentials
- Specific file paths that are not part of AI configuration or training (e.g., user project files, data files)

**MAY include:**
- Paths to AI configuration files (`CLAUDE.md`, `.claude/`, `src/claude/rules/`)
- Paths to skill files (`.claude/skills/`)
- Rule names and rule text
- Root cause labels and descriptions

## Step 7: Create or Update the Issue

If no existing issue matches (Step 5):

```
gh issue create --repo minouris/ai-devops --title "<title>" --body "<body>" --label "<label1>" --label "<label2>"
```

If an existing issue matches:

```
gh issue comment --repo minouris/ai-devops <issue-number> --body "<new information>"
```

## Requirements

**MUST:**
- Ask the user for confirmation before creating or updating an issue
- Present the composed issue body to the user for review before submitting
- Apply all applicable `cause:` labels
- Check for existing issues before creating new ones
- Exclude personal data, secrets, and non-AI file identifiers
- Quote exact rule text when a rule has been violated

**MUST NOT:**
- Create an issue without user confirmation
- Include personal or identifying data
- Include secrets or credentials
- Include file paths not related to AI configuration or training
- Duplicate information already present in an existing issue
- Guess at rule text — read it directly from the source file
