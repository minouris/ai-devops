---
name: ai-problem-inspect-issue
description: Inspect a GitHub issue that has a cause: label but was not created by ai-problem-report. Diagnoses the AI behavioural problem described in the issue, appends structured findings as a comment, applies additional cause labels, and creates or links sub-issues for each identified cause.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob
---

# Inspect AI Problem Issue

Analyse an existing GitHub issue that identifies an AI behavioural problem and was not already processed by `ai-problem-report`. Append diagnostic findings, apply additional labels, and create or link sub-issues.

## Label Taxonomy

All labels used by this skill are defined in the [ai-problem-taxonomy](../ai-problem-taxonomy/SKILL.md) reference skill. Root cause labels must use the format `cause: <label>` (with a space after the colon).

## Trigger

Invoke this skill when:
- Given an issue number to inspect, OR
- A GitHub Action triggers on `labeled` event with a `cause:` label where the issue lacks `created-by: ai-problem-report`

## Arguments

`$ARGS` — the issue number to inspect (e.g. `42`)

## Workflow

Execute the following flows in order:

1. **Fetch and validate the issue** — see [fetch-issue.md](references/fetch-issue.md)
2. **Identify rule violations and contributing factors** — see [ai-problem-identify-violations](../ai-problem-identify-violations/SKILL.md)
3. **Classify root causes** — see [ai-problem-classify-causes](../ai-problem-classify-causes/SKILL.md)
4. **Check sub-issues and compose bodies** — see [ai-problem-check-sub-issues](../ai-problem-check-sub-issues/SKILL.md)
5. **Compose the findings comment** — see [compose-findings.md](references/compose-findings.md)
6. **Submit findings, labels, and sub-issues** — see [submit-findings.md](references/submit-findings.md)

## Requirements

**MUST:**
- Complete all flows before writing to GitHub
- Stop at step 1 if the issue has already been analysed (existing analysis comment found) or does not qualify
- Apply all newly identified `cause:` labels not already present on the issue
- Apply `inspected-by: ai-problem-inspect-issue` label after successful completion (see [submit-findings.md](references/submit-findings.md) Step 4)
- Follow the same duplicate checking as `ai-problem-report` when creating sub-issues

**MUST NOT:**
- Skip any flow
- Duplicate an analysis comment if one already exists
- Apply `created-by: ai-problem-report` to issues or sub-issues — use `created-by: ai-problem-inspect-issue` instead
- Include personal data, secrets, or non-AI file identifiers in comments or sub-issues
