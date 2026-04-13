# Submit Findings

You MUST execute all steps in this order. Do not skip any step.

## Step 1: Append Analysis Comment

You MUST have completed [compose-findings.md](compose-findings.md) before this step. Using the comment body you composed:

```
gh issue comment $ARGS \
  --repo minouris/ai-devops \
  --body "<full comment body from compose-findings.md>"
```

Record this as completed.

## Step 2: Apply New Cause Labels

For each `cause:` label identified by ai-problem-classify-causes that is **NOT already on the issue**:

```
gh issue edit $ARGS \
  --repo minouris/ai-devops \
  --add-label "cause: <label>"
```

Repeat this command for each newly identified cause label. Do not re-apply labels already present.

## Step 3: Create or Link Sub-Issues

You MUST receive the sub-issue results from ai-problem-check-sub-issues before this step.

For each cause label, you will either create a new sub-issue or link an existing one:

### When creating a new sub-issue:

Use the composed sub-issue body from ai-problem-check-sub-issues:

```
gh issue create \
  --repo minouris/ai-devops \
  --title "AI Problem: cause: <label> — <brief description of how this cause manifested>" \
  --body "<body from ai-problem-check-sub-issues>" \
  --label "cause: <label>" \
  --label "created-by: ai-problem-inspect-issue"
```

Record the new sub-issue number. Proceed to "Add as child of inspected issue" below.

### When linking an existing sub-issue:

Use the existing issue number identified by ai-problem-check-sub-issues. Do not create a new issue. Proceed to "Add as child of inspected issue" below.

### Add as child of inspected issue:

For each sub-issue (newly created or existing), you MUST link it as a child of the inspected issue:

**Step 3a:** Get the sub-issue database ID:

```
gh api /repos/minouris/ai-devops/issues/<sub_issue_number> --jq '.id'
```

Record the returned ID as `<database_id>`.

**Step 3b:** Link it as a child issue:

```
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/minouris/ai-devops/issues/$ARGS/sub_issues \
  -F sub_issue_id=<database_id>
```

**CRITICAL:** Use `-F` not `-f` for `sub_issue_id`. GitHub API requires an integer, not a string.

**Repeat Steps 3a and 3b** for every cause label. Each cause becomes a separate child issue under the inspected issue.

## Step 4: Mark As Inspected

After completing all previous steps, apply the inspection completion label:

```
gh issue edit $ARGS \
  --repo minouris/ai-devops \
  --add-label "inspected-by: ai-problem-inspect-issue"
```

This prevents duplicate analyses if the skill runs again on the same issue.

## Completion

You have finished the inspection workflow. The issue has been:
1. Analysed for rule violations and contributing factors
2. Root causes classified and labelled
3. Sub-issues checked and created/linked
4. Findings documented in a comment
5. Marked as inspected

The skill execution is complete.
