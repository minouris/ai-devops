# Present Report

Output the full analysis to the user in chat before any GitHub action is taken.

## Output the Analysis

Present the following in chat, in this order:

### Incident Summary

State what was being attempted and what went wrong.

### Skill Context

State the active skill name and path, or "No skill was active."

### What Was Attempted

State the task or operation being performed.

### What the User Disagreed With

State the specific action, output, or claim identified as wrong.

### Why This Was a Violation

Explain how this contradicts rules, instructions, or expectations.

### Rule Violations

For each violated rule:

- **Rule:** `<rule name>`
- **Source:** `<file path>`
- **Rule text:** exact quote
- **Loophole:** how the rule was circumvented or failed to prevent the problem

### Contributing Factors

List training tendencies, system prompt conflicts, context issues, or recovered system prompt excerpts.

### Root Cause Classification

List each applicable `cause:` label with one sentence explaining why it applies.

## Show Existing Main Issue

If a matching issue was found in [compose-issue.md](compose-issue.md):

- Display the issue number, title, and URL
- State that the composed content will be appended as a new comment

If no matching issue was found:

- State that a new issue will be created

## Show Planned Sub-Issues

For each `cause:` label identified in the classify-ai-problem-causes skill, show one row:

| Cause label | Action | Existing issue |
|-------------|--------|----------------|
| `cause: <label>` | Create new sub-issue | — |
| `cause: <label>` | Link existing issue as sub-issue | #N — <title> (<url>) |

- **Create new sub-issue** — no matching issue was found; a new issue will be created and linked as a child of the main issue
- **Link existing issue as sub-issue** — a matching issue was found; it will be linked as a child of the main issue without duplication

## Ask for Confirmation

Ask the user the following, covering both the main issue and all sub-issues:

**New main issue:**
> "Would you like me to create a new GitHub issue for this incident, plus sub-issues for each root cause?"

**Existing main issue:**
> "Would you like me to append this as a comment on issue #N, and create or link sub-issues for each root cause?"

**MUST NOT** proceed to [submit-issue.md](submit-issue.md) unless the user explicitly confirms.

If the user declines, stop.
