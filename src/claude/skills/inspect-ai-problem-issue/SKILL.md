---
name: inspect-ai-problem-issue
description: Inspect a GitHub issue that has a cause: label but was not created by report-ai-problem. Diagnoses the AI behavioural problem described in the issue, appends structured findings as a comment, applies additional cause labels, and creates or links sub-issues for each identified cause.
allowed-tools: Bash, Read, Grep, Glob
---

# Inspect AI Problem Issue

Analyse an existing GitHub issue that identifies an AI behavioural problem and was not already processed by `report-ai-problem`. Append diagnostic findings, apply additional labels, and create or link sub-issues.

## Label Taxonomy

All labels used by this skill are defined in the [ai-problem-taxonomy](../ai-problem-taxonomy/SKILL.md) reference skill. Root cause labels must use the format `cause: <label>` (with a space after the colon).

## Trigger

Invoke this skill when:
- Given an issue number to inspect, OR
- A GitHub Action triggers on `labeled` event with a `cause:` label where the issue lacks `created-by: report-ai-problem`

## Arguments

`$ARGS` — the issue number to inspect (e.g. `42`)

## Workflow

Execute the following flows in order:

1. **Fetch and validate the issue** — see [fetch-issue.md](references/fetch-issue.md)
2. **Identify rule violations and contributing factors** — see [identify-violations.md](../analyse-ai-problem/references/identify-violations.md)
3. **Classify root causes** — see [classify-causes.md](../analyse-ai-problem/references/classify-causes.md)
4. **Check sub-issues and compose bodies** — see [check-sub-issues.md](../analyse-ai-problem/references/check-sub-issues.md)
5. **Compose the findings comment** — see [compose-findings.md](references/compose-findings.md)
6. **Submit findings, labels, and sub-issues** — see [submit-findings.md](references/submit-findings.md)

## Requirements

**MUST:**
- Complete all flows before writing to GitHub
- Stop at step 1 if the issue has already been analysed (existing analysis comment found) or does not qualify
- Apply all newly identified `cause:` labels not already present on the issue
- Follow the same duplicate checking as `report-ai-problem` when creating sub-issues

**MUST NOT:**
- Skip any flow
- Duplicate an analysis comment if one already exists
- Apply `created-by: report-ai-problem` to issues or sub-issues — use `created-by: inspect-ai-problem-issue` instead
- Include personal data, secrets, or non-AI file identifiers in comments or sub-issues
