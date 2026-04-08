# GitHub Workflow Issue Filtering - Fact File

**Topic:** github-workflow-issue-filtering

**Status:** Research in progress

---

## FINDING-2026-04-08-1

**Topic:** Using contains() function to filter jobs based on issue labels

**Observation:**

GitHub Actions provides the `contains()` function to check whether an array includes a specific item. The function returns `true` if the item is found in the array and is case-insensitive.

**Syntax for checking issue labels:**
```yaml
contains(github.event.issue.labels.*.name, 'label-name')
```

**How it works:**
- `github.event.issue.labels` — Array of label objects on the issue
- `*.name` — Object filter that extracts all label names from the labels array
- `contains(..., 'label-name')` — Checks if the extracted label names include 'label-name'
- Result is `true` if the label exists, `false` otherwise

**Job-level conditional usage:**
```yaml
jobs:
  process-labeled-issue:
    if: contains(github.event.issue.labels.*.name, 'bug')
    runs-on: ubuntu-latest
    steps:
      - run: echo "This job runs only if the issue has a 'bug' label"
```

**Case sensitivity:**
The `contains()` function is not case-sensitive, meaning 'Bug', 'BUG', and 'bug' are treated as equivalent.

**Checking for absence of a label:**
Use negation to check if a label is NOT present:
```yaml
if: '!contains(github.event.issue.labels.*.name, 'wontfix')'
```

**Source:** [GitHub Actions — Expressions](https://docs.github.com/en/actions/learn-github-actions/expressions)

**Date captured:** 2026-04-08

---

