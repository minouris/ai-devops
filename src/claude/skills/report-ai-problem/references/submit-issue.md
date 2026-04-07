# Submit the Issue

Execute this flow only after the user confirms in [present-report.md](present-report.md).

## Step 1: Create or Append the Main Issue

**Create a new issue** when no existing issue matched in [compose-issue.md](compose-issue.md):

```
gh issue create \
  --repo minouris/ai-devops \
  --title "<title>" \
  --body "<body>" \
  --label "<label1>" \
  --label "<label2>"
```

Apply all `cause:` labels identified in [classify-causes.md](classify-causes.md).

Record the new issue number as `<main_issue_number>`.

**Append to an existing issue** when an existing issue matched in [compose-issue.md](compose-issue.md):

```
gh issue comment <issue-number> \
  --repo minouris/ai-devops \
  --body "<new information only>"
```

**MUST NOT** duplicate information already present in the issue or its comments.

Record the existing issue number as `<main_issue_number>`.

## Step 2: Create or Link Sub-Issues

For each `cause:` label identified in [classify-causes.md](classify-causes.md), execute one of the following based on the search results from [compose-issue.md](compose-issue.md).

### Create a new sub-issue

When no existing issue was found for this cause:

```
gh issue create \
  --repo minouris/ai-devops \
  --title "AI Problem: cause:<label> — <brief description of how this cause manifested>" \
  --body "<sub-issue body composed in compose-issue.md>" \
  --label "cause:<label>"
```

Record the new sub-issue number as `<sub_issue_number>`.

### Link existing issue as sub-issue

When an existing issue was found for this cause, use its number directly as `<sub_issue_number>`. Do not create a new issue or append a comment unless the existing issue does not already reference the main issue.

### Add as child of main issue

After creating or identifying each sub-issue, link it as a child of the main issue:

```
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/minouris/ai-devops/issues/<main_issue_number>/sub_issues \
  -f sub_issue_id=<sub_issue_number>
```

Repeat for every cause label. Each cause becomes a separate child issue under the main incident issue.
