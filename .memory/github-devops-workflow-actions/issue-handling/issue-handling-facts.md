# GitHub Workflow Issues Integrations - Fact File

**Topic:** issue-handling (merged from github-workflow-issues-integrations and github-workflow-issue-filtering)

**Status:** Research in progress

---

## FINDING-2026-04-08-1

**Topic:** Triggering workflows on GitHub issue events

**Observation:**

The `issues` event in GitHub Actions triggers workflows when issues in the repository are created or modified. The event fires for multiple activity types representing different issue lifecycle changes:

**Supported activity types:**
- Creation & Modification: `opened`, `edited`, `deleted`
- State Changes: `closed`, `reopened`
- Assignments: `assigned`, `unassigned`
- Organization: `labeled`, `unlabeled`, `pinned`, `unpinned`, `transferred`
- Milestone: `milestoned`, `demilestoned`
- Additional: `locked`, `unlocked`, `typed`, `untyped`

**Default behaviour:**
By default, workflows are triggered by all activity type events. To limit triggering to specific events, use the `types` keyword in the workflow configuration.

**Configuration example to trigger only on issue creation:**
```yaml
on:
  issues:
    types: [opened]
```

**Configuration example for multiple event types:**
```yaml
on:
  issues:
    types: [opened, edited, milestoned]
```

**Critical requirement:**
The workflow file must exist on the repository's default branch for the issue event to trigger the workflow.

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Configuring permissions for issue operations in workflow jobs

**Observation:**

The `issues` permission in GitHub Actions workflow jobs controls access to repository issues. Permissions can be configured at workflow level or job level, with job-level settings overriding workflow-level settings.

**Permission levels:**
- **`issues: write`** — Allows both reading and writing to issues; includes full read access
- **`issues: read`** — Allows reading issue data only
- **`issues: none`** — Removes all issue access (explicit denial)

**Configuration at workflow level:**
```yaml
permissions:
  issues: write
```

**Configuration at job level:**
```yaml
jobs:
  my_job:
    permissions:
      issues: write
```

**Key details:**
- Writing includes reading: `issues: write` provides both read and write access
- Default permissions: Any permissions not explicitly specified default to `none`
- Minimal by default: Job-level permissions override workflow-level permissions, enabling granular control
- Use case example: An action adding a comment to an issue requires `issues: write` permission

**Source:** [GitHub Actions — Workflow Syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Issue data available in GitHub Actions workflows

**Observation:**

When a GitHub Actions workflow is triggered by the `issues` event, issue data is available through the `github.event.issue` object in the workflow context.

**Known accessible properties:**
- **`github.event.issue.number`** — The issue number (explicitly documented with example usage)
- **`github.event.issue.pull_request`** — Available for differentiating between issues and pull requests

**Implied availability (referenced but not detailed in workflow syntax documentation):**
The GitHub Actions documentation references the GraphQL API Issue object and REST API endpoints for issues for comprehensive field documentation. This indicates that additional properties exist on the issue object (such as title, body, author, labels, state, assignees, milestones, etc.) but the complete set of accessible workflow context properties is not enumerated in the workflow triggering documentation.

**Documentation structure:**
- Workflow-level issue access documented in Events that Trigger Workflows
- Complete issue schema documented in REST API and GraphQL API references
- Properties accessible in workflow context inferred from API schema

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows); [REST API — Issues](https://docs.github.com/en/rest/issues)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-4

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

