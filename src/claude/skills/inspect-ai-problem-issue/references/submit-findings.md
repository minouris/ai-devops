# Submit Findings

Write all outputs to GitHub. Execute the following steps in order.

## Step 1: Append Analysis Comment

```
gh issue comment $ARGS \
  --repo minouris/ai-devops \
  --body-file <path to composed comment from compose-findings.md>
```

## Step 2: Apply New Labels

For each `cause:` label identified in [classify-causes.md](../../analyse-ai-problem/references/classify-causes.md) that is **not already on the issue**:

```
gh issue edit $ARGS \
  --repo minouris/ai-devops \
  --add-label "cause:<label>"
```

## Step 3: Create or Link Sub-Issues

For each cause label, use the result from [check-sub-issues.md](../../analyse-ai-problem/references/check-sub-issues.md).

### Create a new sub-issue

When no existing issue was found for this cause:

```
gh issue create \
  --repo minouris/ai-devops \
  --title "AI Problem: cause:<label> — <brief description of how this cause manifested>" \
  --body-file <path to composed sub-issue body> \
  --label "cause:<label>" \
  --label "created-by: inspect-ai-problem-issue"
```

Record the new sub-issue number as `<sub_issue_number>`.

### Link an existing issue as sub-issue

When an existing issue was found for this cause, use its number directly as `<sub_issue_number>`. Do not create a new issue or append a comment unless the existing issue does not already reference the inspected issue.

### Add as child of inspected issue

After creating or identifying each sub-issue, retrieve its database ID and link it as a child:

```
gh api /repos/minouris/ai-devops/issues/<sub_issue_number> --jq '.id'
```

```
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/minouris/ai-devops/issues/$ARGS/sub_issues \
  -F sub_issue_id=<database_id>
```

**MUST** use `-F` (not `-f`) for `sub_issue_id` — GitHub API requires an integer, not a string.

Repeat for every cause label. Each cause becomes a separate child issue under the inspected issue.

## Step 4: Mark As Inspected

After all analysis is complete, apply the inspection completion label:

```
gh issue edit $ARGS \
  --repo minouris/ai-devops \
  --add-label "inspected-by: inspect-ai-problem-issue"
```

This prevents duplicate analyses if the skill is triggered again on the same issue.
