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

## Show Existing Issues

If a matching issue was found in [compose-issue.md](compose-issue.md):

- Display the issue number, title, and URL
- State that the composed content will be appended as a new comment

If no matching issue was found:

- State that a new issue will be created

## Ask for Confirmation

Ask the user one of the following, depending on whether an existing issue was found:

**New issue:**
> "Would you like me to create a new GitHub issue for this incident?"

**Existing issue:**
> "Would you like me to append this as a comment on issue #N?"

**MUST NOT** proceed to [submit-issue.md](submit-issue.md) unless the user explicitly confirms.

If the user declines, stop.
