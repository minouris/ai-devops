# Compose Findings Comment

Compose the comment body to be appended to the inspected issue.

## Related Issues

Search for other issues concerning the same problem:

```
gh issue list \
  --repo minouris/ai-devops \
  --state open \
  --search "<incident description keyword OR rule name OR skill name>"
```

A related issue matches if it concerns the same AI behaviour, the same rule violation, or the same training trigger — regardless of label.

Record any matches: number, title, URL.

## Comment Body

Compose a comment using the following template.

**MUST NOT** name `root_cause_definitions.md` or any local file path in the composed comment — readers of the issue will not have access to these files. Paste text verbatim; do not attribute it to a file.

````markdown
## AI Problem Analysis — inspect-ai-problem-issue

### Rule Violations

<Findings from identify-violations.md — exact rule quotes, source file paths, and loophole explanation>

### Contributing Factors

<Verbatim contributing factor text — do not name the source file>

### Root Cause Classification

<Table of applied cause labels from classify-causes.md — one sentence each explaining why it applies>

| Label | Applied | Reason |
|-------|---------|--------|
| `cause: <label>` | ✓ already on issue / ✓ added now | <one sentence> |

### Related Issues

<List of related issues found above, or "No related issues found.">

### Sub-Issues

<Table from check-sub-issues.md showing action planned for each cause label>

| Cause label | Action | Existing issue |
|-------------|--------|----------------|
| `cause: <label>` | Create new sub-issue | — |
| `cause: <label>` | Link existing issue as sub-issue | #N — <title> |
````

Output of this flow is passed to [submit-findings.md](submit-findings.md).
