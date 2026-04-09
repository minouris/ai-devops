---
name: ai-problem-check-sub-issues
description: Shared diagnostic flow for checking and composing sub-issues for root causes. Called by report-ai-problem and inspect-ai-problem-issue — not user-invocable directly.
user-invocable: false
allowed-tools: Bash, Read, Grep, Glob
---

# Check Sub-Issues

This is a library skill. It is called from within the workflows of `report-ai-problem` and `inspect-ai-problem-issue` to check for duplicate sub-issues and compose bodies for new ones.

## Label Taxonomy Reference

Use the label format `cause: <label>` (with a space after the colon) as defined in the [ai-problem-taxonomy](../ai-problem-taxonomy/SKILL.md).

## Duplicate Check

For each `cause:` label identified in the root cause classification step, check for an existing open issue that already covers this cause in the context of the current incident:

```
gh issue list \
  --repo minouris/ai-devops \
  --state open \
  --label "cause: <label>" \
  --search "<incident description keyword>"
```

An existing sub-issue matches if it concerns the **same root cause label** and the **same class of violation** — i.e., the same rule, the same training trigger, or the same mechanism. A pre-existing issue for the same cause but a different mechanism does not match.

**Record for each cause label:**
- Whether an existing issue was found, and if so its number, title, and URL
- If no existing issue was found, that a new sub-issue will be created

## Sub-Issue Body Composition

For each cause that requires a new sub-issue, compose its body using this template:

```markdown
## Root Cause

**Label:** `cause: <label>`

<Verbatim excerpt defining this cause — the full definition section, not a summary>

## How This Cause Manifested in the Incident

<One paragraph: how this specific cause contributed to the incident, referencing the incident context>

## Contributing Factors Specific to This Cause

<The subset of contributing factors attributable to this cause — verbatim quotes where applicable>

## Parent Issue

Relates to: #<main issue number>
```

**IMPORTANT:**
- Do NOT name file paths (e.g., "root_cause_definitions.md") in issue bodies — readers will not have access to these files
- Include full definition text verbatim, not summaries or paraphrases

## Output

Pass the following summary to the calling skill:

| Cause label | Action | Existing issue |
|-------------|--------|----------------|
| `cause: <label>` | Create new sub-issue | — |
| `cause: <label>` | Link existing issue as sub-issue | #N — <title> (<url>) |

Include composed sub-issue body for each new issue to be created.
