# Submit the Issue

Execute this flow only after the user confirms in [present-report.md](present-report.md).

## Create a New Issue

When no existing issue matched in [compose-issue.md](compose-issue.md):

```
gh issue create \
  --repo minouris/ai-devops \
  --title "<title>" \
  --body "<body>" \
  --label "<label1>" \
  --label "<label2>"
```

Apply all `cause:` labels identified in [classify-causes.md](classify-causes.md).

## Append to an Existing Issue

When an existing issue matched in [compose-issue.md](compose-issue.md):

```
gh issue comment <issue-number> \
  --repo minouris/ai-devops \
  --body "<new information only>"
```

**MUST NOT** duplicate information already present in the issue or its comments.
