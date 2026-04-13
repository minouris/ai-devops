# Compose Findings Comment

Compose the comment body to append to the issue. You MUST complete every step.

## Step 1: Search for Related Issues

You MUST search for issues concerning the same problem. Execute:

```
gh issue list \
  --repo minouris/ai-devops \
  --state open \
  --search "<incident description keyword OR rule name OR skill name>"
```

Where `<incident description...>` is your best search term from the incident context.

A related issue matches if it concerns:
- The same AI behaviour
- The same rule violation
- The same training trigger

Record any matches: issue number, title, URL.

## Step 2: Compose Comment Using Template

Using the template below, compose the findings comment. You MUST include:

1. Rule violations (exact quotes and source paths from ai-problem-identify-violations results)
2. Contributing factors (verbatim quotes from ai-problem-identify-violations results)
3. Root causes (from ai-problem-classify-causes results with reasoning)
4. Related issues (from Step 1 above)
5. Sub-issues (from ai-problem-check-sub-issues results)

**Comment Template:

````markdown
## AI Problem Analysis — ai-problem-inspect-issue

### Rule Violations

<Findings from the ai-problem-identify-violations flow — exact rule quotes, source file paths, and loophole explanation>

### Contributing Factors

<Findings from the ai-problem-identify-violations flow — verbatim quotes of contributing factors where applicable>

### Root Cause Classification

<Table of applied cause labels from the ai-problem-classify-causes flow — one sentence each explaining why it applies>

| Label | Applied | Reason |
|-------|---------|--------|
| `cause: <label>` | ✓ already on issue / ✓ added now | <one sentence> |

### Related Issues

<List of related issues found above, or "No related issues found.">

### Sub-Issues

<Table from the ai-problem-check-sub-issues flow showing action planned for each cause label>

| Cause label | Action | Existing issue |
|-------------|--------|----------------|
| `cause: <label>` | Create new sub-issue | — |
| `cause: <label>` | Link existing issue as sub-issue | #N — <title> |
````

## Step 3: Pass to Submit Flow

You have completed composition. The comment body is now ready. Proceed to [submit-findings.md](submit-findings.md).
