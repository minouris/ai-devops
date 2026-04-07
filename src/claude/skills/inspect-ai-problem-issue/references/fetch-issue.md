# Fetch and Validate Issue

Retrieve the issue specified in `$ARGS` and confirm it qualifies for inspection.

## Fetch

```
gh issue view $ARGS \
  --repo minouris/ai-devops \
  --json number,title,body,labels,comments,url
```

Record the issue number, title, body, URL, current labels, and existing comments.

## Qualification Checks

**Stop and exit** if any of the following are true:

1. **Already created by the skill:** The issue has label `created-by: report-ai-problem` — it was created by the report-ai-problem skill and is already fully structured; no inspection needed.

2. **No cause label:** The issue has no `cause:` label — it has not been identified as an AI problem issue; this skill does not apply.

3. **Already inspected:** The issue has an existing comment containing the heading `## AI Problem Analysis — inspect-ai-problem-issue` — this skill has already run on this issue; do not duplicate.

**Proceed** if:
- The issue has at least one `cause:` label
- It lacks `created-by: report-ai-problem`
- No previous analysis comment exists

## Extract Incident Description

From the issue body, identify:

1. **What was being attempted** — the task or operation described
2. **What the AI did wrong** — the specific action, output, or claim identified as wrong
3. **Why it was a violation** — how this contradicts rules, instructions, or expectations
4. **Any skill context** — if a skill is named in the issue

Record these as the incident context for use in subsequent flows.
